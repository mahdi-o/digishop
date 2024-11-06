import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
   const CategoryContainer({super.key, required this.image,});
final String image;
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(left: 10),
      width: 75,
      height: 90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50)),
      child:  Column(
        children: [
          Image.asset(image),
          const SizedBox(
            height: 7,
          ),

        ],
      ),
    );
  }
}
