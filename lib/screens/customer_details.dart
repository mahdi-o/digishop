import 'package:digishop/constans.dart';
import 'package:digishop/models/Customer.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:digishop/widgets/row_details_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/basket_controller.dart';
import '../models/User.dart';
import '../services/routes.dart';
import '../widgets/navbar_custom.dart';

class CustomerDetails extends StatelessWidget {
   CustomerDetails ({super.key});
  final Customer customer = Get.arguments['customer'];
  final User user = Get.arguments['user'];

  BasketController basket = BasketController();
  @override
  Widget build(BuildContext context) {
    double height = Get.height;

    return BaseWidget(color: Colors.white,
      bottomNavigation: null,
      appBar:null,
      floatingLocation: FloatingActionButtonLocation.startFloat,
      floating: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.showAllCus,arguments: user);

        },
        elevation: 20,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.arrow_back_sharp,
          size: 33,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding:
            EdgeInsets.only(right: height/7.5, left: 0, bottom: 0, top: 50),
            child: const Column(

              children: [
                // ویجت NavbarCustom ثابت
                SizedBox(
                  height: 60, // ارتفاع ثابت برای هدر
                  child: NavbarCustom(
                    text1: 'مشخصات مشتری',
                    text2: '',
                    size1: 28,
                    size2: 26,
                    fontFace1: 'lalezarPlus',
                    fontFace2: 'lalezarPlus',
                    icon1: null,
                    icon2: null,
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  const Divider(endIndent: 0.9,indent: 0.2,thickness: 0.4,color: Colors.grey,height: 1.5),
                   const SizedBox(height: 35,),
                  Center(
                      child: GestureDetector(
                        onTap: () async {
                          await basket.getDataBaskets();
                        },
                        child:Image.asset(
                          'assets/images/user3.png',
                          fit: BoxFit.cover,
                          width: 200,
                        ),
                      )),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Center(
                          child: Text(
                        customer.username.toString(),
                            style: const TextStyle(fontSize: 32, color: kPinkDark),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 5,),
                      RowDetailsModels(
                          typeRow: 'customer', title: 'نام و نام خانوادگی', body:customer.nameCustomer.toString()),
                      RowDetailsModels(
                          typeRow: 'customer',title: 'آدرس ایمیل', body:customer.email.toString()),
                      RowDetailsModels(
                          typeRow: 'customer', title: 'شماره موبایل', body:customer.phoneNumber.toString()),
                      RowDetailsModels(
                          typeRow: 'customer',title: 'آدرس', body:customer.address.toString()),
                      RowDetailsModels(
                          typeRow: 'customer',title: 'تاریخ عضویت', body:customer.createdAt.toString().substring(0,11)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
