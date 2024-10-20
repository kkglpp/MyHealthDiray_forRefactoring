import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_text_box.dart';

class TrainShowPlanCard extends ConsumerWidget {
  final Color bgclr;
  final String title;
  final String date;
  final double maxWidth;
  final double maxHeight;
  final double sidePad;
  final double leftWidth;
  final double centerWidth;
  final double rightWidth;
  const TrainShowPlanCard(
      {super.key,
      required this.bgclr,
      required this.title,
      required this.maxWidth,
      required this.maxHeight,
      required this.date,
      required this.sidePad,
      required this.leftWidth,
      required this.centerWidth,
      required this.rightWidth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
          color: bgclr,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(20)),
      width: maxWidth,
      height: maxHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: sidePad,
          ),
          WidgetCustomTextBox(
              fontAlign: 0,
              verAlign: 1,
              width: leftWidth,
              height: maxHeight,
              msg: title,
              fontSize: title.length > 8
                  ? fontSize(context, 2)
                  : fontSize(context, 2)),
          WidgetCustomTextBox(
              verAlign: 1,
              fontAlign: 2,
              width: centerWidth,
              height: maxHeight,
              msg: "운동 예정일 : ",
              fontSize: fontSize(context, 2)),
          WidgetCustomTextBox(
              verAlign: 1,
              fontAlign: 2,
              width: rightWidth,
              height: maxHeight,
              msg: date,
              fontSize: fontSize(context, 2)),
          SizedBox(
            width: sidePad,
          ),
        ],
      ),
    );
  }
}
