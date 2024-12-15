import 'package:digishop/constans.dart';
import 'package:digishop/controller/customer_controller.dart';
import 'package:digishop/widgets/admin_base_widget.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:digishop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/User.dart';
import '../services/routes.dart';
import '../widgets/navbar_custom.dart';

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
        height: 310,
        color: Colors.white,
        childWidget: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: Get.height,
            child: Column(children: [
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  const Padding(
                    padding:
                    EdgeInsets.only(right: 135, left: 10),
                    child: Column(
                      children: [
                        // ویجت NavbarCustom ثابت
                        SizedBox(
                          height: 50, // ارتفاع ثابت برای هدر
                          child: NavbarCustom(
                            text1: '',
                            text2: 'ثبت مشتری جدید',
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
                      controller.username.value, Colors.white,
                      Colors.white70, Colors.white, Colors.white38,
                      'نام کاربری', 30, 0, TextAlign.right, 20),
                  textFieldCustom(
                      controller.password.value, Colors.white, Colors.white70,
                      Colors.white, Colors.white38, 'رمزعبور',
                      30, 7, TextAlign.right, 20),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              textFieldCustom(
                  controller.nameCustomer.value,
                  Colors.black87, kPurpleDark.withOpacity(0.7),
                  kPurpleDark, kPurpleDark.withOpacity(0.7),
                  'نام و نام خانوادگی', 20, 10, TextAlign.center, 20),
              textFieldCustom(
                  controller.phoneNumber.value,
                  Colors.black87, kPurpleDark.withOpacity(0.7), kPurpleDark,
                  kPurpleDark.withOpacity(0.7),
                  'شماره موبایل', 20, 10, TextAlign.center, 20),
              textFieldCustom(
                  controller.email.value, Colors.black87,
                  kPurpleDark.withOpacity(0.7), kPurpleDark,
                  kPurpleDark.withOpacity(0.7), 'ایمیل', 20, 10, TextAlign.center, 20),
              textFieldCustom(
                  controller.wallet.value, Colors.black87,
                  kPurpleDark.withOpacity(0.7), kPurpleDark,
                  kPurpleDark.withOpacity(0.7),
                  'کیف پول', 20, 10, TextAlign.center, 20),
              textFieldCustom(
                  controller.address.value,
                  Colors.black87, kPurpleDark.withOpacity(0.7),
                  kPurpleDark, kPurpleDark.withOpacity(0.7),
                  'آدرس', 20, 10, TextAlign.center, 20),
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

                   // var result =
                   await controller.addCustomer(
                        controller.nameCustomer.value.text,
                        controller.username.value.text,
                        controller.password.value.text,
                        controller.email.value.text,
                        controller.phoneNumber.value.text,
                        controller.wallet.value.text,
                        controller.address.value.text,
                        '');


                    // if(result != 0){
                    //   // Future.delayed(const Duration(milliseconds: 2500), () {
                    //   //   Get.off(() => AdminHomeScreen(),arguments: user, // صفحه مقصد
                    //   //     transition: Transition.zoom,  // نوع انیمیشن
                    //   //     duration: const Duration(milliseconds: 500), // مدت زمان انیمیشن
                    //   //   );
                    //   // });
                    //   // controller.clear();
                    // }
                  },
                  splashColor: kPurpleDark,
                  borderColor: kPurpleDark,
                  widthBtn: 330,
                  heightBtn: 65,),
              ),
            ],),
          ),
        ),
      ),
    );
  }
}
