import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/basic_method.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/component/layOut/base_layout.dart';
import 'package:myhealthdiary_app/common/component/widget_custom_elebtn.dart';
import 'package:myhealthdiary_app/common/component/widget_custom_text_box.dart';
import 'package:myhealthdiary_app/common/provider/providerForShared/collection_of_basic_state_provider.dart';
import 'package:myhealthdiary_app/train.plan.part/view/plan_day_todo_list_view.dart';
import 'package:myhealthdiary_app/train.rec.part/view/train_show_plan_view.dart';

class TrainRecHomeView extends ConsumerWidget {
  static String routeForTrainHome = "routeForTrainHome";
  const TrainRecHomeView({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return BaseLayout(body: LayoutBuilder(
      builder: (context, constraints) {
        return LayoutBuilder(builder: (context, constraints) {
          final double maxWidth = constraints.maxWidth - 20;
          final double maxHeight = constraints.maxHeight;
          //높이 계산
          double imgbtnHeight = min(maxHeight * 1 / 3, maxWidth * 0.8);
          double btnHeight = maxHeight * 0.08;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 5,
                ),
// 이전에 세운 계획을 가지고 운동하러 가는 버튼                
                GestureDetector(
                  onTap: (){
                    context.goNamed(TrainShowPlanView.routeForShowPlanForTrain);
                  },
                  child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black),
                      width: imgbtnHeight,
                      height: imgbtnHeight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "images/Plan.png",
                          fit: BoxFit.contain,
                          opacity: const AlwaysStoppedAnimation(0.4),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: imgbtnHeight,
                      height: imgbtnHeight,
                      child: Center(
                          child: WidgetCustomTextBox(
                              fontColor: Colors.white,
                              bold: true,
                              msg: "이전에 세운 \n 운동 계획 수행 ",
                              fontSize: fontSize(context, 9))),
                    )
                  ]),
                ),
                GestureDetector(
                  onTap: (){
/*
계획 없이 운동하러 가는 버튼이다.
하지만, 나는 무조건 계획을 넣어야 그대로 운동하게 할거니까.
  계획을 넣는 페이지랑 똑같이 가게한다.
  다만 날짜는 지정해서 보내야함. 
즉.
1.selecteDayProvider -> 오늘 날짜로 고정. 
2.title도 오늘 날짜로 고정해야, 귀찮은 중복 버그를 방지할 수 있다. 
3. 화면 이동. : plan_day_todoListView 로 이동.
 */                    
                      ref.read(selectedDayProvider.notifier).state = DateTime.now();
                      ref.read(titleProvider.notifier).state =onlyDay(DateTime.now());
                      context.goNamed(PlanDayTodoListView.routeForReadyWithoutPlan);
                  },
                  child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black),
                      width: imgbtnHeight,
                      height: imgbtnHeight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "images/dumbel.jpg",
                          fit: BoxFit.fill,
                          opacity: const AlwaysStoppedAnimation(0.4),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: imgbtnHeight,
                      height: imgbtnHeight,
                      child: Center(
                          child: WidgetCustomTextBox(
                              fontColor: Colors.white,
                              bold: true,
                              msg: "그냥 지금 가기.",
                              fontSize: fontSize(context, 9))),
                    )
                  ]),
                ),
                WidgetCustomEleBtn(
                    msg: "🏠 홈으로",
                    color: constMainColor,
                    onPressed: () {
                      context.pop();
                    },
                    width: maxWidth,
                    height: btnHeight,
                    fontSize: fontSize(context, 3))
              ],
            ),
          );
        });
      },
    ));
  }
}
