import 'package:flutter/material.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';
import 'package:myhealthdiary_app/common/widget/WidgetCustomTextBox.dart';


class WidgetDoubleBtn extends StatelessWidget {
  final double width;
  final double height;
  String left;
  String right;
  final Function() leftFunc;
  final Function() rightFunc;
  ///각 화면 아래에 버튼 놓을 크기의 높이 지정한 sizedbox 의 child 에 이 클래스 부르면 된다.\n
  ///SizedBox 부터 리턴한다.
  ///함수 두개 넣자.
  WidgetDoubleBtn({required this.leftFunc, required this.rightFunc, required this.width, required this.height,this.left = "Cancel", this.right ="Confirm"});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(foregroundColor: constCancleColor),
                  onPressed: () {
                    leftFunc();
                  },
                  child: WidgetCustomTextBox(
                    bold: true,

                    fontColor: constCancleColor,
                    width: width/5,
                    height: height,
                      msg: "☒ $left", fontSize: width < 60 ? 6 : 10)),
              SizedBox(width: 20,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: constConfirmColor),
                  onPressed: () {
                    rightFunc();
                  },
                  child: WidgetCustomTextBox(
                    bold: true,
                    fontColor: constConfirmColor,
                    width: width/5,
                    height: height,
                      msg: "☑︎ $right", fontSize: width < 60 ? 6 : 10)),
            ],
          ),
    );
      }
  }

