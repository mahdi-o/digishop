import 'package:digishop/constans.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminBaseWidget extends StatelessWidget {
  const AdminBaseWidget({super.key, required this.childWidget,required this.color, required this.height});
final Widget childWidget;
final Color color;
final double height;
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
            padding:  EdgeInsets.only(top: height-20),
            child: Container(
              width: Get.width,
              height: Get.height-230,
              decoration:  BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(20)),
                color: color,
              ),
            ),
          ),
        ),
        childWidget,
      ],
    );
  }
}
