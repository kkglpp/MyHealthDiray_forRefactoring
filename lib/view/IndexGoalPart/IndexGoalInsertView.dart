import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/common/widget/BaseLayout.dart';
import 'package:myhealthdiary_app/common/widget/WidgetCustomTextBox.dart';

class IndexGoalInsertView extends ConsumerWidget {
  static String routeNameForIndexGoalInsertView = "routeNameForIndexGoalInsert";
  static String routeNameForIndexGoalUpdateView = "routeNameForIndexGoalInsert";
  const IndexGoalInsertView({super.key});

// GoalModel 을 입력하는 페이지.
// 상태관리는 GoalModel 하나를 가지고 한다.
// 최초 상태는 goalModel ID = 0 이다.
// notifier : IndexGoalNotifier    //-> detailView에서도 같이 쓸 수 있는 요소이다.
// Provider : InsertIndexGoalModelProvider

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseLayout(
        barTitle: "새로운 목표 설정하기",
        leadbtn: SizedBox(),
        body: LayoutBuilder(builder: (context, constraints) {
          double maxHeight = constraints.maxHeight;
          double maxWidth = constraints.maxWidth - 20;
// 큰 이미지 하나 들어간다.
          double imgHeight = maxHeight * 0.35;
          //수치들을 입력받는 파트
          double boxHeight = maxHeight * 0.4;
//수치를 각각 입력 받는 sizedbox 높이
          double smallboxHeight = boxHeight * 0.14;
          double leftWidth = (maxWidth * 0.5) * 0.35;
          double midWidth = (maxWidth * 0.5) * 0.4;
          double rightWidth = (maxWidth * 0.5) * 0.25;
          //간단한 설명이 들어가는 파트
          double descriptHeight = maxHeight * 0.10;
          //버튼 두개 들어가는 곳
          double btnHeight = maxHeight * 0.1;
          return Center(
            child: Column(
              children: [
                Container(
                  width: maxWidth,
                  height: imgHeight,
                  color: Colors.black,
                  child: WidgetCustomTextBox(
                    fontColor: Colors.white,
                    msg: "No Image \n Click to insert Picture",
                    fontSize: (imgHeight*0.2).clamp(12, 25),
                  ),
                )
              ],
            ),
          );
        }));
  }
}
