import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/widget/layOut/base_layout.dart';
import 'package:myhealthdiary_app/common/widget/widget_double_btn.dart';
import 'package:myhealthdiary_app/provider/providerForTrainPart/train_plan_list_notifier.dart';
import 'package:myhealthdiary_app/view/TrainPlanPart/box_plan_list.dart';
import 'package:myhealthdiary_app/view/TrainPlanPart/carlendar_plan_list.dart';
import 'package:myhealthdiary_app/view/TrainPlanPart/plan_add_new_title_view.dart';

import '../../provider/providerForShared/collection_of_basic_state_provider.dart';

class TrainPlanListView extends ConsumerWidget {
  static String routeForTrainPlanListView = "routeForTrainPlanListView";
  const TrainPlanListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseLayout(
        barTitle: "운동 계획 보기",
        leadbtn: const SizedBox(),
        body: LayoutBuilder(
          builder: (context, constraints) {
            double maxWidth = constraints.maxWidth - 20;
            double maxHeight = constraints.maxHeight;
            //높이 계산
            double carlendarHeight = maxHeight * 0.6;
            double planBoxHeight = maxHeight * 0.28;
            double btnHeight = maxHeight * 0.08;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CarlendarPlanList(
                      maxWidth: maxWidth, maxHeight: carlendarHeight),
                  Consumer(builder: (context, ref, child) {
                    final selectDayState = ref.watch(selectedDayProvider);                 
                    final state = ref.watch(trainPlanListProvider);
                    return BoxPlanList(
                      width: maxWidth,
                      height: planBoxHeight,
                      dailyPlanList: state[turnDate(selectDayState)]??[],
                    );
                  }),
                  WidgetDoubleBtn(
                    leftFunc: () {
                      context.pop();
                    },
                    rightFunc: () {
                      //새로운 플랜 추가하는 버튼
                      ref.read(titleProvider.notifier).state="";
                      context.goNamed(PlanAddNewTitleView.routeForPlanAddNewTitle);
                    },
                    width: maxWidth,
                    height: btnHeight,
                    rightMsg: "✏️  New Plan",
                  )
                ],
              ),
            );
          },
        ));
  }
    turnDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
