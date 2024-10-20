import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/basic_method.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/widget/layOut/base_layout.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_elebtn.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_text_box.dart';
import 'package:myhealthdiary_app/provider/providerForShared/collection_of_basic_state_provider.dart';
import 'package:myhealthdiary_app/provider/providerForTrainPart/train_as_plan_notifier.dart';
import 'package:myhealthdiary_app/view/TrainPlanPart/plan_day_todo_list_view.dart';
import 'package:myhealthdiary_app/view/TrainRecPart/train_show_plan_card.dart';

class TrainShowPlanView extends ConsumerWidget {
  static String routeForShowPlanForTrain = "routeForShowPlanForTrain";
  const TrainShowPlanView({super.key});

  /// 오늘 운동 예정인 계획들을 보여준다.
  /// 자정 전후로 운동할 수 있기에, 어제와 내일 운동 계획까지 보여준다.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseLayout(
        appbarOption: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            double maxWidth = constraints.maxWidth - 20;
            double maxHeight = constraints.maxHeight;
            //각 파트 높이 계산
            double titleHeight = maxHeight * 0.06;
            double semititleHeight = maxHeight * 0.05;
            double divHeight = maxHeight * 0.03;
            double boxHeight = maxHeight * 0.7;
            double cardHeight = maxHeight * 0.08;
            double btnHeight = maxHeight * 0.08;
            // 카드안 가로 넓이 계산
            double sidePad = maxWidth * 0.1;
            double leftWidth = maxWidth * 0.3;
            double centerWidth = maxWidth * 0.2;
            double rightWidth = maxWidth * 0.25;

            //글자크기 계산
            double largeTitleSize = fontSize(context, 10);
            double semiTitleSize = fontSize(context, 3);
            // double cardFontSize = fontSize(context, 3);

            // 어제 오늘 내일 3일치 기록을 가져와관리하는 List
            final originState = ref.watch(trainAsPlanNotifierProvider);
            List<Map<String, dynamic>> state = originState.when(
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

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  WidgetCustomTextBox(
                    verAlign: 2,
                    width: maxWidth,
                    height: titleHeight,
                    msg: "계획 목록 ",
                    fontSize: largeTitleSize,
                  ),
                  WidgetCustomTextBox(
                    verAlign: 0,
                    width: maxWidth,
                    height: semititleHeight,
                    msg: "(어제 / 오늘 / 내일 일정 중)",
                    fontSize: semiTitleSize,
                  ),
                  SizedBox(
                    width: maxWidth * 0.95,
                    height: divHeight,
                    child: const Divider(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    // color: Colors.amber[100],
                    width: maxWidth,
                    height: boxHeight,
                    child: ListView.builder(
                      itemCount: state.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> plan = state[index];
//db에서 가져온 바로 그대로이기때문에, 변수명이 db와 같게 되어있다.
//괜히 모델병 변수 잘못 입력한줄 알고 놀라지 말것.
                        String title = plan['tp_title'];
                        String date = plan['tp_traindate'];
                        //어제 - 오늘 - 내일 날짜별로 색 다르게 지정.
                        Color bgclr = Colors.red[100]!;
                        if (date ==
                            onlyDay(DateTime.now()
                                .subtract(const Duration(days: 1)))) {
                          bgclr = Colors.blue[100]!;
                        }
                        if (date == onlyDay(DateTime.now())) {
                          bgclr = Colors.grey[200]!;
                        }
                        return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                            child: GestureDetector(
                              onTap: () {
                                ref.watch(selectedDayProvider.notifier).state =
                                    DateTime.parse(date);
                                ref.watch(titleProvider.notifier).state = title;
                                context.goNamed(
                                    PlanDayTodoListView.routeForReadyAsPlan);
                              },
                              child: TrainShowPlanCard(
                                bgclr: bgclr,
                                title: title,
                                date: date,
                                centerWidth: centerWidth,
                                leftWidth: leftWidth,
                                maxHeight: cardHeight,
                                maxWidth: maxWidth,
                                rightWidth: rightWidth,
                                sidePad: sidePad,
                              ),
                            ));
                      },
                    ),
                  ),
                  SizedBox(
                    width: maxWidth * 0.95,
                    height: divHeight,
                    child: const Divider(
                      color: Colors.black,
                    ),
                  ),
                  WidgetCustomEleBtn(
                      width: maxWidth * 0.95,
                      height: btnHeight,
                      fontSize: fontSize(context, 6),
                      msg: "🏠 홈으로",
                      color: Colors.red,
                      onPressed: () {
                        context.go("/");
                      }),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            );
          },
        ));
  }
}
