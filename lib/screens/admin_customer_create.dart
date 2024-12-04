// import 'package:digishop/constans.dart';
// import 'package:digishop/controller/customer_controller.dart';
// import 'package:digishop/database/my_db.dart';
// import 'package:digishop/widgets/admin_base_widget.dart';
// import 'package:digishop/widgets/base_widget.dart';
// import 'package:digishop/widgets/custom_button.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class AdminCustomerCreate extends GetView<CustomerController> {
//   AdminCustomerCreate({super.key});
//
//   MyDb xController = Get.find<MyDb>();
//
//   @override
//   Widget build(BuildContext context) {
//     return BaseWidget(
//       appBar: null,
//       bottomNavigation: null,
//       color: Colors.grey.shade300,
//       child: AdminBaseWidget(
//         height: 310,
//         color: Colors.white,
//         childWidget: SingleChildScrollView(
//           physics: BouncingScrollPhysics(),
//           child: SizedBox(
//             height: Get.height,
//             child: Column(children: [
//               const SizedBox(
//                 height: 60,
//               ),
//               Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(right: 20.0, left: 100),
//                         child: GestureDetector(
//                           onTap: () {
//                             FocusScope.of(context).unfocus();
//                             Get.back();
//                           },
//                           child: const Icon(
//                             Icons.arrow_back_outlined,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                       Center(
//                           child: GestureDetector(
//                         onTap: () async {
//                           var result = await xController.readCustomers();
//                           print(result);
//                         },
//                         child: const Text('افزودن مشتری',
//                             style:
//                                 TextStyle(fontSize: 26, color: Colors.white)),
//                       )),
//                     ],
//                   ),
//                   textFieldCustom(
//                       controller.username.value,
//                       Colors.white,
//                       Colors.white70,
//                       Colors.white,
//                       Colors.white38,
//                       'نام کاربری',
//                       30,
//                       7,
//                       TextAlign.right,
//                       20),
//                   textFieldCustom(
//                       controller.password.value,
//                       Colors.white,
//                       Colors.white70,
//                       Colors.white,
//                       Colors.white38,
//                       'رمزعبور',
//                       30,
//                       7,
//                       TextAlign.right,
//                       20),
//                 ],
//               ),
//               const SizedBox(
//                 height: 5,
//               ),
//               textFieldCustom(
//                   controller.nameCustomer.value,
//                   Colors.black87,
//                   kPurpleDark.withOpacity(0.7),
//                   kPurpleDark,
//                   kPurpleDark.withOpacity(0.7),
//                   'نام و نام خانوادگی',
//                   20,
//                   10,
//                   TextAlign.center,
//                   20),
//               textFieldCustom(
//                   controller.phoneNumber.value,
//                   Colors.black87,
//                   kPurpleDark.withOpacity(0.7),
//                   kPurpleDark,
//                   kPurpleDark.withOpacity(0.7),
//                   'شماره موبایل',
//                   20,
//                   10,
//                   TextAlign.center,
//                   20),
//               textFieldCustom(
//                   controller.email.value,
//                   Colors.black87,
//                   kPurpleDark.withOpacity(0.7),
//                   kPurpleDark,
//                   kPurpleDark.withOpacity(0.7),
//                   'ایمیل',
//                   20,
//                   10,
//                   TextAlign.center,
//                   20),
//               textFieldCustom(
//                   controller.wallet.value,
//                   Colors.black87,
//                   kPurpleDark.withOpacity(0.7),
//                   kPurpleDark,
//                   kPurpleDark.withOpacity(0.7),
//                   'کیف پول',
//                   20,
//                   10,
//                   TextAlign.center,
//                   20),
//               textFieldCustom(
//                   controller.address.value,
//                   Colors.black87,
//                   kPurpleDark.withOpacity(0.7),
//                   kPurpleDark,
//                   kPurpleDark.withOpacity(0.7),
//                   'آدرس',
//                   20,
//                   10,
//                   TextAlign.center,
//                   20),
//               const Spacer(),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 30.0),
//                 child: CustomButton(
//                   colorBtn: Colors.white,
//                   textBtn: 'افزودن مشتری',
//                   textColor: kPurpleDark,
//                   fontBtn: 'lalezar',
//                   fontSizeBtn: 26,
//                   shadowColor: kPurpleDark,
//                   onTapped: () async {
//                     await xController.addCustomer(
//                         controller.nameCustomer.value.text,
//                         controller.username.value.text,
//                         controller.password.value.text,
//                         controller.email.value.text,
//                         controller.phoneNumber.value.text,
//                         controller.wallet.value.text,
//                         controller.address.value.text,
//                         '');
//                     Get.snackbar(
//                       '',
//                       '',
//                       titleText: const Text(
//                         'ثبت مشتری',
//                         style: TextStyle(fontSize: 18, color: kPurpleDark),
//                       ),
//                       messageText: const Text(
//                         'اطلاعات مشتری با موفقیت ثبت شد',
//                         style: TextStyle(fontSize: 18, color: kPurpleDark),
//                       ),
//                       backgroundColor: Colors.white,
//                       colorText: kPinkDark,
//                     );
//                     controller.clear();
//                   },
//                   splashColor: kPurpleDark,
//                   borderColor: kPurpleDark,
//                   widthBtn: 330,
//                   heightBtn: 65,
//                 ),
//               ),
//             ]),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:digishop/constans.dart';
import 'package:digishop/controller/customer_controller.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/widgets/admin_base_widget.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:digishop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/navbar_custom.dart';

class AdminCustomerCreate extends GetView<CustomerController> {
  AdminCustomerCreate({super.key});

  MyDb xController = Get.find<MyDb>();

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: null,
      bottomNavigation: null,
      floatingLocation: FloatingActionButtonLocation.startFloat,
      floating: FloatingActionButton(
        onPressed: () {
          Get.back();
        },
        elevation: 20,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.arrow_back_sharp,
          size: 33,
        ),
      ),
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
                      'نام کاربری', 10, 0, TextAlign.right, 20),
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
                    await xController.addCustomer(
                        controller.nameCustomer.value.text,
                        controller.username.value.text,
                        controller.password.value.text,
                        controller.email.value.text,
                        controller.phoneNumber.value.text,
                        controller.wallet.value.text,
                        controller.address.value.text,
                        '');
                    Get.snackbar(
                      '', '', titleText: const Text('ثبت مشتری',
                      style: TextStyle(fontSize: 18, color: kPurpleDark),
                    ),
                      messageText: const Text(
                        'اطلاعات مشتری با موفقیت ثبت شد',
                        style: TextStyle(fontSize: 18, color: kPurpleDark),
                      ),
                      backgroundColor: Colors.white,
                      colorText: kPinkDark,
                    );
                    controller.clear();
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
