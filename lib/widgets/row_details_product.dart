import 'package:flutter/material.dart';

class RowDetailsProduct extends StatelessWidget {
  const RowDetailsProduct({super.key, required this.title, required this.body});
final String title,body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const SizedBox(
            width: 40,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
          const Spacer(),
          Text(
            body,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            width: 40,
          ),
        ],
      ),
    );
  }
}
