import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
        required this.colorBtn,
        required this.textBtn,
        required this.textColor,
        required this.fontBtn,
        required this.fontSizeBtn,
        required this.shadowColor,
        required this.onTapped,
        required this.splashColor,
        required this.borderColor,
        required this.widthBtn,
        required this.heightBtn});

  final Color colorBtn;
  final String textBtn;
  final Color textColor;
  final String fontBtn;
  final double fontSizeBtn;
  final Color shadowColor;
  final VoidCallback onTapped;
  final Color splashColor;
  final Color borderColor;
  final double widthBtn;
  final double heightBtn;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 7,
      shadowColor: shadowColor,
      borderRadius: BorderRadius.circular(30),
      color: colorBtn,
      child: InkWell(
        onTap: onTapped,
        splashColor: splashColor,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: widthBtn,
          height: heightBtn,
          child:  Center(
              child: Text(
                textBtn,
                style: TextStyle(
                  color: textColor,
                  fontFamily:fontBtn,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSizeBtn,
                ),
              )),
        ),
      ),
    );
  }
}
