
import 'package:flutter/material.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_text_box.dart';

class WidgetCustomIconBtn extends StatelessWidget {
  final double width;
  final double height;
  final Icon icon;
  final String msg;
  final double fsize;
  final Color fontColor;
  final Function onPressed;
  const WidgetCustomIconBtn({
    super.key,
    required this.width,
    required this.height,
    required this.icon,
    required this.msg,
    required this.fsize,
    required this.fontColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        fixedSize: Size(width, height),
      ),
      onPressed: () {
        onPressed();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          WidgetCustomTextBox(
            width: width,
            height: height*0.2,
            msg: msg,
            fontSize: fsize,
            fontColor: fontColor,
            bold: true,
          )
        ],
      ),
    );
  }
}
