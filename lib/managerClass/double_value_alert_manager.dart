import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';
import 'package:myhealthdiary_app/common/widget/widget_double_btn.dart';
import 'package:myhealthdiary_app/managerClass/designed_alert.dart';

import '../common/widget/widget_custom_text_box.dart';
import '../provider/collection_of_basic_state_provider.dart';

Future<double> doubleValueAlertManager (WidgetRef ref, String title, String metric,
  double initialValue, double min, double max)  async {
  double maxWidth = (MediaQuery.of(ref.context).size.width) * 0.8;
  double maxHeight = (MediaQuery.of(ref.context).size.height) ;
  // double state = ref.watch(insertDoubleValueProvider(initialValue));

  //return 받을 값.
  double result =initialValue;
  await showDialog(
    barrierDismissible: false,
    context: ref.context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: constSemiLightColor,
        title: SizedBox(
          child: WidgetCustomTextBox(
              fontColor: constOnSemiLight,
              height: maxHeight * 0.1,
              width: maxWidth * 0.8,
              msg: title,
              fontSize: (maxWidth * 0.1).clamp(15, 30)),
        ),
        //미리 디자인해둔 alert Content를 넣는다.
        content: AlertContentForSliderWiget(
          initialValue: initialValue,
          min: min,
          max: max,
          metric: metric,
          onChange: (newValue) {
            ref.read(insertDoubleValueProvider(initialValue).notifier).state = newValue;
            result = newValue;
            print(result);
          },
        ),
        actions: [
          WidgetDoubleBtn(
            width: maxWidth,
            height: maxWidth / 8,
            leftFunc: () {
              //취소 기능을 수행하는 파트.
              ref.read(insertDoubleValueProvider(initialValue).notifier).state = initialValue;
              result = initialValue;
              context.pop();
            },
            rightFunc: () {
              // state 값을 반환하면서 초기화 시켜야 한다.
              // 임시 변수 result 이용.
              ref.read(insertDoubleValueProvider(initialValue).notifier).state = initialValue;
              context.pop();
            },
          ),
        ],
      );
    },
  );
  return result;
}
