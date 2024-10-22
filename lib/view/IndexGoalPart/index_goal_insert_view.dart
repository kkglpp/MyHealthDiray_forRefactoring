import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';
import 'package:myhealthdiary_app/common/component/widget_double_btn.dart';
import 'package:myhealthdiary_app/provider/index_goal_notifier.dart';
import 'package:myhealthdiary_app/view/indexGoalPart/card_index_goal_value.dart';


import '../../common/const/basic_method.dart';
import '../../common/component/layOut/base_layout.dart';
import '../../common/component/widget_custom_text_box.dart';
import '../../common/const/base_alert.dart';
import '../../provider/index_goal_list_notifier.dart';

class IndexGoalInsertView extends ConsumerWidget {
  static String routeNameForIndexGoalInsertView = "routeNameForIndexGoalInsert";
  // static String routeNameForIndexGoalUpdateView = "routeNameForIndexGoalInsert";
  final bool forInsert;
  const IndexGoalInsertView({super.key, required this.forInsert});

// GoalModel 을 입력하는 페이지.
// 상태관리는 GoalModel 하나를 가지고 한다.
// 최초 상태는 goalModel ID = 0 이다.
// notifier : IndexGoalNotifier    //-> detailView에서도 같이 쓸 수 있는 요소이다.
// Provider : InsertIndexGoalModelProvider

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelState = ref.watch(insertIndexGoalModelProvider);
    return LayoutBuilder(builder: (context, constraints) {
      double maxHeight = constraints.maxHeight;
      double maxWidth = constraints.maxWidth - 20;
// 큰 이미지 하나 들어간다.
      double imgHeight = maxHeight * 0.35;
      //수치들을 입력받는 파트
      double boxHeight = maxHeight * 0.4;
//수치를 각각 입력 받는 sizedbox 높이
      double smallboxHeight = boxHeight * 0.3;
      double leftWidth = (maxWidth * 0.5) * 0.35 - 1;
      double midWidth = (maxWidth * 0.5) * 0.4 - 1;
      double rightWidth = (maxWidth * 0.5) * 0.25 - 4;
      //간단한 설명이 들어가는 파트
      double descriptHeight = maxHeight * 0.04;
      //버튼 두개 들어가는 곳
      double btnHeight = maxHeight * 0.07;
      return BaseLayout(
          barTitle: "새로운 목표 설정하기",
          // leadbtn: SizedBox(),
          body: modelState == null
          ?Center(
            child: SizedBox(
              width: maxWidth,
              height: maxHeight.clamp(maxWidth, maxHeight),
              child: const CircularProgressIndicator(),
            ),
          )
          : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
// 사진 파트가 들어가는 부분
                Container(
                  width: maxWidth,
                  height: imgHeight,
                  color: Colors.black,
                  child: WidgetCustomTextBox(
                    fontColor: Colors.white,
                    msg: "No Image \n Click to insert Picture",
                    fontSize: (imgHeight * 0.2).clamp(12, 25),
                  ),
                ),
//수치들을 입력받는 파트가 들어가는 부분
//index / value / metric 이 들어가는 Widget을 따로 만들자. => CardIndexGoalValuec
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  width: maxWidth,
                  height: boxHeight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CardIndexGoalValue(
                            value: modelState.hgHeight,
                            index: "신 장 : ",
                            metric: "cm",
                            min: 0,
                            max: 250,
                            leftWidth: leftWidth,
                            midWidth: midWidth,
                            rightWidth: rightWidth,
                            height: smallboxHeight,
                            changeValue: (newValue) {
                              ref
                                  .read(insertIndexGoalModelProvider.notifier)
                                  .changedHeight(newValue);
                            },
                            opt: forInsert,
                          ),
                          CardIndexGoalValue(
                            value: modelState.hgWeight,
                            index: "체 중 : ",
                            metric: "kg",
                            min: 0,
                            max: 250,
                            leftWidth: leftWidth,
                            midWidth: midWidth,
                            rightWidth: rightWidth,
                            height: smallboxHeight,
                            changeValue: (newValue) {
                              ref
                                  .read(insertIndexGoalModelProvider.notifier)
                                  .changedWeight(newValue);
                            },
                            opt: forInsert,
                          ),
                          CardIndexGoalValue(
                            value: calcBMI(
                                modelState.hgHeight, modelState.hgHeight),
                            index: "BMI :",
                            metric: "",
                            min: 0,
                            max: 250,
                            leftWidth: leftWidth,
                            midWidth: midWidth,
                            rightWidth: rightWidth,
                            height: smallboxHeight,
                            changeValue: (newValue) {},
                            opt: false,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 2,
                        child: VerticalDivider(
                          color: Colors.grey,
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CardIndexGoalValue(
                            value: modelState.hgFat,
                            index: "체지방율 : ",
                            metric: "%",
                            min: 0,
                            max: 250,
                            leftWidth: leftWidth,
                            midWidth: midWidth,
                            rightWidth: rightWidth,
                            height: smallboxHeight,
                            changeValue: (newValue) {
                              ref
                                  .read(insertIndexGoalModelProvider.notifier)
                                  .changedFat(newValue);
                            },
                            opt: forInsert,
                          ),
                          CardIndexGoalValue(
                            value: modelState.hgMuscle,
                            index: "골격근량 : ",
                            metric: "kg",
                            min: 0,
                            max: 250,
                            leftWidth: leftWidth,
                            midWidth: midWidth,
                            rightWidth: rightWidth,
                            height: smallboxHeight,
                            changeValue: (newValue) {
                              ref
                                  .read(insertIndexGoalModelProvider.notifier)
                                  .changedMuscle(newValue);
                            },
                          ),
                          CardIndexGoalValue(
                            value: modelState.hgDuedate,
                            index: "duedate :",
                            metric: "",
                            min: 0,
                            max: 250,
                            leftWidth: leftWidth,
                            midWidth: midWidth,
                            rightWidth: rightWidth,
                            height: smallboxHeight,
                            changeValue: (newValue) {
                              ref
                                  .read(insertIndexGoalModelProvider.notifier)
                                  .changedDuedate(newValue);
                            },
                            opt: forInsert,
                            date: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  color: constSemiLightColor,
                  width: maxWidth,
                  height: descriptHeight,
                  child: WidgetCustomTextBox(
                    msg: "클릭하여 각 각 지표를 입력하세요.",
                    fontSize: (maxWidth / 35).clamp(7, 11),
                  ),
                ),
                WidgetDoubleBtn(
                  //CancelBtn 이 들어가는 자리이다.
                  leftFunc: () {
                    //상태를 초기화 한다.
                    if (forInsert){
                      //insertView로 왔을 경우
                      ref
                          .read(insertIndexGoalModelProvider.notifier)
                          .initForInsertModel();
                    }
                    //pop 시킨다.
                   // ignore: use_build_context_synchronously
                    context.pop();
                  },
                  //CancelBtn 이 들어가는 자리이다.
                  rightFunc: () async {
                    bool confirm =
                        await baseAlertForConfirm(context, "정말로 저장 하시겠습니까?");
                    if (!confirm) {
                      return;
                    }
                    //저장하고
                    await ref
                        .read(insertIndexGoalModelProvider.notifier)
                        .insertHealthGoal();
                    //초기화 하고
                    ref
                        .read(insertIndexGoalModelProvider.notifier)
                        .initForInsertModel();
                    //List상태 새로고침하기.
                    await ref
                        .read(healthIndexGoalListProvider.notifier)
                        .initializeState();
                    //화면 나가기.
                    // ignore: use_build_context_synchronously
                    context.pop();
                  },
                  width: maxWidth,
                  height: btnHeight,
                  leftMsg: "☒ 취 소",
                  rightMsg: "🏆 저 장",
                ),
              ],
            ),
          ));
    });
  }
}
