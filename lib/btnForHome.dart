import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/widget/WidgetCustomTextBox.dart';

class BtnForHome extends StatelessWidget {
  final String msg;
  final Widget content;
  final String navi;
  final double width;
  final double height;
  const BtnForHome({
    // super.key,
    required this.msg,
    required this.content,
    required this.navi, required this.width, required this.height,
  });

  @override
  Widget build(BuildContext context) {
    double fonsSize = height>150? 14: 11;
    double labelHeight = height>150? 25: 20;
    return GestureDetector(
      onTap: () {
        context.goNamed(navi);
      },
      child: Stack(
        children: [
          Container(
          width: width,
          height: height,
          color: Colors.black,
          child: Center(child: content)            
          ),
      Positioned(
          left: 0,
          bottom: 0,
          child: Container(
            width: width,
            height: labelHeight,
            color: Colors.black.withAlpha(200),
            child: WidgetCustomTextBox(
              verAlign: 1,
              width: width,
              height: labelHeight,
              fontColor: Colors.white,
              msg: msg,
              bold: true,
              fontSize:msg.length>7? fonsSize-1: fonsSize)
          ))          
        ],
      ),
    );
  }
}
