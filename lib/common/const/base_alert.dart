import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/size.dart';

import '../common/widget/widget_custom_text_box.dart';
import '../common/widget/widget_double_btn.dart';


Future<bool> conFirmSuccessAlert(BuildContext context, String title) async {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  bool rs = false;

  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: WidgetCustomTextBox(
            width: width * 0.8,
            height: height * 0.08,
            msg: title,
            fontSize: fontSize(context, 7)),
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
