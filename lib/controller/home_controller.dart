import 'package:carousel_slider/carousel_controller.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/models/Product.dart';
import 'package:digishop/screens/basket_screen.dart';
import 'package:digishop/screens/home_screen.dart';
import 'package:digishop/screens/profile_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  Rx<CarouselController> controllerCarouser = CarouselController().obs;
  RxInt currentIndex = 0.obs;
  RxList<Product> listProductsBestDb = <Product>[].obs;

  List<Widget> homeWidget = [
    BasketScreen(),
    HomeScreen(),
    ProfileUser(),
  ];


  RxList<Widget> listSliderImage = <Widget>[
    ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Image.asset(
          'assets/images/slider1.jpg',
          width: 450,
          height: 300,
        )),
    ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Image.asset(
          'assets/images/slider2.jpg',
          width: 450,
          height: 300,
        )),
    ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Image.asset(
          'assets/images/slider3.jpg',
          width: 450,
          height: 300,
        )),
    ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Image.asset(
          'assets/images/slider4.jpg',
          width: 450,
          height: 300,
        )),
    ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Image.asset(
          'assets/images/slider5.jpg',
          width: 450,
          height: 300,
        )),
    ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Image.asset(
          'assets/images/slider6.jpg',
          width: 450,
          height: 300,
        )),
    ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Image.asset(
          'assets/images/slider7.jpg',
          width: 450,
          height: 300,
        )),
  ].obs;

  getProductDbForHomeScreen()async{
    listProductsBestDb.clear();
    listProductsBestDb.value = await MyDb().getProduct();
  }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
     getProductDbForHomeScreen();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    getProductDbForHomeScreen();

  }
}
