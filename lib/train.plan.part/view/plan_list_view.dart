import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/widget/layOut/base_layout.dart';
import 'package:myhealthdiary_app/common/widget/widget_double_btn.dart';
import 'package:myhealthdiary_app/train.plan.part/provider/train_plan_list_notifier.dart';
import 'package:myhealthdiary_app/train.plan.part/view/plan_list_box_part.dart';
import 'package:myhealthdiary_app/train.plan.part/view/plan_list_carlendar_part.dart';
import 'package:myhealthdiary_app/train.plan.part/view/plan_day_todo_list_view.dart';

import '../../common/provider/providerForShared/collection_of_basic_state_provider.dart';

class TrainPlanListView extends ConsumerWidget {
  static String routeForTrainPlanListView = "routeForTrainPlanListView";
  const TrainPlanListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
        // print(GoRouterState.of(context).uri.toString()  );

    return BaseLayout(
        barTitle: "훈련 일정 관리",
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
                  PlanListCarlendarPart(
                      maxWidth: maxWidth, maxHeight: carlendarHeight),
                  Consumer(builder: (context, ref, child) {
                    final selectDayState = ref.watch(selectedDayProvider);                 
                    final state = ref.watch(trainPlanListProvider);
                    return PlanListBoxPart(
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
                      context.goNamed(PlanDayTodoListView.routeForPlanAddNewTitle);
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
