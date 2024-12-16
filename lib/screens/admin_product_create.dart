import 'package:digishop/constans.dart';
import 'package:digishop/controller/product_controller.dart';
import 'package:digishop/screens/admin_home_screen.dart';
import 'package:digishop/services/routes.dart';
import 'package:digishop/widgets/admin_base_widget.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/User.dart';

class AdminProductCreate extends GetView<ProductController> {
  AdminProductCreate({super.key});

  final User user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: null,
      bottomNavigation: null,
      onPressed: () {
        controller.clear();
        Get.toNamed(AppRoutes.adminHome,arguments: user);
      },
      color: Colors.grey.shade300,
      child: AdminBaseWidget(
        paddingRight: 125,
        textNavbar2: 'ثبت محصول جدید',
        onTapButton: ()async {
          var status = await controller.addProduct(
            controller.nameProduct.value.text,
            controller.priceProduct.value.text,
            controller.brandProduct.value.text,
            '',
            controller.countProduct.value.text,
            controller.ramProduct.value.text,
            controller.hardProduct.value.text,
            controller.cpuProduct.value.text,
            controller.screenProduct.value.text,
            4,
            0,
          );
          if(status != 0){
            Future.delayed(const Duration(milliseconds: 2500), () {
              Get.off(() => AdminHomeScreen(),arguments: user, // صفحه مقصد
                transition: Transition.zoom,  // نوع انیمیشن
                duration: const Duration(milliseconds: 500), // مدت زمان انیمیشن
              );
            });
            controller.clear();
          }
        },
        textBtn: 'ثبت محصول',
        height: 310,
        child1:textFieldCustom(
            controller.nameProduct.value,
            Colors.white,
            Colors.white70,
            Colors.white,
            Colors.white38,
            'نام محصول',
            30,
            0,
            TextAlign.right,20
        ),
        child2:textFieldCustom(
            controller.priceProduct.value,
            Colors.white,
            Colors.white70,
            Colors.white,
            Colors.white38,
            'قیمت',
            30,
            7,
            TextAlign.right,20
        ),
        child3:Row(
          children: [
            Expanded(
              child: textFieldCustom(
                  controller.brandProduct.value,
                  Colors.black,
                  kPurpleDark.withOpacity(0.7),
                  kPurpleDark,
                  kPurpleDark.withOpacity(0.7),
                  'برند',
                  30,
                  10,
                  TextAlign.right,20
              ),
            ),
            Expanded(
              child: textFieldCustom(
                  controller.ramProduct.value,
                  Colors.black,
                  kPurpleDark.withOpacity(0.7),
                  kPurpleDark,
                  kPurpleDark.withOpacity(0.7),
                  'رم',
                  30,
                  10,
                  TextAlign.right,20
              ),
            ),
          ],
        ),
        child4:Row(
          children: [
            Expanded(
              child: textFieldCustom(
                  controller.hardProduct.value,
                  Colors.black,
                  kPurpleDark.withOpacity(0.7),
                  kPurpleDark,
                  kPurpleDark.withOpacity(0.7),
                  'حافظه',
                  30,
                  10,
                  TextAlign.right,20
              ),
            ),
            Expanded(
              child: textFieldCustom(
                  controller.cpuProduct.value,
                  Colors.black,
                  kPurpleDark.withOpacity(0.7),
                  kPurpleDark,
                  kPurpleDark.withOpacity(0.7),
                  'پردازنده',
                  30,
                  10,
                  TextAlign.right,20
              ),
            ),
          ],
        ),
        child5:Row(
          children: [
            Expanded(
              child: textFieldCustom(
                  controller.screenProduct.value,
                  Colors.black,
                  kPurpleDark.withOpacity(0.7),
                  kPurpleDark,
                  kPurpleDark.withOpacity(0.7),
                  'صفحه نمایش',
                  30,
                  10,
                  TextAlign.right,20
              ),
            ),
            Expanded(
              child: textFieldCustom(
                  controller.countProduct.value,
                  Colors.black,
                  kPurpleDark.withOpacity(0.7),
                  kPurpleDark,
                  kPurpleDark.withOpacity(0.7),
                  'تعداد',
                  30,
                  10,
                  TextAlign.right,20
              ),
            ),
          ],
        ),
        child6:const Padding(
          padding: EdgeInsets.only(top: 30, bottom: 5),
          child: Text(
            'افزودن عکس',
            style: TextStyle(color: kPurpleDark, fontSize: 20),
          ),
        ),
        child7:Image.asset(
          'assets/images/image.png',
          width: 110,
        ),

      ),
    );
  }
}
