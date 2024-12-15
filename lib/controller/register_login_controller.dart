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
      mySnackBar(false, true, 'نام وارد نشده است');
    } else {
      pref.setString('name', name.text.trim());
      if (username.text == null ||
          username.text == '' ||
          username.text.isEmpty ||
          username.text != username.text.trim()) {
        mySnackBar(false, true, 'نام کاربری وارد نشده است');
      } else {
        pref.setString('username', username.text);
        if (email.text == null ||
            email.text == '' ||
            email.text.isEmpty ||
            email.text.isNum ||
            !email.text.isEmail) {
          mySnackBar(false, true, 'ایمیل در قالب صحیح وارد نشده است');
        } else {
          pref.setString('email', email.text);
          if (phoneNumber.text == null ||
              phoneNumber.text == '' ||
              phoneNumber.text.isEmpty ||
              phoneNumber.text != phoneNumber.text.trim()) {
            mySnackBar(false, true, 'شماره موبایل وارد نشده است');
          } else {
            pref.setString('phoneNumber', phoneNumber.text.trim());
            if (password.text == null ||
                password.text == '' ||
                password.text.isEmpty ||
                password.text.length < 8) {
              mySnackBar(false, true, 'رمزعبور نباید کمتر از 8 کاراکتر باشد');
            } else {
              if (passwordAgain.text == null ||
                  password.text == '' ||
                  password.text.isEmpty ||
                  password.text.length < 8) {
                mySnackBar(false, true, 'تکرار رمزعبور وارد نشده است');
              } else {
                if (password.text != passwordAgain.text) {
                  mySnackBar(false, true, 'رمزعبور با تکرار آن برابر نمی باشد');
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
      mySnackBar(false, true, 'نام کاربری صحیح نمی باشد');
    } else if (passwordLogin.text != passwordPref) {
      passwordLogin.clear();
      mySnackBar(false, true, 'رمزعبور صحیح نمی باشد');
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
