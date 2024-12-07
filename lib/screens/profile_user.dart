import 'package:digishop/constans.dart';
import 'package:digishop/controller/profile_controller.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/my_db.dart';
import '../models/User.dart';
import '../services/routes.dart';
import '../widgets/navbar_custom.dart';

class ProfileUser extends GetView<ProfileController> {
   ProfileUser({super.key});
  final User user = Get.arguments;

  @override
  Widget build(BuildContext context) {

    return Obx(
      () => BaseWidget(
        color: Colors.white,
        bottomNavigation: null,
        appBar: null,
        floating: FloatingActionButton(
          onPressed: () {
            Get.toNamed(AppRoutes.home,arguments: user);
          },
          elevation: 20,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.arrow_back_sharp,
            size: 33,
          ),
        ),
        floatingLocation: FloatingActionButtonLocation.startFloat,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding:
                const EdgeInsets.only(right: 20, left: 10, bottom: 20, top: 50),
                child: Column(
                  children: [
                    // ویجت NavbarCustom ثابت
                    SizedBox(
                      height: 60, // ارتفاع ثابت برای هدر
                      child: NavbarCustom(
                        text1: 'پروفایل کاربر',
                        text2: '',
                        size1: 28,
                        size2: 26,
                        fontFace1: 'lalezarPlus',
                        fontFace2: 'lalezarPlus',
                        icon1: Icons.logout_rounded,
                        onTapIcon2: () async {
                           myDialog(context);
                        },
                        icon2: null,
                      ),
                    ),
                  ],
                ),
              ),
              // const Text(
              //   'مشخصات کاربر',
              //   style: TextStyle(fontSize: 35,),
              // ),
              // const SizedBox(
              //   height: 30,
              // ),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 75,
                // backgroundImage: AssetImage('assets/images/user1.png'),
                child: Image.asset(
                  'assets/images/user3.png',
                  fit: BoxFit.cover,
                  width: 450,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: 250,
                  height: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Center(
                    child: Text(
                      controller.name.value,
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  )),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: Get.width-30,
                  height: 82,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40), color: kPurple),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 5,
                          right: 40.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'نام کاربری',
                              style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              controller.username.value,
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey.shade800),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        CupertinoIcons.person_solid,
                        size: 50,
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: Get.width-30,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: kPurpleLight),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 0,
                          right: 40.0,
                        ),
                        child: SizedBox(
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'ایمیل',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  controller.email.value,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey.shade800),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.email_rounded,
                        size: 45,
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: Get.width-30,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35), color: kPurple),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 5,
                          right: 40.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'شماره موبایل',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(controller.phoneNumber.value.toString(),
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey.shade800),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onDoubleTap: () async {
                          SharedPreferences pref =
                          await SharedPreferences.getInstance();
                          pref.setInt('phoneNumber', 900000000);
                        },
                        onLongPress: () async {
                          SharedPreferences pref =
                          await SharedPreferences.getInstance();
                          pref.setInt('phoneNumber', 0);
                        },
                        child: const Icon(
                          CupertinoIcons.phone_circle,
                          size: 45,
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: Get.width-30,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35), color: kPurpleLight),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 5,
                          right: 40.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'موجودی کیف پول',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${separateDigits(int.parse(controller.wallet.value.toString()))} تومان',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.grey.shade800),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onDoubleTap: () async {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.setInt('wallet', 900000000);
                        },
                        onLongPress: () async {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.setInt('wallet', 0);
                        },
                        child: const Icon(
                          CupertinoIcons.creditcard,
                          size: 45,
                        ),
                      ),
                      const SizedBox(
                        width: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

myDialog(context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return dialogCustom('آیا از حذف حساب کاربری اطمینان دارید؟', 16, () {
    pref.clear();
    FocusScope.of(context).unfocus();
    Get.toNamed(AppRoutes.register);
  });
}
