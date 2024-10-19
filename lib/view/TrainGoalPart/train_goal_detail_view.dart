// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/base_alert.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/widget/layOut/base_layout.dart';
import 'package:myhealthdiary_app/common/widget/widget_banner_for_ad.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_icon_btn.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_text_box.dart';
import 'package:myhealthdiary_app/common/widget/widget_double_btn.dart';
import 'package:myhealthdiary_app/provider/train_goal_list_notifier.dart';

import '../../provider/collection_of_basic_state_provider.dart';
import '../../provider/sharedStateNotifier/sport_info_notifier.dart';
import '../../provider/train_goal_notifier.dart';

class TrainGoalDetailView extends ConsumerWidget {
  static String routeForTrainGoalDetailView = "routeForTrainGoalDetailView";
  const TrainGoalDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
//이전 페이지에서 설정해놓았을 스포츠 아이디값.
    final sportID = ref.read(showSportIdProvider);
    final goalID = ref.watch(showTraingGoalIDProvider);
// 1. 보여주고 싶은 스포츠 정보 provider
    final info = ref.watch(sportInfoProvider(sportID)); //
    final goal = ref.watch(trainGoalProvider(goalID));

    return BaseLayout(body: LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth - 20;
        double maxHeight = constraints.maxHeight;
        //3파트 높이 계산
        double titleHeight = maxHeight * 0.2;
        double valueHeight = maxHeight * 0.2;
        double successBoxHeight = maxHeight * 0.25;
        //banner 파트는 0.15 정도 생각함
        double btnHeight = maxHeight * 0.08;

        //각 세부 파트 높이 계산
        double nameHeight = maxHeight * 0.1;
        double dateHeight = maxHeight * 0.08;
        double dividerHeight = maxHeight * 0.01; // Divider 를 위함

        double valueInsertHeight = maxHeight * 0.08;
        double successBtnSized =
            min(maxWidth * 0.4, maxHeight * 0.2); //Icon 버튼 가로세로
        double successIconSize = successBtnSized * 0.5;

        //넓이값계산
        double dateLeftWidth = maxWidth * 0.25;
        double dateRightWidth = maxWidth * 0.3;
        double goalWidth = maxWidth * 0.25;
        double metricWidth = maxWidth * 0.16;

        //글자 크기
        double nameSize = fontSize(context, 12);
        double dateSize = fontSize(context, 5);
        double successTexSize = fontSize(context, 2.5);
        double valueSize = fontSize(context, 11);
        double metricSize = fontSize(context, 3);

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
//TitleBox : 스포츠 이름  목표일 들어가는  파트
              SizedBox(
                width: maxWidth,
                height: titleHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    WidgetCustomTextBox(
                      height: nameHeight,
                      msg: info.sportName,
                      fontSize: nameSize,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        WidgetCustomTextBox(
                          width: dateLeftWidth,
                          height: dateHeight,
                          msg: "목표일 : ",
                          fontSize: dateSize,
                        ),
                        WidgetCustomTextBox(
                          width: dateRightWidth,
                          height: dateHeight,
                          msg: goal.tgDueDate,
                          fontSize: dateSize,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: dividerHeight,
                width: maxWidth,
                child: const Divider(
                  color: Colors.grey,
                ),
              ),
//Title 박스 끝
// 목표값 보여주는 박스
              SizedBox(
                width: maxWidth,
                height: valueHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        // 첫번째 값 넣는 부분
                        SizedBox(
                          width: maxWidth / 2,
                          height: valueInsertHeight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              WidgetCustomTextBox(
                                verAlign: 2,
                                fontAlign: 2,
                                width: goalWidth,
                                msg: goal.tgGoal1.toString(),
                                fontSize: valueSize,
                              ),
                              WidgetCustomTextBox(
                                fontAlign: 0,
                                verAlign: 2,
                                width: metricWidth,
                                msg: info.metric1,
                                fontSize: metricSize,
                              )
                            ],
                          ),
                        ),
                        //두번쨰 값 넣는 부분
                        SizedBox(
                          width: maxWidth / 2,
                          height: valueInsertHeight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              WidgetCustomTextBox(
                                verAlign: 2,
                                fontAlign: 2,
                                width: goalWidth,
                                msg: goal.tgGoal2.toString(),
                                fontSize: valueSize,
                              ),
                              WidgetCustomTextBox(
                                fontAlign: 0,
                                verAlign: 2,
                                width: metricWidth,
                                msg: info.metric2,
                                fontSize: metricSize,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: dividerHeight,
                width: maxWidth,
                child: const Divider(
                  color: Colors.grey,
                ),
              ),
//ValuePart 부분 끝
//성공여부 입력하는 파트 // goal의 상태에 따라서 들어가는 요소가 다르다.
//success = 1 or 2
// success = 0
              SizedBox(
                width: maxWidth,
                height: successBoxHeight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
// 우선 성공여부가 정해진 목표                    
                    goal.tgSuccess!=0
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: successBtnSized,
                          height: successBtnSized,
                          child: goal.tgSuccess==1
                          ?Icon(
                            Icons.thumb_up,
                            size: successIconSize,
                            color: Colors.blue,
                          )
                          :Icon(
                            Icons.thumb_down,
                            size: successIconSize,
                            color: Colors.red,
                          ),

                        ),
                        WidgetCustomTextBox(
                          verAlign: 1,
                          fontAlign: 1,
                          width: successBtnSized,
                          height: successBtnSized,
                          fontSize: dateSize,
                          msg: "성공 여부 기록일 \n ${goal.tgSuccessDate}",
                          fontColor: goal.tgSuccess==1
                          ? Colors.blue
                          : Colors.red
                        ),
                      ],
                    )
// 아직 성공 / 실패 여부가 정해지지 않았을때 버튼 보여주기!!                    
                    : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        WidgetCustomIconBtn(
                          width: successBtnSized,
                          height: successBtnSized,
                          icon: Icon(
                            Icons.thumb_down,
                            size: successIconSize,
                            color: Colors.red,
                          ),
                          msg: "Fail",
                          fsize: successTexSize,
                          fontColor: Colors.red,
                          onPressed: () async{
                            //목표 달성 실패 입력.
                            //1. 정말 실패인지 묻기
                            bool confirm =await baseAlertForConfirm(context, "정말로 실패 하셨나요?");
                            if(!confirm){return;}
                            //실패 기록하기.
                            bool rs = await ref.read(trainGoalProvider(goalID).notifier).updateFail();
                            ref.read(trainGoalProvider(goalID).notifier).initiateState();
                            if(rs){
                              await baseAlertForConfirm(context, "기록 되었습니다.");
                            }
                            if(!rs){
                              await baseAlertForConfirm(context, "기록이 되지 않았습니다.");
                            }
                            //돌아갈화면 최신화
                            ref.read(trainingGoalListPageProvider.notifier).initiateState();                            
                            context.pop();
                          },
                        ),
                        WidgetCustomIconBtn(
                          width: successBtnSized,
                          height: successBtnSized,
                          icon: Icon(
                            Icons.thumb_up,
                            size: successIconSize,
                            color: Colors.blue,
                          ),
                          msg: "Success",
                          fsize: successTexSize,
                          fontColor: Colors.blue,
                          onPressed: () async{
                            //목표 달성 실패 입력.
                            //1. 정말 성공인지 묻기
                            bool confirm =await baseAlertForConfirm(context, "정말로 달성 하셨나요?");
                            if(!confirm){return;}
                            //실패 기록하기.
                            bool rs = await ref.read(trainGoalProvider(goalID).notifier).updateSuccess();
                            ref.read(trainGoalProvider(goalID).notifier).initiateState();
                            if(rs){
                              await baseAlertForConfirm(context, "기록 되었습니다.");
                            }
                            if(!rs){
                              await baseAlertForConfirm(context, "기록이 되지 않았습니다.");
                            }
                            //돌아갈화면 최신화
                            ref.read(trainingGoalListPageProvider.notifier).initiateState();
                            context.pop();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
// btn 파트 입력 끝.               
              SizedBox(
                height: dividerHeight,
                width: maxWidth,
                child: const Divider(
                  color: Colors.grey,
                ),
              ),
              const BannerForAd(),
              WidgetDoubleBtn(
                leftFunc: () {
                  context.go("/");

                },
                rightFunc: () {
                  context.pop();

                },
                width: maxWidth,
                height: btnHeight,
                leftMsg: "🏠 Home",
                rightMsg: "☑︎ Confirm",
              )
            ], // 전체 ColumnChildern
          ),
        );
      },
    ));
  }
}
