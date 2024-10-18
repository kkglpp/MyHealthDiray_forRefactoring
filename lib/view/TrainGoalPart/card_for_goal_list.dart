import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/baseModel/training_goal_model.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_text_box.dart';
import 'package:myhealthdiary_app/provider/sharedStateNotifier/sport_info_notifier.dart';

import '../../common/const/colors.dart';
import '../../common/const/size.dart';

class CardForGoalList extends ConsumerWidget {
  final TrainingGoalModel goal;
  final double maxWidth;
  final double height;

  const CardForGoalList( {
    super.key,
    required this.goal,
    required this.maxWidth,required this.height,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sportInfo = ref.read(sportInfoProvider(goal.tgSId));

    double titleSize = fontSize(context, 4);
    double recSize = fontSize(context, 3);
    double metricSize = fontSize(context, 2);
    double dateSize = fontSize(context, 1);

    return Container(
      height: height,
      width: maxWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: goal.tgSuccess == 1
            ? constSuccessColor //성공 목록 카드 색
            : goal.tgSuccess == 2
                ? constFailColor //실패 목록 카드색
                : constNeutralColor, // 기본색
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          WidgetCustomTextBox(
            msg: sportInfo.sportName,
            fontSize: titleSize,
          ),
          WidgetCustomTextBox(
            msg: goal.tgGoal1.toString(),
            fontSize: recSize,
          ),
          WidgetCustomTextBox(
            msg: sportInfo.metric1,
            fontSize: metricSize,
          ),
          WidgetCustomTextBox(
            msg: goal.tgGoal2.toString(),
            fontSize: recSize,
          ),
          WidgetCustomTextBox(
            msg: sportInfo.metric2,
            fontSize: metricSize,
          ),
          WidgetCustomTextBox(
            msg: goal.tgDueDate,
            fontSize: dateSize,
          ),
        ],
      ),
    );
  }
}
