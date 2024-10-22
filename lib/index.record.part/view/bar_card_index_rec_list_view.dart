
import 'package:flutter/material.dart';
import 'package:myhealthdiary_app/common/const/size.dart';

import '../../common/const/basic_method.dart';
import '../../common/component/widget_custom_text_box.dart';


class BarCardIndexRecListView extends StatelessWidget {
  final double maxValue;
  final double? value;
  final double height;
  final double width;
  final Color color;
  final String sort;
  const BarCardIndexRecListView({
    super.key,
    required this.maxValue,
    required this.value,
    required this.height,
    required this.width,
    required this.color,
    required this.sort,
  });

  @override
  Widget build(BuildContext context) {
    //true 면 값이 있고, false면 값이 없다.
    final bool opt = !(value == null);
    final double maxHeight = height *0.8;
    final double heightValue;
    !opt
        ? heightValue = maxHeight
        : heightValue =
            roundMethod(((maxHeight * value!) / maxValue).clamp(0, maxHeight));
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          color: opt ? color : Colors.black.withOpacity(0.08),
          width: width,
          height: heightValue,
          child: opt
              ? null
              : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                WidgetCustomTextBox(width: width, height: heightValue, msg: "X", fontSize: fontSize(context, 3))
                ]
                ),
        ),
        WidgetCustomTextBox(
          verAlign: 1,
          width: width,
          height: height*0.15,
          msg: sort,
          fontSize: fontSize(context, 0.01),
          bold: true,
        )
      ],
    );
  }
}