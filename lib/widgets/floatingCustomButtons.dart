import 'package:flutter/material.dart';

class FloatingCustomButtons extends FloatingActionButtonLocation{

  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(
        scaffoldGeometry.scaffoldSize.width/1.20,
        (scaffoldGeometry.scaffoldSize.height -
            scaffoldGeometry.floatingActionButtonSize.height) /
            7);
  }
}