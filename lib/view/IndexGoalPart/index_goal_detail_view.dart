import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/widget/widget_double_btn.dart';
import 'package:myhealthdiary_app/view/IndexGoalPart/card_for_index_detail_btn.dart';

import '../../common/basic_method.dart';
import '../../common/widget/base_layout.dart';
import '../../common/widget/widget_custom_text_box.dart';
import '../../common/widget/widget_empty_card.dart';
import '../../provider/collection_of_basic_state_provider.dart';
import '../../provider/index_goal_notifier.dart';

class IndexGoalDetailView extends ConsumerWidget {
  static String routeNameForIndexGoalDetail = "RouteNameForIndexGoalDetail";
  const IndexGoalDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 이 페이지에서 상태는 IndexGoalNotifier 클래스에서 관리한다.
    //호출할 Provider 이름은 IndexGoalModelProvider
    final modelId = ref.watch(showingHealthIndexGoalIDProvider);
    final modelState = ref.watch(indexGoalModelProvider(modelId));

    return BaseLayout(
        barTitle:
            "goalID  ${ref.read(showingHealthIndexGoalIDProvider.notifier).state.toString()}",
        appbarOption: false,
        body: LayoutBuilder(builder: (context, constraints) {
          double maxWidth = constraints.maxWidth - 20;
          double maxHeight = constraints.maxHeight;

          //구성요소 높이 설정
          ///목표 달성일 입력 박스
          double duedateBoxHeight = maxHeight * 0.06;

          ///사진이랑 기타 요소 들어가는 박스
          double mainBoxHeight = boxheightSize(maxHeight * 0.47);

          ///버튼 들어가는 박스
          double btnBoxHeight = boxheightSize(maxHeight * 0.2); //80
          ///배너들어갈 부분
          double bannerBoxHeight = boxheightSize(maxHeight * 0.1); //90
          ///최하단 버튼 들어갈 부분
          double doubleBtnBox = boxheightSize(maxHeight * 0.1); //95

          return modelState == null
              ? WidgetEmptyCard(width: maxWidth, height: maxHeight, fontSize: fontSize(context, 12),)
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: maxWidth,
                        height: duedateBoxHeight,
                        child: WidgetCustomTextBox(
                          verAlign: 1,
                          fontAlign: 0,
                          msg: " 목표 일자 : ${modelState.hgDuedate}",
                          fontSize: fontSize(context, 5),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        width: maxWidth,
                        height: mainBoxHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: (maxWidth / 2) - 1,
                              color: Colors.black,
                              child: WidgetCustomTextBox(
                                fontColor: Colors.white,
                                msg: "No\nImage",
                                fontSize: fontSize(context, 14),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    WidgetCustomTextBox(
                                        width: maxWidth * 0.17,
                                        height: mainBoxHeight * 0.15,
                                        fontAlign: 0,
                                        msg: "신 장 : ",
                                        fontSize: fontSize(context, 4)),
                                    WidgetCustomTextBox(
                                        width: maxWidth * 0.2,
                                        height: mainBoxHeight * 0.15,
                                        fontAlign: 1,
                                        msg: modelState.hgHeight.toString(),
                                        fontSize: fontSize(context, 4)),
                                    WidgetCustomTextBox(
                                        width: maxWidth * 0.1,
                                        height: mainBoxHeight * 0.15,
                                        fontAlign: 0,
                                        msg: "cm",
                                        fontSize: fontSize(context, 4)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    WidgetCustomTextBox(
                                        width: maxWidth * 0.17,
                                        height: mainBoxHeight * 0.15,
                                        fontAlign: 0,
                                        msg: "체 중 : ",
                                        fontSize: fontSize(context, 4)),
                                    WidgetCustomTextBox(
                                        width: maxWidth * 0.2,
                                        height: mainBoxHeight * 0.15,
                                        fontAlign: 1,
                                        msg: modelState.hgWeight.toString(),
                                        fontSize: fontSize(context, 4)),
                                    WidgetCustomTextBox(
                                        width: maxWidth * 0.1,
                                        height: mainBoxHeight * 0.15,
                                        fontAlign: 0,
                                        msg: "kg",
                                        fontSize: fontSize(context, 4)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    WidgetCustomTextBox(
                                        width: maxWidth * 0.17,
                                        height: mainBoxHeight * 0.15,
                                        fontAlign: 0,
                                        msg: "BMI : ",
                                        fontSize: fontSize(context, 4)),
                                    WidgetCustomTextBox(
                                        width: maxWidth * 0.2,
                                        height: mainBoxHeight * 0.15,
                                        fontAlign: 1,
                                        msg: calcBMI(modelState.hgHeight,
                                                modelState.hgWeight)
                                            .toString(),
                                        fontSize: fontSize(context, 4)),
                                    WidgetCustomTextBox(
                                        width: maxWidth * 0.1,
                                        height: mainBoxHeight * 0.15,
                                        fontAlign: 0,
                                        msg: "",
                                        fontSize: fontSize(context, 4)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    WidgetCustomTextBox(
                                        width: maxWidth * 0.17,
                                        height: mainBoxHeight * 0.15,
                                        fontAlign: 0,
                                        msg: "체지방율 : ",
                                        fontSize: fontSize(context, 4)),
                                    WidgetCustomTextBox(
                                        width: maxWidth * 0.2,
                                        height: mainBoxHeight * 0.15,
                                        fontAlign: 1,
                                        msg: modelState.hgFat.toString(),
                                        fontSize: fontSize(context, 4)),
                                    WidgetCustomTextBox(
                                        width: maxWidth * 0.1,
                                        height: mainBoxHeight * 0.15,
                                        fontAlign: 0,
                                        msg: "%",
                                        fontSize: fontSize(context, 4)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    WidgetCustomTextBox(
                                        width: maxWidth * 0.17,
                                        height: mainBoxHeight * 0.15,
                                        fontAlign: 0,
                                        msg: "골격근량 : ",
                                        fontSize: fontSize(context, 4)),
                                    WidgetCustomTextBox(
                                        width: maxWidth * 0.2,
                                        height: mainBoxHeight * 0.15,
                                        fontAlign: 1,
                                        msg: modelState.hgMuscle.toString(),
                                        fontSize: fontSize(context, 4)),
                                    WidgetCustomTextBox(
                                        width: maxWidth * 0.1,
                                        height: mainBoxHeight * 0.15,
                                        fontAlign: 0,
                                        msg: "kg",
                                        fontSize: fontSize(context, 4)),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: maxWidth,
                        height: btnBoxHeight,
                        child: CardForIndexDetailBtn(
                          goal: modelState,
                          width: maxWidth * 0.85,
                          height: btnBoxHeight,
                          fsize: fontSize(context, 2),
                        ),
                      ),
                      SizedBox(
                        height: bannerBoxHeight,
                      ),
                      WidgetDoubleBtn(
                        leftFunc: (){
                          context.go("/");
                          
                        },
                        rightFunc: (){
                          context.pop();
                        },
                        leftMsg: "🏠 홈으로",
                        width: maxWidth,
                        height: doubleBtnBox*0.7,
                      )
                    ],
                  ),
                );
        }));
  }
}
