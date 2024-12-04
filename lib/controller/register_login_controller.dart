import 'package:digishop/constans.dart';
import 'package:digishop/models/User.dart';
import 'package:digishop/services/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterLoginController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordAgain = TextEditingController();
  TextEditingController usernameLogin = TextEditingController();
  TextEditingController passwordLogin = TextEditingController();
  User user = User();
  int accessR = 0;
  String registerOne = '';

  registerUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (name.text == null ||
        name.text == '' ||
        name.text.isEmpty ||
        name.text != name.text.trim()) {
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'خطا',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        messageText: const Text(
          'نام وارد نشده است',
          style: TextStyle(color: Colors.white),
        ),
        duration: const Duration(milliseconds: 1500),
        backgroundColor: kRedLight,
      );
    } else {
      pref.setString('name', name.text.trim());
      if (username.text == null ||
          username.text == '' ||
          username.text.isEmpty ||
          username.text != username.text.trim()) {
        Get.snackbar(
          '',
          '',
          titleText: const Text(
            'خطا',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          messageText: const Text(
            'نام کاربری وارد نشده است',
            style: TextStyle(color: Colors.white),
          ),
          duration: const Duration(milliseconds: 1500),
          backgroundColor: kRedLight,
        );
      } else {
        pref.setString('username', username.text);
        if (email.text == null ||
            email.text == '' ||
            email.text.isEmpty ||
            email.text.isNum ||
            !email.text.isEmail) {
          Get.snackbar(
            '',
            '',
            titleText: const Text(
              'خطا',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            messageText: const Text(
              'ایمیل در قالب صحیح وارد نشده است',
              style: TextStyle(color: Colors.white),
            ),
            duration: const Duration(milliseconds: 1500),
            backgroundColor: kRedLight,
          );
        } else {
          pref.setString('email', email.text);
          if (phoneNumber.text == null ||
              phoneNumber.text == '' ||
              phoneNumber.text.isEmpty ||
              phoneNumber.text != phoneNumber.text.trim()) {
            Get.snackbar(
              '',
              '',
              titleText: const Text(
                'خطا',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              messageText: const Text(
                'شماره موبایل وارد نشده است',
                style: TextStyle(color: Colors.white),
              ),
              duration: const Duration(milliseconds: 1500),
              backgroundColor: kRedLight,
            );
          } else {
            pref.setString('phoneNumber', phoneNumber.text.trim());
            if (password.text == null ||
                password.text == '' ||
                password.text.isEmpty ||
                password.text.length < 8) {
              Get.snackbar(
                '',
                '',
                titleText: const Text(
                  'خطا',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                messageText: const Text(
                  'رمزعبور نباید کمتر از 8 کاراکتر باشد',
                  style: TextStyle(color: Colors.white),
                ),
                duration: const Duration(milliseconds: 1500),
                backgroundColor: kRedLight,
              );
            } else {
              if (passwordAgain.text == null ||
                  password.text == '' ||
                  password.text.isEmpty ||
                  password.text.length < 8) {
                Get.snackbar(
                  '',
                  '',
                  titleText: const Text(
                    'خطا',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  messageText: const Text(
                    'تکرار رمزعبور وارد نشده است',
                    style: TextStyle(color: Colors.white),
                  ),
                  duration: const Duration(milliseconds: 1500),
                  backgroundColor: kRedLight,
                );
              } else {
                if (password.text != passwordAgain.text) {
                  Get.snackbar(
                    '',
                    '',
                    titleText: const Text(
                      'خطا',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    messageText: const Text(
                      'رمزعبور با تکرار آن برابر نمی باشد',
                      style: TextStyle(color: Colors.white),
                    ),
                    duration: const Duration(milliseconds: 1500),
                    backgroundColor: kRedLight,
                  );
                } else {
                  pref.setString('password', password.text);
                  accessR = 1;
                  pref.setInt('access', accessR);
                  if (accessR == 1) {
                    pref.setInt('wallet', 0);
                    pref.setString('imageAddress', '');
                    user.name = name.text;
                    user.email = email.text;
                    user.phoneNumber = phoneNumber.text;
                    user.username = username.text;
                    user.wallet = 0;
                    Get.offAndToNamed(AppRoutes.login,
                        arguments: user,
                        parameters: {
                          'username': '$username',
                          'registerOne': 'yes'
                        });
                  }
                }
              }
            }
          }
        }
      }
    }
  }

  loginUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String usernamePref = pref.getString('username') ?? '';
    String passwordPref = pref.getString('password') ?? '';
    if (usernameLogin.text != usernamePref) {
      usernameLogin.clear();
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'خطا',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        messageText: const Text(
          'نام کاربری صحیح نمی باشد',
          style: TextStyle(color: Colors.white),
        ),
        duration: const Duration(milliseconds: 1500),
        backgroundColor: kRedLight,
      );
    } else if (passwordLogin.text != passwordPref) {
      passwordLogin.clear();
      Get.snackbar(
        '',
        '',
        titleText: const Text(
          'خطا',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        messageText: const Text(
          'رمزعبور صحیح نمی باشد',
          style: TextStyle(color: Colors.white),
        ),
        duration: const Duration(milliseconds: 1500),
        backgroundColor: kRedLight,
      );
    } else {
      user.username = usernamePref;
      passwordLogin.clear();
      passwordAgain.clear();
      password.clear();
      name.clear();
      username.clear();
      usernameLogin.clear();
      email.clear();
      phoneNumber.clear();
      Get.offAndToNamed(registerOne != 'yes' ? AppRoutes.home : AppRoutes.intro,
          arguments: user,
          parameters: {'username': usernamePref, 'registerOne': 'yes'});
    }
  }
}
