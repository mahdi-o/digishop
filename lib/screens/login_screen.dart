import 'package:digishop/constans.dart';
import 'package:digishop/controller/register_login_controller.dart';
import 'package:digishop/models/User.dart';
import 'package:digishop/services/routes.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:digishop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<RegisterLoginController> {
   LoginPage({super.key});
final String registerOne = Get.parameters['registerOne']!;
   User user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(color: Colors.white,
      bottomNavigation: null,
      appBar: null,
      child: Container(
        color: kPurple,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(
                    height: 160,
                  ),

                  const Text(
                    "ورود",
                    style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("اطلاعات را برای ورود به حساب خود وارد کنید",style: TextStyle(fontSize: 20)),
                  const SizedBox(
                    height: 60,
                  ),
                  TextField(
                    controller:controller.usernameLogin,
                    decoration: InputDecoration(
                        hintText: "نام کاربری",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(Icons.person)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller:controller.passwordLogin,
                    decoration: InputDecoration(
                      hintText: "رمز عبور",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide:BorderSide.none),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(Icons.password),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 60),
                  CustomButton(
                    colorBtn: Colors.white,
                    textBtn: 'ورود',
                    textColor: kPurpleDark,
                    fontBtn: 'lalezarPlus',
                    fontSizeBtn: 28,
                    shadowColor: kPurpleDark,
                    onTapped: () {
                      controller.registerOne = registerOne;
                      controller.loginUser();
                    },
                    splashColor: kPurpleDark,
                    borderColor: kPurpleDark,
                    widthBtn: 330,
                    heightBtn: 65,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("حساب کاربری ندارید؟",style: TextStyle(fontSize: 18),),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.register);
                        },
                        child: const Text(
                          "ثبت نام",
                          style: TextStyle(color: kPurpleDark,fontSize: 20),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
