import 'package:flutter/material.dart';

class ContainerCustomAdmin extends StatelessWidget {
  const ContainerCustomAdmin({super.key, required this.text, required this.icon,  required this.textColor, required this.iconColor,required this.voidCallback});
final String text;
final IconData icon;
final Color textColor,iconColor;
final VoidCallback voidCallback;
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white),
      width: 135,
      height: 110,
      child: Padding(
        padding: const EdgeInsets.only(
            right: 8.0, left: 8.0, top: 13),
        child: Column(
          children: [
            Center(
              child: GestureDetector(
                onTap: voidCallback,
                child:  Text( text,
                  style:TextStyle(
                    fontSize: 20, color: textColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
             Icon(
              icon, size: 55, color: iconColor,
            )
          ],
        ),
      ),
    );
  }
}



