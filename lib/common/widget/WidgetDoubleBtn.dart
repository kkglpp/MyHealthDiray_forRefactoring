import 'package:flutter/material.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';
import 'package:myhealthdiary_app/common/widget/WidgetCustomTextBox.dart';

///각 화면 아래에 버튼 놓을 크기의 높이 지정한 sizedbox 의 child 에 이 클래스 부르면 된다.\n
///함수 두개 넣자.
class WidgetDoubleBtn extends StatelessWidget {
  final Function() leftFunc;
  final Function() rightFunc;
  const WidgetDoubleBtn({required this.leftFunc, required this.rightFunc});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxHeight = constraints.maxHeight;
        double width = maxWidth / 2.5;
        double height = maxHeight * 0.8;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(foregroundColor: constCancleColor),
                onPressed: () {
                  leftFunc();
                },
                child: WidgetCustomTextBox(
                    msg: "☒ Cancel", fontSize: width < 100 ? 12 : 20)),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: constConfirmColor),
                onPressed: () {
                  rightFunc();
                },
                child: WidgetCustomTextBox(
                    msg: "☑︎ Confirm", fontSize: width < 100 ? 10 : 15)),
          ],
        );
      },
    );
  }
}
