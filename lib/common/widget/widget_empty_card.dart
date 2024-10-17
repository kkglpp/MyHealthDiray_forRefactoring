import 'package:flutter/material.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';

import 'widget_custom_text_box.dart';

class WidgetEmptyCard extends StatelessWidget {
  final double width;
  final double height;
  const WidgetEmptyCard({super.key, required this.width, required this.height, required double fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: constEmptyColor,
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20)
      ),
      width: width,
      height: height,
      child:  WidgetCustomTextBox(
        msg: "내용이 없습니다. \n 새로운 목표/기록을 입력하세요.", fontSize: (width/20).clamp(12, 28)),
    );
  }
}