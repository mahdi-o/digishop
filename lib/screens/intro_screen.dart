import 'package:digishop/constans.dart';
import 'package:digishop/controller/register_login_controller.dart';
import 'package:digishop/services/routes.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:digishop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/User.dart';


class IntroScreen extends GetView<RegisterLoginController> {
   IntroScreen({super.key});
  User user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return BaseWidget(color: Colors.white,
      bottomNavigation: null,
      appBar: null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 100),
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300, width: 2),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(100)),
                        color: Colors.white),
                    child: const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.black12,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 45.0),
                    child: RichText(
                      text: const TextSpan(
                        text: 'فروشگاه ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kPurpleDark,
                            fontSize: 38,fontFamily: 'Titr'),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'دیجیتال',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,fontFamily: 'Titr')),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        'خوشحالیم که تصمیم گرفتید به ما بپیوندید',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Center(
                      child: Text(
                        'بهترین مجموعه لوازم دیجیتالی در یک برنامه',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 2,),
                    const Center(
                      child: Text(
                        'خرید در انتظار شماست',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Image.asset(
                      'assets/images/splash1.png',
                      width: 350,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      height: 75,
                    ),
                    CustomButton(
                      colorBtn: Colors.white,
                      textBtn: 'برو بریم!',
                      textColor: kPurpleDark,
                      fontBtn: 'yekanBakh',
                      fontSizeBtn: 25,
                      shadowColor: kPurpleDark,
                      onTapped: () {
                       Get.toNamed(AppRoutes.home,arguments: user);
                        },
                      splashColor: kPurpleDark,
                      borderColor: kPurpleDark,
                      widthBtn: 330,
                      heightBtn: 65,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
