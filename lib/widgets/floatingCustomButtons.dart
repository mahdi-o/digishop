import 'package:flutter/material.dart';

class FloatingCustomButtons extends FloatingActionButtonLocation{

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(
        scaffoldGeometry.scaffoldSize.width/1.20,
        (scaffoldGeometry.scaffoldSize.height -
            scaffoldGeometry.floatingActionButtonSize.height) / 9);
  }
}