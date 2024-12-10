import 'package:digishop/constans.dart';
import 'package:digishop/controller/product_controller.dart';
import 'package:digishop/database/my_db.dart';
import 'package:digishop/screens/admin_home_screen.dart';
import 'package:digishop/services/routes.dart';
import 'package:digishop/widgets/admin_base_widget.dart';
import 'package:digishop/widgets/base_widget.dart';
import 'package:digishop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/User.dart';
import '../widgets/navbar_custom.dart';

class AdminProductCreate extends GetView<ProductController> {
  AdminProductCreate({super.key});

  final MyDb xController = Get.find<MyDb>();
  final User user = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: null,
      bottomNavigation: null,
      floatingLocation: FloatingActionButtonLocation.startFloat,
      floating: FloatingActionButton(
        onPressed: () {
          controller.clear();
          Get.toNamed(AppRoutes.adminHome,arguments: user);
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
      child: AdminBaseWidget(height: 300,
        color: Colors.grey.shade200,
        childWidget: SingleChildScrollView(
          child: SizedBox(
            height: Get.height,
            child: Column(children: [
              const SizedBox(
                height: 60,
              ),
              Column(
                children: [
                  const Padding(
                    padding:
                    EdgeInsets.only(right: 125, left: 10),
                    child: Column(
                      children: [
                        // ویجت NavbarCustom ثابت
                        SizedBox(
                          height: 40, // ارتفاع ثابت برای هدر
                          child: NavbarCustom(
                            text1: '',
                            text2: 'ثبت محصول جدید',
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
                  textFieldCustom(
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
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
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
              Row(
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
              Row(
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
              const Padding(
                padding: EdgeInsets.only(top: 30, bottom: 5),
                child: Text(
                  'افزودن عکس',
                  style: TextStyle(color: kPurpleDark, fontSize: 20),
                ),
              ),
              Image.asset(
                'assets/images/image.png',
                width: 110,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: CustomButton(
                  colorBtn: Colors.white,
                  textBtn: 'ثبت محصول',
                  textColor: kPurpleDark,
                  fontBtn: 'lalezar',
                  fontSizeBtn: 26,
                  shadowColor: kPurpleDark,
                  onTapped: ()async {
                    await xController.addProduct(
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
                   if(xController.status.value == true){
                     Future.delayed(const Duration(milliseconds: 2500), () {
                       Get.off(() => AdminHomeScreen(),arguments: user, // صفحه مقصد
                         transition: Transition.zoom,  // نوع انیمیشن
                         duration: const Duration(milliseconds: 500), // مدت زمان انیمیشن
                       );
                     });
                     controller.clear();
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
