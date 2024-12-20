import 'package:flutter/material.dart';

import '../constans.dart';

class RowDetailsModels extends StatelessWidget {
   RowDetailsModels(
      {super.key, required this.typeRow, required this.title, required this.body,this.buttonPay});

  final String typeRow, title, body;
  late bool? buttonPay = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(vertical:buttonPay==false ? 7 : 0
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: typeRow != 'product' ? 7 : 10,
            horizontal: typeRow != 'product' ? 22 : 40),
        child: typeRow != 'product' ?Column(
          children: [
             Text(
             title,
              style: const TextStyle(fontSize: 22,color: Colors.black),
            ),
            Text(
              body,
              style: const TextStyle(fontSize: 21,color: kPurpleDark),
            ),
          ],
        )
        :Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
            const Spacer(),
            Text(
              body,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
