import 'package:digishop/constans.dart';
import 'package:digishop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'navbar_custom.dart';

class AdminBaseWidget extends StatelessWidget {
  const AdminBaseWidget(
      {super.key,
      this.childWidget,
        this.child1,
        this.child2,
        this.child3,
        this.child4,
        this.child5,
        this.child6,
        this.child7,
      this.color,
      required this.height,
         this.paddingRight,
       this.textNavbar2,
       this.textBtn,
       this.onTapButton});

  final Widget? childWidget,
      child1,
      child2,
      child3,
      child4,
      child5,
      child6,
      child7;
  final Color? color;
  final double? height,paddingRight;
  final String? textNavbar2, textBtn;
  final VoidCallback? onTapButton;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: Get.width,
          height: height,
          decoration: const BoxDecoration(
            color: kPurpleDark,
          ),
        ),
        Positioned(
          child: Padding(
            padding: EdgeInsets.only(top: height! - 20),
            child: Container(
              width: Get.width,
              height: Get.height - 230,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(20)),
                color: color ?? Colors.white,
              ),
            ),
          ),
        ),
       childWidget??SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: Get.height,
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                     Padding(
                      padding:  EdgeInsets.only(right: paddingRight!),
                      child: Column(
                        children: [
                          // ویجت NavbarCustom ثابت
                          SizedBox(
                            height: 50, // ارتفاع ثابت برای هدر
                            child: NavbarCustom(
                              text1: '',
                              text2: textNavbar2!,
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
                    child1!,
                    child2!,
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                child3!,
                child4!,
                child5!,
                child6!,
                child7!,
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: CustomButton(
                    colorBtn: Colors.white,
                    textBtn: textBtn!,
                    textColor: kPurpleDark,
                    fontBtn: 'lalezar',
                    fontSizeBtn: 26,
                    shadowColor: kPurpleDark,
                    onTapped: onTapButton!,
                    splashColor: kPurpleDark,
                    borderColor: kPurpleDark,
                    widthBtn: 330,
                    heightBtn: 65,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
