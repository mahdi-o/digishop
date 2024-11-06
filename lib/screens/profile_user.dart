import 'package:digishop/constans.dart';
import 'package:digishop/controller/profile_controller.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/routes.dart';

class ProfileUser extends GetView<ProfileController> {
  const ProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BaseWidget(color: Colors.white,
        bottomNavigation: null,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: InkWell(
                  onTap: () async {
                    myDialog();
                  },
                  child: const Icon(
                    Icons.logout_rounded,
                    color: Colors.black,
                    size: 30,
                  )),
            ),
          ],
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.black,
              )),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                'مشخصات کاربر',
                style: TextStyle(fontSize: 35,),
              ),
              const SizedBox(
                height: 30,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 60,
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
                width: 350,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Center(
                    child: Text(
                      controller.name.value,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: 350,
                  height: 82,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35), color: kPurple),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
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
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(
                              height: 2,
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
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: 350,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: kPurpleLight),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
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
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                   ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  controller.email.value,
                                  style: TextStyle(
                                      fontSize: 17,
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
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: 350,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: kPurple),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                               '${separateDigits(int.parse(controller.wallet.value.toString()))} تومان',
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey.shade800),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onDoubleTap: ()async{
                          SharedPreferences pref =await SharedPreferences.getInstance();
                          pref.setInt('wallet', 900000000);
                        },
                        onLongPress: ()async{
                          SharedPreferences pref =await SharedPreferences.getInstance();
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

myDialog()async {
  SharedPreferences pref =
      await SharedPreferences.getInstance();
  return dialogCustom('آیا از حذف حساب کاربری اطمینان دارید؟', () {
    pref.clear();
    Get.toNamed(AppRoutes.register);
  });

}
