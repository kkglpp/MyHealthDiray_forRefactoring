import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_text_box.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_text_field.dart';
import 'package:myhealthdiary_app/common/widget/widget_double_btn.dart';

class TrainPlanAddManager {
/* Field */
  final BuildContext context;
  final WidgetRef ref;

/* Constructor */
  TrainPlanAddManager(this.context, this.ref);

/* Method */
  //title 을 변경하는 Alert 창.
  setTitleManager() async {
    double maxWidth = MediaQuery.of(context).size.width * 0.7;
    double maxHeight = MediaQuery.of(context).size.height * 0.7;
    double titlePartHeight = maxHeight * 0.15;
    double contentPartHeight = maxHeight * 0.5;
    double btnPartHeight = maxHeight * 0.15;

    double fsize01 = fontSize(context, 3);
    double fsize02 = fontSize(context, 2);

    String title = ""; //나중에 반환할 값
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: WidgetCustomTextBox(
              width: maxWidth,
              height: titlePartHeight,
              msg: "Plan Title 입력",
              fontSize: fsize01,
              fontAlign: 1,
              verAlign: 1,
            ),
            content: WidgetCustomTextField(
                width: maxWidth * 0.8,
                height: contentPartHeight,
                maxLength: 10,
                hintText: "PlanTitle 입력 : 최대 10글자",
                onchanged: (newTitle) {
                  if (newTitle.trim() == "") {
                    return;
                  }
                  title = newTitle;
                }),
            actions: [
              WidgetDoubleBtn(
                leftFunc: (){
                  title = "";
                  context.pop();
                },
                rightFunc: (){
                  context.pop();
                },
                width: maxWidth,
                height: btnPartHeight,
              )
            ],
          );
        });
    return title;
  }
}//endclass