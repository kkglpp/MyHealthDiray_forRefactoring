// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/base_alert.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/component/layOut/base_layout.dart';
import 'package:myhealthdiary_app/common/component/widget_banner_for_ad.dart';
import 'package:myhealthdiary_app/common/component/widget_custom_elebtn.dart';
import 'package:myhealthdiary_app/common/component/widget_custom_text_box.dart';
import 'package:myhealthdiary_app/common/component/widget_custom_txt_btn.dart';
import 'package:myhealthdiary_app/common/component/widget_double_btn.dart';
import 'package:myhealthdiary_app/managerClass/double_value_alert_manager.dart';
import 'package:myhealthdiary_app/provider/providerForShared/collection_of_basic_state_provider.dart';
import 'package:myhealthdiary_app/provider/providerForSportList/sport_info_notifier.dart';
import 'package:myhealthdiary_app/provider/providerForTrainPart/train_goal_list_notifier.dart';
import 'package:myhealthdiary_app/provider/providerForTrainPart/train_goal_notifier.dart';

import '../../managerClass/pick_date_method.dart';

class TrainGoalInsertView extends ConsumerWidget {
  static String routeForTrainGoalInertView = "routeForTrainGoalInertView";
  const TrainGoalInsertView({
    super.key,
  });
  // LayOutBiolder 를 전체레이아웃 다음에 넣는게 좀 더 비율 생각하기 편한듯하다.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseLayout(
        barTitle: "수행 능력 목표 리스트",
        body: LayoutBuilder(builder: (context, constraints) {
          double maxWidth = constraints.maxWidth - 40;
          double maxHeight = constraints.maxHeight;

          //큰 분류
          double titlePartHeight = maxHeight * 0.25;
          double valueBoxHeight = maxHeight * 0.5;
          // double lastPartHeight = maxHeight * 0.2;

          // 스포츠 이름 파트
          double sportHeight = maxHeight * 0.12;
          //날짜 입력받는 파트
          double dueDateHeight = maxHeight * 0.1;
          double dividerHeight = maxHeight * 0.02; //Divider선. 2개 들어갈 예정

          double txtHeight = maxHeight * 0.1; // 목표 기록 입력 파트 입력할 높이
          double recHeight = maxHeight * 0.1; //각 목표 값을 입력받을 높이. 2개 예정 //0.52
          // double bannerHeight는 0,1~0.15 생각
          double btnHeight = maxHeight * 0.1;

          //넓이값 계산
          //첫번째행 스포츠 부분
          double sportLeftBox = maxWidth * 0.4;
          double sportRightBox = maxWidth * 0.5;
          //2번쨰 행 날짜 부분
          double dateLeftBox = maxWidth * 0.3;
          double dateRightBox = maxWidth * 0.4;
          //중간 타이틀 부분은 그냥 전체 둘러싸도 상관 없다.
          //목표값 입력 받는 파트
          double recWidth = maxWidth * 0.35;
          double metricWidth = maxWidth * 0.22;
          double valueBtnWidth = maxWidth * 0.35;
          //글자크기
          double sportSize = fontSize(context, 9);
          double dateSize = fontSize(context, 5);
          double txtSize = fontSize(context, 8);
          double recSize = fontSize(context, 13);
          double btnSize = fontSize(context, 3);
          double metricSize = fontSize(context, 4);
//이전 페이지에서 설정해놓았을 스포츠 아이디값.
          final sportID = ref.read(showSportIdProvider);
// 1. 보여주고 싶은 스포츠 정보 provider
          final info = ref.watch(sportInfoProvider(sportID)); //
// 2. 아직 저장되지 않은, trainGoalmodel을 관리할 상태.
// 3. detail 로 넘어 왔을때는 다른 거다.
          final state = ref.watch(addTrainGoalProvier);
          return Center(
            child: SizedBox(
              width: maxWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // 내가 고른 운동 이름을 보는 부분이다.
                  SizedBox(
                    width: maxWidth,
                    height: titlePartHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: sportLeftBox,
                              height: sportHeight,
                              child: WidgetCustomTextBox(
                                fontAlign: 0,
                                msg: "목표 운동 : ",
                                fontSize: sportSize,
                              ),
                            ),
                            SizedBox(
                              width: sportRightBox,
                              height: sportHeight,
                              child: WidgetCustomTextBox(
                                bold: true,
                                fontAlign: 0,
                                msg: info.sportName,
                                fontSize: sportSize,
                              ),
                            ),
                          ],
                        ),
                        //날짜를 입력 받는 파트.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: dateLeftBox,
                              height: dueDateHeight,
                              child: WidgetCustomTextBox(
                                  msg: "목 표 날 짜 : ", fontSize: dateSize),
                            ),
                            SizedBox(
                              width: dateRightBox,
                              height: dueDateHeight,
                              child: WidgetCustomTxtBtn(
                                txt: state.tgDueDate,
                                width: dateRightBox,
                                height: dueDateHeight,
                                fsize: dateSize,
                                clr: Colors.purple,
                                onTap: () async {

                                  //목표 날짜를 입력 받는 함수.
                                  //pickDate 를 이용해서 다이얼로그로 입력 받는다.
                                  DateTime newDate = await pickDateUsingDialog(
                                      context, state.tgDueDate);
                                  //받은 값을 현재 관리하고 있는 model에 넣는다. 근데 한번 저장한 이후 수정은 허용하지 않을꺼야.
                                  //한번 저장했으면 삭제하고 다시 세우던가, 아니면 이악물고 이루던가..
                                  ref
                                      .read(addTrainGoalProvier.notifier)
                                      .changeDueDate(newDate);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: dividerHeight,
                          width: maxWidth,
                          child: const Divider(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
//각 목표값을 입력하는 부분
                  SizedBox(
                    width: maxWidth,
                    height: valueBoxHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Container(
                        //   color: Colors.amber,
                        SizedBox(
                          width: maxWidth,
                          height: txtHeight,
                          child: WidgetCustomTextBox(
                            fontAlign: 0,
                            msg: "목표 기록 입력",
                            fontSize: txtSize,
                          ),
                        ),
                        // const Spacer(),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // SizedBox(
                            WidgetCustomTextBox(
                              width: recWidth,
                              height: recHeight,
                              verAlign: 2,
                              fontAlign: 2,
                              // msg: "6789.1",
                              msg: state.tgGoal1.toString(),
                              fontSize: recSize,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            // Container(
                            //   color: Colors.grey,
                            WidgetCustomTextBox(
                              width: metricWidth,
                              height: recHeight,
                              fontAlign: 0,
                              verAlign: 2,
                              // msg: "일이삼사오",
                              msg: info.metric1,
                              fontSize: metricSize,
                            ),
                            const Spacer(),
                            SizedBox(
                              width: valueBtnWidth,
                              height: recHeight * 0.8,
                              child: WidgetCustomEleBtn(
                                  msg: "✓ 입 력",
                                  color: Colors.purple,
                                  onPressed: () async {
                                    //goal1 을 입력하는 동작.
                                    //alert창을 통해 값을 받아온다.
                                    double? result =
                                        await doubleValueAlertManager(
                                      ref,
                                      info.sportName,
                                      info.metric1,
                                      0, //값 초기값/
                                      0, //최소값은 0.
                                      650, // 최대값은 650. 왜냐? 스쿼트 기준 최대 기록이 650은 아직 안넘음. 정 그 이상을 원하면, 새로운 종목해서 단위를 바꾸는 방식을 권하자.
                                    );
                                    //받은 값으로 상태 업데이트하고.
                                    ref
                                        .read(addTrainGoalProvier.notifier)
                                        .changeGoal1(result!);
                                  },
                                  width: metricWidth,
                                  height: recHeight,
                                  fontSize: btnSize),
                            ),
                          ],
                        ),
                        const Spacer(),
                        //goal2를 입력하는 파트
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // SizedBox(
                            WidgetCustomTextBox(
                              width: recWidth,
                              height: recHeight,
                              verAlign: 2,
                              fontAlign: 2,
                              msg: state.tgGoal2.toString(),
                              fontSize: recSize,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            WidgetCustomTextBox(
                              width: metricWidth,
                              height: recHeight,
                              fontAlign: 0,
                              verAlign: 2,
                              msg: info.metric2,
                              fontSize: metricSize,
                            ),
                            const Spacer(),
                            SizedBox(
                              width: valueBtnWidth,
                              height: recHeight * 0.8,
                              child: WidgetCustomEleBtn(
                                  msg: "✓ 입 력",
                                  color: Colors.purple,
                                  onPressed: () async {
                                    //alert창을 통해 값을 받아온다.
                                    double? result =
                                        await doubleValueAlertManager(
                                      ref,
                                      info.sportName,
                                      info.metric2,
                                      0, //값 초기값/
                                      0, //최소값은 0.
                                      650, // 최대값은 650. 왜냐? 스쿼트 기준 최대 기록이 650은 아직 안넘음. 정 그 이상을 원하면, 새로운 종목해서 단위를 바꾸는 방식을 권하자.
                                    );
                                    //받은 값으로 상태 업데이트하고.
                                    ref
                                        .read(addTrainGoalProvier.notifier)
                                        .changeGoal2(result!);
                                  },
                                  width: metricWidth,
                                  height: recHeight,
                                  fontSize: btnSize),
                            ),
                          ],
                        ),
                        const Spacer(),
                        SizedBox(
                          height: dividerHeight,
                          width: maxWidth,
                          child: const Divider(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const BannerForAd(),
                  const Spacer(),
                  WidgetDoubleBtn(
                    leftFunc: () {
                      //취소 . 돌아가기 . 상태들 초기화하고 -> list 페이지로 돌아가야한다. sportList 아니고 goalList.
                      ref.read(addTrainGoalProvier.notifier).initiateState();
                      //화면에서 나간다. 라우팅을 해놨기 떄문에 sportList로 가지 않음.
                      context.pop();
                    },
                    rightFunc: () async {
                      //저장하는 함수
                      //우선 정말 저장할 건지 확인하고
                      bool confirm =
                          await baseAlertForConfirm(context, "목표를 저장하시겠습니까?");
                      //저장 안하면 아무것도 안하고 그대로 두기
                      if (!confirm) {
                        return;
                      }
                      //저장 하고
                      bool rs = await ref
                          .read(addTrainGoalProvier.notifier)
                          .saveGoal();
                      //결과보고 오류떠서 false나면 메시지띄우기.
                      if (!rs) {
                        await baseAlertForConfirm(context, "저장 되지 않았습니다.");
                        return;
                      }
                      //성공하면 저장성공 띄우기
                      await baseAlertForConfirm(context, "저장 되었습니다.");
                      //돌아갈 화면 초기화
                      ref
                          .read(trainingGoalListPageProvider .notifier)
                          .initiateState();
                      //화면 이동
                      context.pop();
                    },
                    width: maxWidth,
                    height: btnHeight,
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
        }));
  }
}
