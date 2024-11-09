import 'package:digishop/constans.dart';
import 'package:digishop/controller/register_login_controller.dart';
import 'package:digishop/models/User.dart';
import 'package:digishop/services/routes.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/custom_button.dart';

class SignupPage extends GetView<RegisterLoginController> {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(color: Colors.white,
      bottomNavigation: null,
      appBar: null,
      child: SingleChildScrollView(
            child: Container(
              color: kPurple,
              padding: const EdgeInsets.symmetric(horizontal: 35),
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const Column(
                    children: <Widget>[
                      SizedBox(height: 50.0),

                      Text(
                        "ثبت نام",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "مشخصاتتان را برای ساخت حساب کاربری وارد کنید",
                        style: TextStyle(fontSize: 18, ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      TextField(
                        controller: controller.name,
                        decoration: InputDecoration(
                            hintText: "نام و نام خانوادگی",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor:Colors.white,
                            filled: true,
                            prefixIcon: const Icon(Icons.drive_file_rename_outline_rounded)),
                      ),

                      const SizedBox(height: 18),
                      TextField(
                        controller: controller.username,
                        decoration: InputDecoration(
                            hintText: "نام کاربری",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor:Colors.white,
                            filled: true,
                            prefixIcon: const Icon(Icons.person)),
                      ),

                      const SizedBox(height: 18),

                      TextField(
                        controller:  controller.email,
                        decoration: InputDecoration(
                            hintText: "ایمیل",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none),
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Icon(Icons.email)),
                      ),

                      const SizedBox(height: 18),

                      TextField(
                       controller:  controller.password,
                        decoration: InputDecoration(
                          hintText: "رمزعبور",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: const Icon(Icons.password),
                        ),
                        obscureText: true,
                      ),

                      const SizedBox(height: 18),

                      TextField(
                        controller:  controller.passwordAgain,
                        decoration: InputDecoration(
                          hintText: "تکرار رمزعبور",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none),
                          fillColor:Colors.white,
                          filled: true,
                          prefixIcon: const Icon(Icons.password),
                        ),
                        obscureText: true,
                      ),
                    ],
                  ),
                  CustomButton(
                    colorBtn: Colors.white,
                    textBtn: 'ثبت نام',
                    textColor: kPurpleDark,
                    fontBtn: 'lalezarPlus',
                    fontSizeBtn: 28,
                    shadowColor: kPurpleDark,
                    onTapped: () {
                      controller.registerUser();
                    },
                    splashColor: kPurpleDark,
                    borderColor: kPurpleDark,
                    widthBtn: 330,
                    heightBtn: 65,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("از قبل حساب کاربری دارید؟",style: TextStyle(fontSize: 18),),
                      TextButton(
                          onPressed: () {
                            User user = User();
                            Get.toNamed(AppRoutes.login,arguments: user,parameters: {'username':'','registerOne':'yes'});
                          },
                          child: const Text("ورود", style: TextStyle(color:kPurpleDark,fontSize: 20),)
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
    );
  }
}