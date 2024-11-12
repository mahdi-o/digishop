import 'dart:ffi';

import 'package:digishop/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color kPurpleDark = Color(0xFF6e46df);
const Color kPurple = Color(0xFFcbb9ff);
const Color kPinkDark = Color(0xFFfe0081);
const Color kPurpleLight = Color(0xFFeee9ff);
const Color kPinkLight = Color(0xFFF642AE);
const Color kBlueLight = Color(0xFFc77dff);

const Color kLightRedColor = Color(0xFFfde8e4);
const Color kLightGreyColor = Color(0xFFf2f3f2);
const Color kLightPurpleColor = Color(0xFFf4ebf7);
const Color kLightYellowColor = Color(0xFFfff8e5);
const Color kLightBlueColor = Color(0xFFedf7fc);
const Color kLightGreenColor = Color(0xFFeef7f1);
const Color kLightOrangeColor = Color(0xFFfef6ed);
const Color kRedLight = Color(0xFFff5454);

List<Color> kColorList = [
  kLightRedColor,
  kLightGreyColor,
  kLightBlueColor,
  kLightYellowColor,
  kLightPurpleColor,
  kLightOrangeColor,
  kLightGreenColor,
  kPurpleLight,
  kLightGreenColor,
];

String separateDigits(int number) {
  String result = '';
  String numStr = number.toString();
  for (int i = numStr.length - 1; i >= 0; i--) {
    result = numStr[i] + result;
    if ((numStr.length - i) % 3 == 0 && i != 0) {
      result = ',$result';
    }
  }
  return result;
}

dialogCustom(String textBody, VoidCallback onTapped) {
  return Get.defaultDialog(
    backgroundColor: kPurpleDark,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    title: 'اخطار',
    titleStyle: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
    content: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        textBody,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
    confirm: CustomButton(
      colorBtn: Colors.white,
      textBtn: 'تایید',
      textColor: kPinkDark,
      fontBtn: 'lalezarPlus',
      fontSizeBtn: 20,
      shadowColor: Colors.transparent,
      onTapped: onTapped,
      splashColor: kPurpleDark.withOpacity(0.2),
      borderColor: Colors.transparent,
      widthBtn: 120,
      heightBtn: 45,
    ),
    cancel: CustomButton(
      colorBtn: Colors.transparent,
      textBtn: 'لغو',
      textColor: Colors.white,
      fontBtn: 'lalezarPlus',
      fontSizeBtn: 20,
      shadowColor: Colors.transparent,
      onTapped: () {
        Get.back();
      },
      splashColor: Colors.white.withOpacity(0.2),
      borderColor: Colors.white,
      widthBtn: 120,
      heightBtn: 45,
    ),
    radius: 10,
  );
}
 dialogCheckOut(
    String title,
    String textBody,
    String textButton,
    VoidCallback onTapped,
    int type,
    ) {
  return Get.defaultDialog(
    backgroundColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
    title: title,
    titleStyle: const TextStyle(color: kPinkDark, fontSize: 24),
    content: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        textBody,
        textAlign: TextAlign.center,
        style: const TextStyle(color: kPurpleDark, fontSize: 18),
      ),
    ),
    confirm: CustomButton(
      colorBtn: Colors.white,
      textBtn: type == 0 ? 'بازگشت' : textButton,
      textColor: kPurpleDark,
      fontBtn: 'lalezarPlus',
      fontSizeBtn: 22,
      shadowColor: kPurpleDark,
      splashColor: kPurpleDark,
      borderColor: kPurpleDark,
      widthBtn: 200,
      heightBtn: type == 0 ? 60 : 55,
      onTapped: type == 0 ? Get.back : onTapped,
    ),
  );
}

dialogTextFieldCheck(
    String title,
    String textBody,
    String textButton,
    VoidCallback onTapped,
    int type,
    TextEditingController inputController,
    ) {
  return Get.defaultDialog(
    backgroundColor: Colors.white,
    contentPadding: const EdgeInsets.only(right: 16,left: 16,bottom: 20,top: 0),
    title: title,
    titleStyle: const TextStyle(color: kPinkDark, fontSize: 24),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            textBody,
            textAlign: TextAlign.center,
            style: const TextStyle(color: kPurpleDark, fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: TextField(
            controller: inputController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'اینجا متن را وارد کنید',
            ),
          ),
        ),
      ],
    ),
    confirm:
    CustomButton(
      colorBtn: kPurpleDark,
      textBtn: textButton,
      textColor:  Colors.white,
      fontBtn: 'lalezarPlus',
      fontSizeBtn: 24,
      shadowColor: kPurpleDark,
      splashColor: kPurpleDark,
      borderColor: kPurpleDark,
      widthBtn: 130,
      heightBtn: 55,
      onTapped: onTapped,
    ),

    cancel:CustomButton(
      colorBtn: Colors.white,
      textBtn: 'لغو',
      textColor:kPurpleDark,
      fontBtn: 'lalezarPlus',
      fontSizeBtn: 24,
      shadowColor: kPurpleDark,
      onTapped: () {
        Get.back();
      },
      splashColor: Colors.white.withOpacity(0.2),
      borderColor: Colors.white,
      widthBtn: 100,
      heightBtn: 55,
    ),
    radius: 10,
  );
}
textFieldCustom(
    TextEditingController controller,
    Color textColor,
    Color labelColor,
    Color borderColor,
    Color borderColorNext,
    String label,
    double width,
    double height,
    TextAlign textAlign,
    double double,
    {bool? readOnly,
    obscureText,VoidCallback? onTap}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: width, vertical: height),
    child: TextField(
      controller: controller,
      textAlign: textAlign,
      style: TextStyle(color: textColor, fontSize: double),
      decoration: InputDecoration(
        label: textAlign == TextAlign.center
            ? Center(child: Text(label))
            : Text(label),
        labelStyle: TextStyle(
          color: labelColor,
        ),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: borderColor)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: borderColorNext),
        ),
      ),
      readOnly: readOnly ?? false,
      obscureText: obscureText ?? false,
      onTap: onTap,
    ),
  );
}
