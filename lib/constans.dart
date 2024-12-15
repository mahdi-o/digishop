import 'package:digishop/widgets/custom_button.dart';
import 'package:digishop/widgets/navbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Color kPurpleDark = Color(0xFF6e46df);
const Color kPurple = Color(0xFFcbb9ff);
const Color kPinkDark = Color(0xFFfe0081);
const Color kPurpleLight = Color(0xFFeee9ff);
const Color kPinkLight = Color(0xFFF642AE);
const Color kBlueLight = Color(0xFFc77dff);
const Color kRedLight = Color(0xFFff5454);

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

dialogCustom(String textBody, double sizeText, VoidCallback onTapped) {
  return Get.defaultDialog(
    backgroundColor: kPurpleDark,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
    title: 'اخطار',
    titleStyle: const TextStyle(
        color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
    content: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        textBody,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: sizeText),
      ),
    ),
    confirm: CustomButton(
      colorBtn: Colors.white,
      textBtn: 'تایید',
      textColor: kPinkDark,
      fontBtn: 'lalezarPlus',
      fontSizeBtn: 22,
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
      fontSizeBtn: 22,
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

mySnackBar(bool type, colorType, String message) {
  var textColor = kPurpleDark;
  var backColor = Colors.white;
  if (colorType == false) {
    textColor = Colors.white;
    backColor = kPurpleDark;
  }
  return Get.snackbar('', '',
      titleText: Text(
        type == true ? 'عملیات موفق' : 'عملیات ناموفق',
        style: TextStyle(
            fontSize: 20, color: type == true ? textColor : Colors.white),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      messageText: Text(
        message,
        style: TextStyle(
            fontSize: 18, color: type == true ? textColor : Colors.white),
      ),
      shouldIconPulse: false,
      backgroundColor: type == true ? backColor : kRedLight,
      colorText: type == true ? textColor : Colors.white,
      duration: const Duration(milliseconds: 1500),
      icon: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Icon(
          type == true
              ? Icons.add_task_outlined
              : Icons.highlight_remove_outlined,
          size: 40,
          color: type == true ? Colors.pinkAccent : Colors.white,
        ),
      ));
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
    contentPadding:
        const EdgeInsets.only(right: 16, left: 16, bottom: 20, top: 0),
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
    confirm: CustomButton(
      colorBtn: kPurpleDark,
      textBtn: textButton,
      textColor: Colors.white,
      fontBtn: 'lalezarPlus',
      fontSizeBtn: 24,
      shadowColor: kPurpleDark,
      splashColor: kPurpleDark,
      borderColor: kPurpleDark,
      widthBtn: 130,
      heightBtn: 55,
      onTapped: onTapped,
    ),
    cancel: CustomButton(
      colorBtn: Colors.white,
      textBtn: 'لغو',
      textColor: kPurpleDark,
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
    obscureText,
    VoidCallback? onTap}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: width, vertical: height),
    child: TextField(
      controller: controller,
      textAlign: textAlign,
      style:
          TextStyle(color: textColor, fontSize: double, fontFamily: 'lalezar'),
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


// برای این نوشته شده که قسمت های mainWidget فاکتور و محصول و مشتری که ثابت هستند دیگه تکرار نشن
Widget contentBaseWidget(String textNavbar1,IconData? iconNavbar1,VoidCallback onTabIconNavbar2,Widget child
    ){
  return Padding(
    padding:
    const EdgeInsets.only(right: 10, left: 10, bottom: 20, top: 50),
    child: Column(
      children: [            // ویجت NavbarCustom ثابت
        SizedBox(
          height: 60, // ارتفاع ثابت برای هدر
          child: NavbarCustom(
            text1: textNavbar1,
            text2: '',
            size1: 28,
            size2: 26,
            fontFace1: 'lalezarPlus',
            fontFace2: 'lalezarPlus',
            icon1: iconNavbar1,
            onTapIcon2:onTabIconNavbar2,
            icon2: null,
          ),
        ),
        // محتوای اسکرول‌شونده
        Expanded(
            child: child
        ),
      ],
    ),
  );
}
