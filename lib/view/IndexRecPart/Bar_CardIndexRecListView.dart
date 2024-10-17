
import 'package:flutter/material.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/widget/WidgetCustomTextBox.dart';

import '../../common/basicMethod.dart';

class BarCardIndexRecListView extends StatelessWidget {
  final double maxValue;
  final double? value;
  final double maxHeight;
  final double width;
  final Color color;
  final String sort;
  const BarCardIndexRecListView({
    super.key,
    required this.maxValue,
    required this.value,
    required this.maxHeight,
    required this.width,
    required this.color,
    required this.sort,
  });

  @override
  Widget build(BuildContext context) {
    //true 면 값이 있고, false면 값이 없다.
    final bool opt = !(value == null);
    final double height;
    !opt
        ? height = maxHeight
        : height =
            roundMethod(((maxHeight * value!) / maxValue).clamp(0, maxHeight));
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          color: opt ? color : Colors.black.withOpacity(0.08),
          width: width,
          height: height,
          child: opt
              ? null
              : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                WidgetCustomTextBox(width: width, height: height, msg: "X", fontSize: fontSize(context, 3))
                ]
                ),
        ),
        SizedBox(
          width: width,
          height: maxHeight*0.05,
          child: WidgetCustomTextBox(
            width: width, height: maxHeight*0.05,
            msg: sort,
            fontSize: fontSize(context, 3),
            bold: true,
          ),
        )
      ],
    );
  }
}