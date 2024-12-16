import 'package:digishop/controller/customer_controller.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/screens/admin_home_screen.dart';
import 'package:digishop/widgets/admin_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constans.dart';
import '../models/Customer.dart';
import '../models/User.dart';
import '../widgets/base_widget.dart';

class AdminCustomerUpdate extends GetView<CustomerController> {
  AdminCustomerUpdate({super.key});

  final User user = Get.arguments['user'];
  final MyDb xController = Get.find<MyDb>();
  final Customer customer = Get.arguments['customer'];

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: null,
      onPressed: () {
        controller.clear();
        Future.delayed(const Duration(milliseconds: 2500), () {
          Get.offAll(
                () => AdminHomeScreen(), arguments: user,
            // صفحه مقصد
            transition: Transition.zoom,
            // نوع انیمیشن
            duration: const Duration(
                milliseconds: 500), // مدت زمان انیمیشن
          );
        });
        // Get.toNamed(AppRoutes.showAllCus,arguments: user);
      },
      bottomNavigation: null,
      child:
      AdminBaseWidget(
        textBtn: 'ویرایش اطلاعات',
        onTapButton: () async {
          if (customer.id != null) {
            var idCus =
            await controller.getIdCustomer(customer.id ?? 0);
            var result = await controller.updateCustomer(
              idCus,
              Customer(
                id: idCus,
                nameCustomer: controller.nameCustomer.value.text,
                username: controller.username.value.text,
                password: controller.password.value.text,
                email: controller.email.value.text,
                phoneNumber: controller.phoneNumber.value.text,
                wallet: controller.wallet.value.text,
                address: controller.address.value.text,
                description: customer.description,
                isDelete: 0,
                createdAt: customer.createdAt,
                updatedAt: DateTime.now().toString().split(".")[0],
                deleteStatus: 0,
              ),
            );
            if(result != 0){
              FocusScope.of(context).unfocus();
              controller.clear();
              Future.delayed(const Duration(milliseconds: 2500), () {
                Get.offAll(
                      () => AdminHomeScreen(), arguments: user,
                  // صفحه مقصد
                  transition: Transition.zoom,
                  // نوع انیمیشن
                  duration: const Duration(
                      milliseconds: 500), // مدت زمان انیمیشن
                );
              });
              // Future.delayed(const Duration(milliseconds: 2500), () {
              //   Get.off(() => ShowAllCustomers(),arguments: user, // صفحه مقصد
              //     transition: Transition.zoom,  // نوع انیمیشن
              //     duration: const Duration(milliseconds: 500), // مدت زمان انیمیشن
              //   );
              // });
            }
          }
        },
        textNavbar2: 'ویرایش اطلاعات مشتری',
        height: 290,
        paddingRight: 100,
        child1:  textFieldCustom(
            controller.username.value =
                TextEditingController(text: customer.username),
            Colors.white,
            Colors.white70,
            Colors.white,
            Colors.white38,
            'نام کاربری',
            30,
            0,
            TextAlign.right,
            20),
        child2:textFieldCustom(
            controller.password.value =
                TextEditingController(text: customer.password),
            Colors.white,
            Colors.white70,
            Colors.white,
            Colors.white38,
            'رمزعبور',
            30,
            0,
            TextAlign.right,
            20,
            readOnly: true,
            obscureText: true, onTap: () {
          dialogTextFieldCheck(
              'تغییر رمزعبور',
              'برای تغییر رمز عبور ابتدا رمز عبور قبلی را وارد کنید',
              'تایید', () async {
            Get.back();
            if (controller.changePassword.value.text.isNotEmpty) {
              controller.password.value ==
                  controller.changePassword.value;
            }
          }, 1, controller.changePassword.value);
        }),

        child3:textFieldCustom(
            controller.nameCustomer.value =
                TextEditingController(text: customer.nameCustomer),
            Colors.black87,
            kPurpleDark.withOpacity(0.7),
            kPurpleDark,
            kPurpleDark.withOpacity(0.7),
            'نام و نام خانوادگی',
            20,
            10,
            TextAlign.center,
            20),
        child4: textFieldCustom(
            controller.phoneNumber.value =
                TextEditingController(text: customer.phoneNumber),
            Colors.black87,
            kPurpleDark.withOpacity(0.7),
            kPurpleDark,
            kPurpleDark.withOpacity(0.7),
            'شماره موبایل',
            20,
            10,
            TextAlign.center,
            20),
        child5:textFieldCustom(
            controller.email.value =
                TextEditingController(text: customer.email),
            Colors.black87,
            kPurpleDark.withOpacity(0.7),
            kPurpleDark,
            kPurpleDark.withOpacity(0.7),
            'ایمیل',
            20,
            10,
            TextAlign.center,
            20),
        child6:textFieldCustom(
            controller.wallet.value =
                TextEditingController(text: customer.wallet),
            Colors.black87,
            kPurpleDark.withOpacity(0.7),
            kPurpleDark,
            kPurpleDark.withOpacity(0.7),
            'کیف پول',
            20,
            10,
            TextAlign.center,
            20),
        child7:textFieldCustom(
            controller.address.value =
                TextEditingController(text: customer.address),
            Colors.black87,
            kPurpleDark.withOpacity(0.7),
            kPurpleDark,
            kPurpleDark.withOpacity(0.7),
            'آدرس',
            20,
            10,
            TextAlign.center,
            20),
      ),
    );
  }
}
