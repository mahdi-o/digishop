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
    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
    title: 'اخطار',
    titleStyle: const TextStyle(color: Colors.white, fontSize: 24),
    content: Center(
      child: Text(
        textBody,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    ),
    confirm: CustomButton(
      colorBtn: Colors.white,
      textBtn: 'تایید',
      textColor: kPinkDark,
      fontBtn: 'yekanBakh',
      fontSizeBtn: 22,
      shadowColor: kPurpleDark,
      onTapped: onTapped,
      splashColor: kPurpleDark,
      borderColor: kPurpleDark,
      widthBtn: 100,
      heightBtn: 55,
    ),
    cancel: CustomButton(
      colorBtn: Colors.white,
      textBtn: 'لغو',
      textColor: kPurpleDark,
      fontBtn: 'yekanBakh',
      fontSizeBtn: 22,
      shadowColor: kPurpleDark,
      onTapped: () {
        Get.back();
      },
      splashColor: kPurpleDark,
      borderColor: kPurpleDark,
      widthBtn: 100,
      heightBtn: 55,
    ),
  );
}

dialogCheckOut(String title, String textBody, String textButton,
    VoidCallback onTapped, int type) {
  return Get.defaultDialog(
    backgroundColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    title: title,
    titleStyle: const TextStyle(color: kPinkDark, fontSize: 24),
    content: Center(
      child: Text(
        textBody,
        style: const TextStyle(color: kPurpleDark, fontSize: 18),
      ),
    ),
    confirm: type == 0
        ? CustomButton(
            colorBtn: Colors.white,
            textBtn: type == 0 ? 'بازگشت' : 'تایید',
            textColor: kPurpleDark,
            fontBtn: 'yekanBakh',
            fontSizeBtn: 22,
            shadowColor: kPurpleDark,
            onTapped: onTapped,
            splashColor: kPurpleDark,
            borderColor: kPurpleDark,
            widthBtn: 200,
            heightBtn: 100,
          )
        : CustomButton(
            colorBtn: Colors.white,
            textBtn: textButton,
            textColor: kPinkDark,
            fontBtn: 'yekanBakh',
            fontSizeBtn: 22,
            shadowColor: kPurpleDark,
            onTapped: onTapped,
            splashColor: kPurpleDark,
            borderColor: kPurpleDark,
            widthBtn: 130,
            heightBtn: 60,
          ),
  );
}

textFieldCustom(TextEditingController controller,Color textColor, Color labelColor, Color borderColor,
    Color borderColorNext, String label, double width,double height, TextAlign textAlign,double double) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: width, vertical: height),
    child:
    TextField(
      controller: controller,
      textAlign: textAlign,
      style: TextStyle(color: textColor, fontSize: double),
      decoration: InputDecoration(
          label:textAlign == TextAlign.center?Center(child: Text(label)):Text(label),
          labelStyle: TextStyle(
            color: labelColor,
          ),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: borderColor)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: borderColorNext))),
    ),
  );
}
