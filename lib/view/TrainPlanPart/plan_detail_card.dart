import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_text_box.dart';
import 'package:myhealthdiary_app/provider/providerForSportList/sport_info_notifier.dart';
import 'package:myhealthdiary_app/view/TrainPlanPart/plan_add_new_title_view.dart';

import '../../baseModel/training_plan_model.dart';
import '../../provider/providerForShared/collection_of_basic_state_provider.dart';

class PlanDetailCard extends ConsumerWidget {
  final PlanListOfPlanSet set;
  final double width;
  final double height;

  ///"plan" : 계획대로 보러 가기  "train" : 계획대로 운동하러가기
  final String opt;
  const PlanDetailCard(
      {super.key,
      required this.set,
      required this.width,
      required this.height,
      required this.opt});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 각 부분 넓이 계산
    double sportNameWidth = width * 0.3;
    double totalCountWidth = width * 0.3;
    double doneCountWidth = width * 0.3;
    final state = ref.watch(sportInfoProvider(set.tpSId));

    return GestureDetector(
      onTap: () {
        ref.read(titleProvider.notifier).state = set.tpTitle;
        ref.read(showSportIdProvider.notifier).state = set.tpSId;
        if (opt == "train") {
          // context.goNamed(TrainingStartView.routeName1);
        }
        if (opt == "plan") {
          context.goNamed(PlanAddNewTitleView.routeForPlanDetailView);
        }
      },
      child: SizedBox(
        width: width,
        height: height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            WidgetCustomTextBox(
              fontAlign: 1,
              verAlign: 1,
              width: sportNameWidth,
              height: height,
              msg: state.sportName.toString(),
              fontSize: fontSize(context, 5),
            ),
            WidgetCustomTextBox(
                fontAlign: 2,
                verAlign: 1,
                width: totalCountWidth,
                height: height,
                msg: "총 세트 수 : ${set.totalCount}",
                fontSize: fontSize(context, 3)),
            WidgetCustomTextBox(
                fontAlign: 2,
                verAlign: 1,
                width: doneCountWidth,
                height: height,
                msg: "수행 세트 수 : ${set.doneCount}",
                fontSize: fontSize(context, 3)),
          ],
        ),
      ),
    );
  }
}
