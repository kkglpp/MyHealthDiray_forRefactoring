import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/component/widget_custom_elebtn.dart';
import '../component/widget_custom_text_box.dart';
import '../component/widget_double_btn.dart';

/*
메시지 하나 보여주고 
버튼 2개 띄우는 간단한 Alert 창.
아무떄나 쓰기위함
*/
Future<bool> baseAlertForConfirm(BuildContext context, String title) async {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  bool rs = false;
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: WidgetCustomTextBox(
            maxLine: 3,
            verAlign: 1,
            width: width * 0.8,
            height: height * 0.12,
            msg: title,
            fontSize: title.length > 10
                ? fontSize(context, 3)
                : fontSize(context, 5)),
        actions: [
          WidgetDoubleBtn(
              leftFunc: () {
                rs = false;
                context.pop();
              },
              rightFunc: () {
                rs = true;
                context.pop();
              },
              width: width * 0.8,
              height: height * 0.05)
        ],
      );
    },
  );
  return rs;
}



void baseAlertOnlyOneBtn(BuildContext context, String title) async {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: WidgetCustomTextBox(
            maxLine: 3,
            verAlign: 1,
            width: width * 0.8,
            height: height * 0.12,
            msg: title,
            fontSize: title.length > 10
                ? fontSize(context, 3)
                : fontSize(context, 5)),
        actions: [
          WidgetCustomEleBtn(
            msg: "확인",
            color: constConfirmColor,
            onPressed: (){
              context.pop();
            }
            ,
            width: width,
            height: height,
            fontSize: fontSize(context, 3))
        ],
      );
    },
  );
}
