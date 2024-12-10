import 'package:digishop/controller/customer_controller.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/screens/show_all_customers.dart';
import 'package:digishop/services/routes.dart';
import 'package:digishop/widgets/admin_base_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constans.dart';
import '../models/Customer.dart';
import '../models/User.dart';
import '../widgets/base_widget.dart';
import '../widgets/custom_button.dart';
import '../widgets/navbar_custom.dart';

class AdminCustomerUpdate extends GetView<CustomerController> {
  AdminCustomerUpdate({super.key});

  final User user = Get.arguments['user'];
  final MyDb xController = Get.find<MyDb>();
  final Customer customer = Get.arguments['customer'];

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: null,
      floatingLocation: FloatingActionButtonLocation.startFloat,
      floating: FloatingActionButton(
        onPressed: () {
          controller.clear();
          Get.toNamed(AppRoutes.showAllCus,arguments: user);
        },
        elevation: 20,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.arrow_back_sharp,
          size: 33,
        ),
      ),
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
                  const Padding(
                    padding: EdgeInsets.only(right: 105, left: 10),
                    child: Column(
                      children: [
                        // ویجت NavbarCustom ثابت
                        SizedBox(
                          height: 50, // ارتفاع ثابت برای هدر
                          child: NavbarCustom(
                            text1: '',
                            text2: 'ویرایش اطلاعات مشتری',
                            colorText2: Colors.white,
                            size1: 28,
                            size2: 26,
                            fontFace1: 'lalezarPlus',
                            fontFace2: 'lalezarPlus',
                            icon1: null,
                            icon2: null,
                          ),
                        ),
                        // محتوای اسکرول‌شونده
                      ],
                    ),
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
                      0,
                      TextAlign.right,
                      20),
                  const SizedBox(
                    height: 10,
                  ),
                  textFieldCustom(
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
                ],
              ),
              const SizedBox(
                height: 20,
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
                        Future.delayed(const Duration(milliseconds: 2500), () {
                          Get.off(() => ShowAllCustomers(),arguments: user, // صفحه مقصد
                            transition: Transition.zoom,  // نوع انیمیشن
                            duration: const Duration(milliseconds: 500), // مدت زمان انیمیشن
                          );
                        });
                      }
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
