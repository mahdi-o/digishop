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
    return BaseWidget(
      color: Colors.white,
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
                        fontFamily: 'lalezar'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "مشخصاتتان را برای ساخت حساب کاربری وارد کنید",
                    style: TextStyle(fontSize: 20, fontFamily: 'lalezarPlus'),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  TextField(
                    controller: controller.name,
                    decoration: InputDecoration(
                        hintText: "نام و نام خانوادگی",
                        hintStyle:
                            const TextStyle(fontSize: 18, fontFamily: 'lalezarPlus'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(
                            Icons.drive_file_rename_outline_rounded)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: controller.username,
                    decoration: InputDecoration(
                        hintText: "نام کاربری",
                        hintStyle:
                            const TextStyle(fontSize: 18, fontFamily: 'lalezarPlus'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(Icons.person)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: controller.email,
                    decoration: InputDecoration(
                        hintText: "ایمیل",
                        hintStyle:
                            const TextStyle(fontSize: 18, fontFamily: 'lalezarPlus'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(Icons.email)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: controller.phoneNumber,
                    decoration: InputDecoration(
                        hintText: "شماره موبایل",
                        hintStyle:
                        const TextStyle(fontSize: 18, fontFamily: 'lalezarPlus'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(Icons.phone)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: controller.password,
                    decoration: InputDecoration(
                      hintText: "رمزعبور",
                      hintStyle:
                          const TextStyle(fontSize: 18, fontFamily: 'lalezarPlus'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(Icons.password),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: controller.passwordAgain,
                    decoration: InputDecoration(
                      hintText: "تکرار رمزعبور",
                      hintStyle:
                      const TextStyle(fontSize: 18, fontFamily: 'lalezarPlus'),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(Icons.password),
                    ),
                    obscureText: true,
                  ),
                ],
              ),
              Column(children: [
                CustomButton(
                  colorBtn: Colors.white,
                  textBtn: 'ثبت نام',
                  textColor: kPurpleDark,
                  fontBtn: 'lalezarPlus',
                  fontSizeBtn: 30,
                  shadowColor: kPurpleDark,
                  onTapped: () {
                    controller.registerUser();
                  },
                  splashColor: kPurpleDark,
                  borderColor: kPurpleDark,
                  widthBtn: 330,
                  heightBtn: 65,
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "از قبل حساب کاربری دارید؟",
                      style: TextStyle(fontSize: 18, fontFamily: 'lalezarPlus'),
                    ),
                    TextButton(
                        onPressed: () {
                          User user = User();
                          FocusScope.of(context).unfocus();
                          Get.toNamed(AppRoutes.login,
                              arguments: user,
                              parameters: {'username': '', 'registerOne': 'yes'});
                        },
                        child: const Text(
                          "ورود",
                          style: TextStyle(color: kPurpleDark, fontSize: 20, fontFamily: 'lalezarPlus'),
                        ))
                  ],
                )
              ],)
            ],
          ),
        ),
      ),
    );
  }
}
