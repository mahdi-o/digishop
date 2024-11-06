import 'package:digishop/controller/basket_controller.dart';
import 'package:digishop/controller/customer_controller.dart';
import 'package:digishop/controller/home_controller.dart';
import 'package:digishop/controller/invoice_controller.dart';
import 'package:digishop/controller/mysearch_controller.dart';
import 'package:digishop/controller/product_controller.dart';
import 'package:digishop/controller/profile_controller.dart';
import 'package:digishop/controller/register_login_controller.dart';
import 'package:digishop/controller/splash_controller.dart';
import 'package:digishop/database/my_db.dart';
import 'package:get/get.dart';

class AppBinding implements Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SplashController>(() =>SplashController());
    Get.lazyPut<HomeController>(() =>HomeController(),fenix: true);
    Get.lazyPut<ProductController>(() =>ProductController(),fenix: true);
    Get.lazyPut<RegisterLoginController>(() => RegisterLoginController(),fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(),fenix: true);
    Get.lazyPut<MySearchController>(() => MySearchController(),fenix: true);
    Get.lazyPut<BasketController>(() => BasketController(),fenix: true);
    Get.lazyPut<CustomerController>(() => CustomerController(),fenix: true);
    Get.lazyPut<InvoiceController>(() => InvoiceController(),fenix: true);
    Get.lazyPut<MyDb>(() => MyDb(),fenix: true);





  }

}