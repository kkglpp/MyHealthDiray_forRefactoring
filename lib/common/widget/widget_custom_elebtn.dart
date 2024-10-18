

import 'package:flutter/material.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_text_box.dart';

class WidgetCustomEleBtn extends StatelessWidget {
  final String msg;
  final Color color;
  final Function onPressed;
  final double width;
  final double height;
  final double fontSize;
  const WidgetCustomEleBtn(
      {super.key,
      required this.msg,
      required this.color,
      required this.onPressed,
      required this.width,
      required this.height,
      required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 3,
        backgroundColor: Colors.white,
        fixedSize: Size(width , height ),
      ),
      onPressed: () {
        onPressed();
      },
      child: WidgetCustomTextBox(
        width: width*0.8,
        height: height*0.8, 
        msg: msg,
        fontSize: fontSize,
        fontColor: color,
        verAlign: 1,
        bold: false,
      ),
    );
  }
}
