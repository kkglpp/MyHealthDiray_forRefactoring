import 'dart:math';

import 'package:flutter/material.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';
import 'package:myhealthdiary_app/common/const/size.dart';

import 'widget_custom_text_box.dart';

//Function 으로 받는 경우 // Function() 으로 받는 경우 비교
///SizedBox 부터 return 한다.
class WidgetDoubleBtn extends StatelessWidget {
  final double width;
  final double height;
  final String leftMsg;
  final String rightMsg;
  final Function leftFunc;
  final Function rightFunc;

  ///각 화면 아래에 버튼 놓을 크기의 높이 지정한 sizedbox 의 child 에 이 클래스 부르면 된다.\n
  ///SizedBox 부터 리턴한다.
  ///함수 두개 넣자.
  const WidgetDoubleBtn(
      {super.key,
      required this.leftFunc,
      required this.rightFunc,
      required this.width,
      required this.height,
      this.leftMsg = "☒ Cancel",
      this.rightMsg = "☑︎ Confirm"});
  @override
  Widget build(BuildContext context) {
    double fsize = max(leftMsg.length, rightMsg.length) < 7
        ? fontSize(context, 3)
        : fontSize(context, 1.1);
    return SizedBox(
      width: width,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              style:
                  ElevatedButton.styleFrom(foregroundColor: constCancleColor),
//함수 부르는 방식 테스트중
              // onPressed:()=> leftFunc,
              onPressed: () => leftFunc(),
              child: WidgetCustomTextBox(
                  bold: true,
                  fontColor: constCancleColor,
                  width: width / 4.5,
                  height: height,
                  msg: leftMsg,
                  fontSize: fsize)),
                  SizedBox(
                    width: fontSize(context, 0.3),
                  ),
          ElevatedButton(
              style:
                  ElevatedButton.styleFrom(foregroundColor: constConfirmColor),
              onPressed: () => rightFunc(),
              child: WidgetCustomTextBox(
                  bold: true,
                  fontColor: constConfirmColor,
                  width: width / 4.5,
                  height: height,
                  msg: rightMsg,
                  fontSize: fsize)),
        ],
      ),
    );
  }
}
