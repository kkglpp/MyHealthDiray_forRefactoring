// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/model/training_plan_model.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/component/widget_custom_elebtn.dart';
import 'package:myhealthdiary_app/common/component/widget_custom_text_box.dart';
import 'package:myhealthdiary_app/common/provider/providerForShared/collection_of_basic_state_provider.dart';
import 'package:myhealthdiary_app/sport.list.part/provider/sport_info_notifier.dart';
import 'package:myhealthdiary_app/train.plan.part/provider/train_plan_add_new_sport_notifier.dart';
import 'package:myhealthdiary_app/train.plan.part/provider/train_plan_daily_notifier.dart';

import '../../common/const/basic_method.dart';
import '../../common/component/layOut/base_layout.dart';
import 'train_start_card.dart';

class TrainStartView extends ConsumerWidget {
  static String routeForStartWithPlan = "routeForStartWithPlan";
  static String routeForStartWithoutPlan = "routeForStartWithoutPlan";

  /// AsPlan : 계획대로 운동하기
  /// WithoutPlan : 계획 없이 운동하기
  final String opt;

  //여기서가 운동 수행을  기록한다.
  //휴식시간을 잴 수 있는 간단한 Timer를 제공한다.
  //세트마다 버튼을 누르면 Plan table에 done 상태가 된다.
  //그리고 Rec 테이블에도 수행기록이 남는다.
  const TrainStartView({super.key, required this.opt});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 수행하는 스포츠 아이디 정보.
    final sportId = ref.watch(showSportIdProvider);
    // 수행하는  계획 이름 정보
    // final planTitle = ref.watch(titleProvider);

    // 수행할 sportID - planTitle - 훈련 예정일 로 planDate에서 계획들을 가져 온다.
    // 이떄 planID 도 가져와서 이 아이디로 done 상태를 업데이트 한다. -> 폐기. 생각해보니 굳이 중복해서 데이터를 저장할 필요가 없다.
    final originState = ref.watch(trainPlanAddNewSportNotifierProvider);

    List<TrainingPlanModel> planState = originState.when(
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

    //Timer를 위한 상태들이다.
    final timerState = ref.watch(doublForTimerProvider);
    final timerMax = ref.watch(doublForTimerProviderMax);
    final sportInfo = ref.watch(sportInfoProvider(sportId));
    return BaseLayout(
      barTitle: "운동 수행 페이지.",
      leadbtn: const SizedBox(),
      body: LayoutBuilder(builder: (context, constraints) {
        double maxWidth = constraints.maxWidth - 20;
        double maxHeight = constraints.maxHeight;
        //높이 계산
        double titleHeight = maxHeight * 0.08;
        double divHeight = maxHeight * 0.01;
        double timerBoxHeight = maxHeight * 0.35;
        double setListBoxHeight = maxHeight * 0.4;
        double btnHeight = maxHeight * 0.08;

        //세부높이 계산
        double timerTxtHeight = maxHeight * 0.08;
        double timerSliderHeight = maxHeight * 0.12;
        double timerValueHeight = maxHeight * 0.13;
        double timerBtnHeight = maxHeight * 0.11;
        double cardHeight = maxHeight * 0.08;

        //넓이 계산
        //타이머 파트
        double timerSlideWidth = maxWidth * 0.5;
        double timerBtnPartWidth = maxWidth * 0.45;
        double timerValueBtnWidth = maxWidth * 0.22;

        //운동세트 카드 사이즈

        //글씨크기 게산
        double titleSize = fontSize(context, 10);
        double timerTxtSize = fontSize(context, 4);
        double timerIntSize = fontSize(context, 6);
        double timerBtnSize = fontSize(context, 4);

        double cardSize = fontSize(context, 2);

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              WidgetCustomTextBox(
                  width: maxWidth,
                  height: titleHeight,
                  verAlign: 2,
                  fontAlign: 1,
                  msg: sportInfo.sportName,
                  fontSize: titleSize),
              SizedBox(
                width: maxWidth * 0.9,
                height: divHeight,
                child: const Divider(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                // color: Colors.green[200],
                width: maxWidth,
                height: timerBoxHeight,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        WidgetCustomTextBox(
                            width: timerSlideWidth,
                            height: timerTxtHeight,
                            verAlign: 2,
                            fontAlign: 1,
                            msg: "세트간 시간 타이머",
                            fontSize: timerTxtSize),
                        SizedBox(
                          width: timerSlideWidth,
                          height: timerSliderHeight,
                          child: Slider(
                              min: 0,
                              max: timerMax,
                              value: timerState,
                              onChanged: (newValue) {
                                return;
                              }),
                        ),
                        WidgetCustomTextBox(
                            width: timerSlideWidth,
                            height: timerValueHeight,
                            verAlign: 0,
                            fontAlign: 1,
                            msg: timerState.toString(),
                            fontSize: timerIntSize)
                      ],
                    ),
                    /* ************************** 타이머 시간 조절 ************************** */
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          // color: Colors.red[100],
                          width: timerBtnPartWidth,
                          height: timerBtnHeight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                      fixedSize: Size(
                                          timerValueBtnWidth, timerBtnHeight),
                                      textStyle:
                                          TextStyle(fontSize: timerBtnSize)),
                                  onPressed: () {
                                    if (timerState < 30) {
                                      return;
                                    }
                                    ref
                                        .read(doublForTimerProviderMax.notifier)
                                        .state -= 30;
                                    ref
                                        .read(doublForTimerProvider.notifier)
                                        .state -= 30;
                                  },
                                  child: const Text("- 30")),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      fixedSize: Size(
                                          timerValueBtnWidth, timerBtnHeight),
                                      textStyle:
                                          TextStyle(fontSize: timerBtnSize)),
                                  onPressed: () {
                                    ref
                                        .read(doublForTimerProviderMax.notifier)
                                        .state += 30;
                                    ref
                                        .read(doublForTimerProvider.notifier)
                                        .state += 30;
                                  },
                                  child: const Text("+ 30")),
                            ],
                          ),
                        ),
                        SizedBox(
                          // color: Colors.blue[100],
                          width: timerBtnPartWidth,
                          height: timerBtnHeight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                      fixedSize: Size(
                                          timerValueBtnWidth, timerBtnHeight),
                                      textStyle:
                                          TextStyle(fontSize: timerBtnSize)),
                                  onPressed: () {
                                    if (timerState < 10) {
                                      return;
                                    }
                                    ref
                                        .read(doublForTimerProviderMax.notifier)
                                        .state -= 10;
                                    ref
                                        .read(doublForTimerProvider.notifier)
                                        .state -= 10;
                                  },
                                  child: const Text("- 10")),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      fixedSize: Size(
                                          timerValueBtnWidth, timerBtnHeight),
                                      textStyle:
                                          TextStyle(fontSize: timerBtnSize)),
                                  onPressed: () {
                                    ref
                                        .read(doublForTimerProviderMax.notifier)
                                        .state += 10;
                                    ref
                                        .read(doublForTimerProvider.notifier)
                                        .state += 10;
                                  },
                                  child: const Text("+ 10")),
                            ],
                          ),
                        ),
                        SizedBox(
                          // color: Colors.green[100],
                          width: timerBtnPartWidth,
                          height: timerBtnHeight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                      fixedSize: Size(
                                          timerValueBtnWidth, timerBtnHeight),
                                      textStyle:
                                          TextStyle(fontSize: timerBtnSize)),
                                  onPressed: () {
                                    if (timerState < 1) {
                                      return;
                                    }
                                    ref
                                        .read(doublForTimerProviderMax.notifier)
                                        .state -= 1;
                                    ref
                                        .read(doublForTimerProvider.notifier)
                                        .state -= 1;
                                  },
                                  child: const Text("- 1")),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      fixedSize: Size(
                                          timerValueBtnWidth, timerBtnHeight),
                                      textStyle:
                                          TextStyle(fontSize: timerBtnSize)),
                                  onPressed: () {
                                    ref
                                        .read(doublForTimerProviderMax.notifier)
                                        .state += 1;
                                    ref
                                        .read(doublForTimerProvider.notifier)
                                        .state += 1;
                                  },
                                  child: const Text("+ 1")),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              /* 셋팅된 운동들  */
              SizedBox(
                  // color: Colors.amber[200],
                  width: maxWidth,
                  height: setListBoxHeight,
                  child: ListView.builder(
                      itemCount: planState.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: TrainStartCard(
                            model: planState[index],
                            metric1: sportInfo.metric1,
                            metric2: sportInfo.metric2,
                            fontsize: cardSize,
                            height: cardHeight,
                            timerAct: () => startTimer(ref),
                          ),
                        );
                      })),
              WidgetCustomEleBtn(
                  fontSize: fontSize(context, 5),
                  width: maxWidth * 0.9,
                  height: btnHeight,
                  msg: "운 동 완 료",
                  color: Colors.blue,
                  onPressed: () async {
                    // timerReset(ref, 0);
                    ref.read(doublForTimerProvider.notifier).state = 0.1;
                    await Future.delayed(const Duration(milliseconds: 300));
                    ref.read(doublForTimerProvider.notifier).state = 30;
                    ref.read(doublForTimerProviderMax.notifier).state = 30;
                    ref.read(trainPlanDailyNotifierProvider.notifier).refreshState();
                    context.pop();
                  }),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        );
      }),
    );
  }

  void startTimer(WidgetRef ref) {
    // 타이머가 이미 실행 중인 경우 중복 실행 방지
    if (ref.read(doublForTimerProvider) <
        ref.read(doublForTimerProviderMax.notifier).state) {
      return;
    }
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      ref.read(doublForTimerProvider.notifier).state =
          roundMethod(ref.read(doublForTimerProvider.notifier).state - 0.1);

      if (ref.read(doublForTimerProvider) <= 0) {
        timer.cancel();
        timerReset(ref, 0);
      }
    });
  }

  void timerReset(WidgetRef ref, int delayTime) async {
    await Future.delayed(Duration(milliseconds: delayTime));
    ref.read(doublForTimerProvider.notifier).state =
        ref.read(doublForTimerProviderMax.notifier).state;
  }
}
