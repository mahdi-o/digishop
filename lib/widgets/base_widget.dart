import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseWidget extends GetView {
  const BaseWidget(
      {super.key,
      required this.child,
      required this.appBar,
      required this.bottomNavigation,
       this.color,
        this.floatingActionButton,
      this.floatingLocation,
       this.onPressed});


  final Widget child;
  final AppBar? appBar;
  final CurvedNavigationBar? bottomNavigation;
  final Color? color;
  final bool? floatingActionButton;
  final FloatingActionButtonLocation? floatingLocation;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: color??Colors.white,
        appBar: appBar,
        floatingActionButton:floatingActionButton==false?
            Container():FloatingActionButton(
          onPressed: onPressed,
          elevation: 10,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.arrow_back_sharp,
            size: 33,
          ),
        ),
        floatingActionButtonLocation: floatingLocation??FloatingActionButtonLocation.startFloat,
        bottomNavigationBar: bottomNavigation,
        body:child
      ),
    );
  }
}
