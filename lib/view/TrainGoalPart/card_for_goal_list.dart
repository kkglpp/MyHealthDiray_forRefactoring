import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/common/component/widget_custom_text_box.dart';
import 'package:myhealthdiary_app/model/training_goal_model.dart';
import 'package:myhealthdiary_app/provider/providerForSportList/sport_info_notifier.dart';
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
    final sportInfo = ref.watch(sportInfoProvider(goal.tgSId));

    double titleSize = fontSize(context, 2);
    double recSize = fontSize(context, 2);
    double metricSize = fontSize(context, 1);
    double dateSize = fontSize(context, 1);
    //각 요소들 넓이 값 설정
    double titleWidth = maxWidth*0.22;
    double goalWidth = maxWidth * 0.13;
    double metricWidth = maxWidth *0.13;
    double dateWidth = maxWidth * 0.2;

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
            width: titleWidth,
            msg: sportInfo.sportName,
            fontSize: titleSize,
          ),
          WidgetCustomTextBox(
            fontAlign: 2,
            width: goalWidth,
            msg:goal.tgGoal1.toString(),
            fontSize: recSize,
          ),
          const SizedBox(
            width: 2,
          ),
          WidgetCustomTextBox(
            fontAlign: 0,
            width: metricWidth,
            msg: sportInfo.metric1,
            fontSize: metricSize,
          ),
          WidgetCustomTextBox(
            fontAlign: 2,
            width: goalWidth,
            msg: goal.tgGoal2.toString(),
            fontSize: recSize,
          ),
          const SizedBox(
            width: 2,
          ),          
          WidgetCustomTextBox(
            fontAlign: 0,
            width: metricWidth,
            msg: sportInfo.metric2,
            fontSize: metricSize,
          ),
          WidgetCustomTextBox(
            width: dateWidth,
            msg: goal.tgDueDate,
            fontSize: dateSize,
          ),
        ],
      ),
    );
  }
}
