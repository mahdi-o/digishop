import 'package:digishop/controller/customer_controller.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/services/routes.dart';
import 'package:digishop/widgets/admin_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constans.dart';
import '../models/Customer.dart';
import '../widgets/base_widget.dart';
import '../widgets/custom_button.dart';

class AdminCustomerUpdate extends GetView<CustomerController> {
  AdminCustomerUpdate({super.key});

  final String mapData = Get.parameters['username']!;

  MyDb xController = Get.find<MyDb>();
  final Customer customer = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: null,
      bottomNavigation: null,
      color: Colors.grey.shade300,
      child: AdminBaseWidget(
        height: 310,
        color: Colors.white,
        childWidget: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                        padding: const EdgeInsets.only(right: 20.0, left: 60),
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
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
                        child: const Text('ویرایش اطلاعات مشتری',
                            style:
                                TextStyle(fontSize: 26, color: Colors.white)),
                      )),
                    ],
                  ),
                  textFieldCustom(
                      controller.username.value =
                          TextEditingController(text: customer.username),
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
                      controller.password.value =
                          TextEditingController(text: customer.password),
                      Colors.white,
                      Colors.white70,
                      Colors.white,
                      Colors.white38,
                      'رمزعبور',
                      30,
                      7,
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
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              textFieldCustom(
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
              textFieldCustom(
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
              textFieldCustom(
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
              textFieldCustom(
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
              textFieldCustom(
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
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: CustomButton(
                  colorBtn: Colors.white,
                  textBtn: 'ویرایش اطلاعات',
                  textColor: kPurpleDark,
                  fontBtn: 'lalezar',
                  fontSizeBtn: 26,
                  shadowColor: kPurpleDark,
                  onTapped: () async {
                    if (customer.id != null) {
                      print(customer.id);
                      print('customer id id id id id id id');
                      var idCus =
                          await xController.getIdCustomer(customer.id ?? 0);
                      await xController.updateCustomer(
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
                          ));
                      FocusScope.of(context).unfocus();
                      Get.snackbar(
                          '',
                          '',
                          titleText: const Text(
                            'ویرایش اطلاعات',
                            style: TextStyle(fontSize: 18, color: kPurpleDark),
                          ),
                          messageText: const Text(
                            'اطلاعات مشتری با موفقیت ویرایش شد',
                            style: TextStyle(fontSize: 18, color: kPurpleDark),
                          ),
                          backgroundColor: Colors.white,
                          colorText: kPinkDark,
                          duration: const Duration(seconds: 1)
                      );
                      Future.delayed(
                        const Duration(seconds: 2),
                            () {
                          Get.toNamed(
                            AppRoutes.showAllCus,
                            parameters: {'username': mapData},
                          );
                        },
                      );
                    } else {
                      Get.snackbar(
                        'عملیات ناموفق',
                        'ویرایش اطلاعات با مشکل مواجه شد',
                        backgroundColor: kRedLight,
                        colorText: Colors.white,
                        icon: const Icon(
                          Icons.remove_shopping_cart_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                        shouldIconPulse: false,
                      );
                    }

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
