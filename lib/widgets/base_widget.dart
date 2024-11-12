import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseWidget extends GetView {
  const BaseWidget({super.key, required this.child,required this.appBar,required this.bottomNavigation,required this.color});
final Widget child;
final AppBar? appBar;
final CurvedNavigationBar? bottomNavigation;
final Color color;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor:color,
        appBar: appBar,
      body: child,
        bottomNavigationBar:bottomNavigation,
      ),
    );
  }
}
