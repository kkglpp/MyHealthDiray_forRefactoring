// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/baseModel/training_plan_model.dart';
import 'package:myhealthdiary_app/common/const/base_alert.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/widget/layOut/base_layout.dart';
import 'package:myhealthdiary_app/common/widget/widget_banner_for_ad.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_text_box.dart';
import 'package:myhealthdiary_app/common/widget/widget_double_btn.dart';
import 'package:myhealthdiary_app/managerClass/double_value_alert_manager.dart';
import 'package:myhealthdiary_app/provider/providerForShared/collection_of_basic_state_provider.dart';
import 'package:myhealthdiary_app/provider/providerForSportList/sport_info_notifier.dart';
import 'package:myhealthdiary_app/provider/providerForTrainPart/train_plan_add_new_sport_notifier.dart';
import 'package:myhealthdiary_app/provider/providerForTrainPart/train_plan_daily_notifier.dart';
import 'package:myhealthdiary_app/view/TrainPlanPart/plan_add_new_title_view.dart';

class PlanAddNewSportView extends ConsumerWidget {
  static String routeForPlanAddNewSportSet = "routeForPlanAddNewSportSet";
  static String routeForPlanUpdateSportSet = "routeForPlanUpdateSportSet";
  const PlanAddNewSportView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseLayout(
        barTitle: "운동 계획 입력",
        body: LayoutBuilder(
          builder: (context, constraints) {
            double maxWidth = constraints.maxWidth - 20;
            double maxHeight = constraints.maxHeight;

            //높이 계산
            double sportTitleHeight = maxHeight * 0.1;
            double divHeight = maxHeight * 0.02;
            double setBoxHeight = maxHeight * 0.62;
            double setRowHeight = maxHeight * 0.08;
            double btnHeight = maxHeight * 0.08;

            //넓이 계산
            //Title 부분 안에서의 박스 넓이
            double sportTitleWidth = maxWidth * 0.5;
            double sportTitleBtnWidth = maxWidth * 0.15;
            double sportTitleSetTexWidth = maxWidth * 0.2;
            //각 세트 카드내 width
            double boxSetNumWidth = maxWidth * 0.15;
            double boxValueWidth = maxWidth * 0.24;
            double paddingWidth = maxWidth * 0.02;
            double boxMetricWidth = maxWidth * 0.16;

            //글씨크기 계산
            double sportNameSize = fontSize(context, 6);
            double setNumSize = fontSize(context, 6);
            double cardFontSize = fontSize(context, 3);
// 스포츠 ID 및 정보들 가져오기
            int sportID = ref.read(showSportIdProvider.notifier).state;
            final sportInfo = ref.watch(sportInfoProvider(sportID));

// 실제로 운동셋트들을 저장하고 기록할 상태
            final state = ref.watch(trainPlanAddNewSportNotifierProvider);
            List<TrainingPlanModel> setList = state.when(
              data: (data) {
                return data;
              },
              error: (error, stackTrace) {
                return [];
              },
              loading: () {
                return [];
              },
            );
/* 여기부터 화면 구성. */
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      WidgetCustomTextBox(
                        width: sportTitleWidth,
                        height: sportTitleHeight,
                        msg: sportInfo.sportName,
                        fontSize: sportNameSize,
                      ),
                      SizedBox(
                        width: sportTitleBtnWidth,
                        child: IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            ref
                                .read(trainPlanAddNewSportNotifierProvider
                                    .notifier)
                                .subModel();
                          },
                        ),
                      ),
                      WidgetCustomTextBox(
                        width: sportTitleSetTexWidth,
                        msg: setList.length.toString(),
                        fontSize: setNumSize,
                      ),
                      SizedBox(
                        width: sportTitleBtnWidth,
                        child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            ref
                                .read(trainPlanAddNewSportNotifierProvider
                                    .notifier)
                                .addEmptyModel();
                          },
                        ),
                      ),
                    ], //첫행 로우.
                  ), //row
                  SizedBox(
                    width: maxWidth,
                    height: setBoxHeight,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 7,
                          child: Divider(
                            color: constMainColor,
                          ),
                        );
                      },
                      itemCount: setList.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: maxWidth,
                          height: setRowHeight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              WidgetCustomTextBox(
                                  width: boxSetNumWidth,
                                  msg: "${index + 1} 세트 ",
                                  fontSize: cardFontSize),
                              GestureDetector(
                                onTap: () async {
                                  double? newValue =
                                      await doubleValueAlertManager(
                                          ref,
                                          sportInfo.sportName,
                                          sportInfo.metric1,
                                          0,
                                          0,
                                          650);
                                  if (newValue == null) {
                                    return;
                                  }
                                  ref
                                      .read(trainPlanAddNewSportNotifierProvider
                                          .notifier)
                                      .setRec1Value(index, newValue);
                                },
                                child: WidgetCustomTextBox(
                                  fontAlign: 2,
                                  width: boxValueWidth,
                                  msg: setList[index].tpRec1.toString(),
                                  fontSize: cardFontSize,
                                  fontColor: Colors.purple,
                                  bold: true,
                                ),
                              ),
                              SizedBox(
                                width: paddingWidth,
                              ),
                              WidgetCustomTextBox(
                                  fontAlign: 0,
                                  width: boxMetricWidth,
                                  msg: sportInfo.metric1,
                                  fontSize: cardFontSize),
                              GestureDetector(
                                onTap: () async {
                                  double? newValue =
                                      await doubleValueAlertManager(
                                          ref,
                                          sportInfo.sportName,
                                          sportInfo.metric2,
                                          0,
                                          0,
                                          650);
                                  if (newValue == null) {
                                    return;
                                  }
                                  ref
                                      .read(trainPlanAddNewSportNotifierProvider
                                          .notifier)
                                      .setRec2Value(index, newValue);
                                },
                                child: WidgetCustomTextBox(
                                  fontAlign: 2,
                                  width: boxValueWidth,
                                  msg: setList[index].tpRec2.toString(),
                                  fontSize: cardFontSize,
                                  fontColor: Colors.purple,
                                  bold: true,
                                ),
                              ),
                              SizedBox(
                                width: paddingWidth,
                              ),
                              WidgetCustomTextBox(
                                  fontAlign: 0,
                                  width: boxMetricWidth,
                                  msg: sportInfo.metric2,
                                  fontSize: cardFontSize),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  BannerForAd(),
                  WidgetDoubleBtn(
                    leftFunc: () {
                      context.pop();
                    },
                    rightFunc: () async {
                      print("savePlave : ${ref.read(titleProvider.notifier).state}");
                      //저장여부 확인하고
                      bool confirm =
                          await baseAlertForConfirm(context, "저장 하시겠습니까?");
                      if (!confirm) {
                        return;
                      }
                      //저장하고
                      await ref
                          .read(trainPlanAddNewSportNotifierProvider.notifier)
                          .savePlanList();
                      print("savePlave2 : ${ref.read(titleProvider.notifier).state}");

                      //돌아갈화면 초기화
                      await ref
                          .read(trainPlanDailyNotifierProvider.notifier)
                          .refreshState();
                      //저장후 이동하는 곳은 detail 그날 계획들을 보던 곳.
                      print("savePlave3 : ${ref.read(titleProvider.notifier).state}");

                      context
                          .goNamed(PlanAddNewTitleView.routeForPlanAddNewTitle);
                    },
                    width: maxWidth,
                    height: btnHeight,
                    rightMsg: "✏️ Save Plan",
                  )
                ], //전체 Column
              ),
            );
          },
        ));
  }
}
