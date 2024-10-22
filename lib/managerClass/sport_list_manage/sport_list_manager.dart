// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/base_alert.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/component/widget_custom_text_box.dart';
import 'package:myhealthdiary_app/common/component/widget_custom_text_field.dart';
import 'package:myhealthdiary_app/common/component/widget_double_btn.dart';
import 'package:myhealthdiary_app/provider/providerForSportList/sport_folder_list_state_notifier.dart';
import 'package:myhealthdiary_app/provider/providerForSportList/sport_list_infolder_notifier.dart';
import 'package:myhealthdiary_app/provider/providerForSportList/sport_llist_state_notifier.dart';
import 'package:myhealthdiary_app/provider/providerForSportList/sport_state_notifier.dart';

import '../../model/sport_folder_model.dart';

class SportListManager {
  final WidgetRef ref;
  final BuildContext context;

  SportListManager({required this.ref, required this.context});

  //  삭제를 확인하는 Alert
  // deleteAlert(int sport_id) async {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: CustomTextBox(msg: "정말로 삭제하시겠습니까?", fontSize: 30.sp),
  //         actions: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: [
  //               CustomElevatedBtn(
  //                 msg: "취 소",
  //                 color: Colors.red,
  //                 onPressed: () {
  //                   context.pop();
  //                 },
  //               ),
  //               CustomElevatedBtn(
  //                   msg: "삭 제",
  //                   color: Colors.blue,
  //                   onPressed: () async {
  //                     await _deleteFunction(sport_id);
  //                     context.pop(); //화면으로 돌아가고
  //                   }),
  //             ],
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  //스포츠를 추가하는 Alert
  addSportAlert() async {
    double width = MediaQuery.of(context).size.width * 0.8;
    double height = MediaQuery.of(context).size.height * 0.7;

    //각 항목들 높이
    final double titleHeight = height * 0.1;
    final double exHeight = height * 0.2;
    final double contentHeight = height * 0.7;
    // final double indexHeight = height * 0.1;
    final double btnHeight = height * 0.1;

    // 구성요소 크기
    final double indexWidth = width * 0.25;
    final double valueWidth = width * 0.4;
    final double tfHeight = height * 0.08;
    final double exEachHeight = height * 0.05;
    final double exEachWidth = width * 0.15;

    final double indexfsize = fontSize(context, 3);
    final double exfsize = fontSize(context, 1);

    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: WidgetCustomTextBox(
            verAlign: 2,
            width: width,
            height: titleHeight,
            msg: "종목 추가하기",
            fontSize: fontSize(context, 8),
          ),
          content: SizedBox(
            height: contentHeight,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    // color: Colors.amber[100],
                    width: width,
                    height: height * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            WidgetCustomTextBox(
                              width: indexWidth,
                              height: tfHeight,
                              msg: "종목 명 : ",
                              fontSize: indexfsize,
                              fontAlign: 0,
                            ),
                            WidgetCustomTextField(
                              maxLength: 15,
                              width: valueWidth,
                              height: tfHeight,
                              onchanged: (sportName) {
                                ref
                                    .read(stateForNewSportProvider.notifier)
                                    .changeName(sportName);
                              },
                              hintText: "종목 이름. 최대 15글자.",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            WidgetCustomTextBox(
                              width: indexWidth,
                              height: tfHeight,
                              msg: "단위 1  : ",
                              fontSize: indexfsize,
                              fontAlign: 0,
                            ),
                            WidgetCustomTextField(
                              maxLength: 6,
                              width: valueWidth,
                              height: tfHeight,
                              onchanged: (newMetric) {
                                ref
                                    .read(stateForNewSportProvider.notifier)
                                    .changeMetric1(newMetric);
                              },
                              hintText: "첫번째 단위.",
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            WidgetCustomTextBox(
                              maxLine: 6,
                              width: indexWidth,
                              height: tfHeight,
                              msg: "단위 2  : ",
                              fontSize: indexfsize,
                              fontAlign: 0,
                            ),
                            WidgetCustomTextField(
                              width: valueWidth,
                              height: tfHeight,
                              onchanged: (newMetric) {
                                ref
                                    .read(stateForNewSportProvider.notifier)
                                    .changeMetric2(newMetric);
                              },
                              hintText: "두번째 단위",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                      width: width,
                      height: exHeight,
                      // color: Colors.green[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              WidgetCustomTextBox(
                                width: exEachWidth,
                                height: exEachHeight,
                                msg: "예시1)",
                                fontSize: exfsize,
                                fontAlign: 1,
                              ),
                              WidgetCustomTextBox(
                                  width: exEachWidth,
                                  height: exEachHeight,
                                  msg: "벤치프레스",
                                  fontSize: exfsize,
                                  fontAlign: 1),
                              WidgetCustomTextBox(
                                  width: exEachWidth,
                                  height: exEachHeight,
                                  msg: "   kg",
                                  fontSize: exfsize,
                                  fontAlign: 2),
                              WidgetCustomTextBox(
                                  width: exEachWidth,
                                  height: exEachHeight,
                                  msg: "   회",
                                  fontSize: exfsize,
                                  fontAlign: 2),
                            ],
                          ),
                          Row(
                            children: [
                              WidgetCustomTextBox(
                                  width: exEachWidth,
                                  height: exEachHeight,
                                  msg: "예시2)",
                                  fontSize: exfsize,
                                  fontAlign: 1),
                              WidgetCustomTextBox(
                                  width: exEachWidth,
                                  height: exEachHeight,
                                  msg: "런닝머신",
                                  fontSize: exfsize,
                                  fontAlign: 1),
                              WidgetCustomTextBox(
                                  width: exEachWidth,
                                  height: exEachHeight,
                                  msg: "   단계",
                                  fontSize: exfsize,
                                  fontAlign: 2),
                              WidgetCustomTextBox(
                                  width: exEachWidth,
                                  height: exEachHeight,
                                  msg: "   분",
                                  fontSize: exfsize,
                                  fontAlign: 2),
                            ],
                          ),
                          Row(
                            children: [
                              WidgetCustomTextBox(
                                  width: exEachWidth,
                                  height: exEachHeight,
                                  msg: "예시3)",
                                  fontSize: exfsize,
                                  fontAlign: 1),
                              WidgetCustomTextBox(
                                  width: exEachWidth,
                                  height: exEachHeight,
                                  msg: "마라톤",
                                  fontSize: exfsize,
                                  fontAlign: 1),
                              WidgetCustomTextBox(
                                  width: exEachWidth,
                                  height: exEachHeight,
                                  msg: "   km",
                                  fontSize: exfsize,
                                  fontAlign: 2),
                              WidgetCustomTextBox(
                                  width: exEachWidth,
                                  height: exEachHeight,
                                  msg: "   분",
                                  fontSize: exfsize,
                                  fontAlign: 2),
                            ],
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
          actions: [
            WidgetDoubleBtn(
                leftFunc: () {
                  //상태 초기화
                  ref
                      .read(stateForNewSportProvider.notifier)
                      .initialStateForAdd();
                  //나가기
                  context.pop();
                },
                rightFunc: () async {
                  int rs = await ref
                      .read(stateForNewSportProvider.notifier)
                      .insertToDatabase(); // 저장하고
                  if (rs != 1) {
                    //에러 종류에 따라서 에러처리하려고했는데, 하다보니.. 뭐. 한종류만 처리해도 된다.
                    // return showErrorAlert(true);
                    return baseAlertForConfirm(context,
                        "문제가 발생하였습니다. \n종목 이름이 누락되었을 수 있습니다.\n 확인후 다시 시도해보세요.");
                  } //에러처리하고
                  await ref
                      .read(stateForNewSportProvider.notifier)
                      .initialStateForAdd(); // 초기화 시키고
                  await ref
                      .read(wholeListForAddInFolder.notifier)
                      .getAllSportsFormed();
                  await ref
                      .read(wholeListStateProvider.notifier)
                      .setWholeList(); //돌아갈 화면 초기화 시키고
                  context.pop(); //화면으로 돌아가고
                },
                width: width,
                height: btnHeight),
          ],
        );
      },
    );
  }

  //종목 삭제 기능
  deleteFunction(int sportID) async {
    //지우고
    bool rs =
        await ref.read(wholeListStateProvider.notifier).deleteSport(sportID);
    //결과학인
    if (!rs) {
      return baseAlertForConfirm(
          context, "문제가 발생하였습니다.\n 이미 지운 데이터 일 수 있습니다.\n app 재실행후 다시 시도해보세요.");
    }
    //전체리스트 새로고침
    ref.read(wholeListStateProvider.notifier).setWholeList();
    ref.read(wholeListForAddInFolder.notifier).getAllSportsFormed();

    //폴더별 리스트 새로고침
    final folderList = ref.read(folderListProvider);
    for (SportFolderModel model in folderList) {
      ref
          .read(sportListInFolderStateProvider(model.sfId!).notifier)
          .getSportInFolder();
    }
  }

  // 에러처리 위함.
  // showErrorAlert(bool opt) {
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         content: WidgetCustomTextBox(
  //           width: 250,
  //           height: 35,
  //           msg:
  //               "문제가 발생하였습니다. ${opt ? '\n종목 이름이 누락되었거나' : ''} \n app 재실행후 다시 시도해보세요.",
  //           fontSize: fontSize(context, 3),
  //         ),
  //         actions: [
  //           ElevatedButton(
  //             onPressed: () {
  //               context.pop();
  //             },
  //             child: WidgetCustomTextBox(
  //               width: 100,
  //               height: 30,
  //               msg: "확인",
  //               fontSize: fontSize(context, 2),
  //             ),
  //           )
  //         ],
  //       );
  //     },
  //   );
  // }
} // end class
