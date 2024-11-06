import 'package:flutter/material.dart';

class StarCustom extends StatelessWidget {
  const StarCustom({super.key, required this.lengthStar});
final int lengthStar;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 20,
          height: 60,
        ),
        Icon(
            Icons.star,
            size: 19,
            color: lengthStar< 5 ? Colors.grey:Colors.amber
        ),
        Icon(
            Icons.star,
            size: 19,
            color: lengthStar < 4 ? Colors.grey:Colors.amber
        ),
        Icon(
            Icons.star,
            size: 19,
            color: lengthStar < 3 ? Colors.grey:Colors.amber
        ),
        Icon(
            Icons.star,
            size: 19,
            color: lengthStar < 2 ? Colors.grey:Colors.amber
        ),
        Icon(
            Icons.star,
            size: 19,
            color: lengthStar < 1 ? Colors.grey:Colors.amber
        ),
      ],
    );
  }
}
