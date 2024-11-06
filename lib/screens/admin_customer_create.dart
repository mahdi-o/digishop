import 'package:digishop/constans.dart';
import 'package:digishop/controller/customer_controller.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/widgets/admin_base_widget.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:digishop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminCustomerCreate extends GetView<CustomerController> {
  AdminCustomerCreate({super.key});

  MyDb xController = Get.find<MyDb>();

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: null,
      bottomNavigation: null,
      color: Colors.grey.shade300,
      child: AdminBaseWidget(
        height: 300,
        color: Colors.white,
        childWidget: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Column(children: [
              const SizedBox(
                height: 60,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0, left: 90),
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Center(
                          child: GestureDetector(
                        onTap: () async {
                          var result = await xController.readCustomers();
                          print(result);
                        },
                        child: const Text('افزودن مشتری',
                            style:
                                TextStyle(fontSize: 27, color: Colors.white)),
                      )),
                    ],
                  ),
                  textFieldCustom(
                      controller.username.value,
                      Colors.white,
                      Colors.white70,
                      Colors.white,
                      Colors.white38,
                      'نام کاربری',
                      30,
                      7,
                      TextAlign.right,
                      20),
                  textFieldCustom(
                      controller.password.value,
                      Colors.white,
                      Colors.white70,
                      Colors.white,
                      Colors.white38,
                      'رمزعبور',
                      30,
                      7,
                      TextAlign.right,
                      20),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              textFieldCustom(
                  controller.name.value,
                  Colors.black87,
                  kPurpleDark.withOpacity(0.7),
                  kPurpleDark,
                  kPurpleDark.withOpacity(0.7),
                  'نام و نام خانوادگی',
                  20,
                  10,
                  TextAlign.center,
                  20),
              textFieldCustom(
                  controller.phoneNumber.value,
                  Colors.black87,
                  kPurpleDark.withOpacity(0.7),
                  kPurpleDark,
                  kPurpleDark.withOpacity(0.7),
                  'شماره موبایل',
                  20,
                  10,
                  TextAlign.center,
                  20),
              textFieldCustom(
                  controller.email.value,
                  Colors.black87,
                  kPurpleDark.withOpacity(0.7),
                  kPurpleDark,
                  kPurpleDark.withOpacity(0.7),
                  'ایمیل',
                  20,
                  10,
                  TextAlign.center,
                  20),
              textFieldCustom(
                  controller.wallet.value,
                  Colors.black87,
                  kPurpleDark.withOpacity(0.7),
                  kPurpleDark,
                  kPurpleDark.withOpacity(0.7),
                  'کیف پول',
                  20,
                  10,
                  TextAlign.center,
                  20),
              textFieldCustom(
                  controller.address.value,
                  Colors.black87,
                  kPurpleDark.withOpacity(0.7),
                  kPurpleDark,
                  kPurpleDark.withOpacity(0.7),
                  'آدرس',
                  20,
                  10,
                  TextAlign.center,
                  20),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: CustomButton(
                  colorBtn: Colors.white,
                  textBtn: 'افزودن مشتری',
                  textColor: kPurpleDark,
                  fontBtn: 'lalezar',
                  fontSizeBtn: 26,
                  shadowColor: kPurpleDark,
                  onTapped: () async {
                    await xController.addCustomer(
                        controller.name.value.text,
                        controller.username.value.text,
                        controller.password.value.text,
                        controller.email.value.text,
                        controller.phoneNumber.value.text,
                        controller.wallet.value.text,
                        controller.address.value.text,
                        ''
                    );
                    Get.snackbar(
                      '',
                      '',
                      titleText: const Text(
                        'ثبت مشتری',style: TextStyle(fontSize: 18,color: kPurpleDark),
                      ),
                      messageText: const Text(
                        'اطلاعات مشتری با موفقیت ثبت شد',
                        style: TextStyle(fontSize: 18,color: kPurpleDark), ),
                      backgroundColor: Colors.white,
                      colorText: kPinkDark,
                    );
                    controller.clear();
                  },
                  splashColor: kPurpleDark,
                  borderColor: kPurpleDark,
                  widthBtn: 330,
                  heightBtn: 65,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
