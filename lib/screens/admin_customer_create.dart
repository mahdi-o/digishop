import 'package:digishop/constans.dart';
import 'package:digishop/controller/customer_controller.dart';
import 'package:digishop/widgets/admin_base_widget.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/User.dart';
import '../services/routes.dart';

class AdminCustomerCreate extends GetView<CustomerController> {
  AdminCustomerCreate({super.key});
  final User user = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      color: Colors.grey.shade300,
      appBar: null,
      bottomNavigation: null,
      onPressed: () {
        controller.clear();
        Get.toNamed(AppRoutes.adminHome,arguments: user);
      },
      child: AdminBaseWidget(
        onTapButton:()async{
          await controller.addCustomer(
              controller.nameCustomer.value.text,
              controller.username.value.text,
              controller.password.value.text,
              controller.email.value.text,
              controller.phoneNumber.value.text,
              controller.wallet.value.text,
              controller.address.value.text,
              '');
        } ,
        textNavbar2: 'ثبت مشتری جدید',
        textBtn: 'افزودن مشتری',
        height: 310,
        paddingRight: 135,
        child1: textFieldCustom(
            controller.username.value, Colors.white,
            Colors.white70, Colors.white, Colors.white38,
            'نام کاربری', 30, 0, TextAlign.right, 20),
        child2: textFieldCustom(
            controller.password.value, Colors.white, Colors.white70,
            Colors.white, Colors.white38, 'رمزعبور',
            30, 7, TextAlign.right, 20),
        child3: textFieldCustom(
            controller.nameCustomer.value,
            Colors.black87, kPurpleDark.withOpacity(0.7),
            kPurpleDark, kPurpleDark.withOpacity(0.7),
            'نام و نام خانوادگی', 20, 10, TextAlign.center, 20),
        child4: textFieldCustom(
            controller.phoneNumber.value,
            Colors.black87, kPurpleDark.withOpacity(0.7), kPurpleDark,
            kPurpleDark.withOpacity(0.7),
            'شماره موبایل', 20, 10, TextAlign.center, 20),
        child5: textFieldCustom(
            controller.email.value, Colors.black87,
            kPurpleDark.withOpacity(0.7), kPurpleDark,
            kPurpleDark.withOpacity(0.7), 'ایمیل', 20, 10, TextAlign.center, 20),
        child6:   textFieldCustom(
            controller.wallet.value, Colors.black87,
            kPurpleDark.withOpacity(0.7), kPurpleDark,
            kPurpleDark.withOpacity(0.7),
            'کیف پول', 20, 10, TextAlign.center, 20),
        child7: textFieldCustom(
            controller.address.value,
            Colors.black87, kPurpleDark.withOpacity(0.7),
            kPurpleDark, kPurpleDark.withOpacity(0.7),
            'آدرس', 20, 10, TextAlign.center, 20),
      ),
    );
  }
}
