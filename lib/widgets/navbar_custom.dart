import 'package:digishop/constans.dart';
import 'package:digishop/services/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavbarCustom extends StatelessWidget {
  const NavbarCustom(
      {super.key,
      required this.text1,
      required this.text2,
      required this.icon1,
      this.icon2,
      this.onTapIcon1,
      this.onTapIcon2,
        this.moveHomeAdmin
      });

  final String text1, text2;
  final IconData icon1;
  final IconData? icon2;
  final VoidCallback? onTapIcon1, onTapIcon2;
  final VoidCallback? moveHomeAdmin;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: moveHomeAdmin,
          child: RichText(
            text: TextSpan(
              text: text1,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPurpleDark,
                  fontSize: 30,
                  fontFamily: 'Titr'),
              children: <TextSpan>[
                TextSpan(
                    text: text2,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Titr')),
              ],
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(onTap: onTapIcon1, child: Icon(icon2,size: 30,)),
        icon2!=null?const SizedBox(width: 20,):const SizedBox(width: 0,),
        GestureDetector(
            onTap: onTapIcon2,
            child: Icon(
              icon1,
              size: 30,
            )),
      ],
    );
  }
}
