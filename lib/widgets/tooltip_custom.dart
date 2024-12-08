import 'package:flutter/material.dart';

class MyTooltip extends StatefulWidget {
  @override
  _MyTooltipState createState() => _MyTooltipState();
}

class _MyTooltipState extends State<MyTooltip> {
  // برای کنترل نمایش Tooltip
  GlobalKey _tooltipKey = GlobalKey();
  bool _showTooltip = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tooltip Example"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showTooltip = !_showTooltip;
                });
              },
              child: const Text("نمایش Tooltip"),
            ),
            const SizedBox(height: 20),
            _showTooltip
                ? Tooltip(
              key: _tooltipKey,
              message: "این بخش فاکتورها است.",
              child: Container(
                padding: const EdgeInsets.all(20),
                color: Colors.blueAccent,
                child: const Text(
                  "فاکتورها",
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              ),
            )
                : Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blueAccent,
              child: const Text(
                "فاکتورها",
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}