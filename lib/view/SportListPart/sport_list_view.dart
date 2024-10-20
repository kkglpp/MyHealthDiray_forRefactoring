import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/common/const/base_alert.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/provider/providerForSportList/sort_folder_state_notifier.dart';
import 'package:myhealthdiary_app/provider/providerForSportList/sport_folder_list_state_notifier.dart';
import 'package:myhealthdiary_app/provider/providerForSportList/sport_llist_state_notifier.dart';
import 'package:myhealthdiary_app/view/SportListPart/column_all_sportslist.dart';
import 'package:myhealthdiary_app/view/SportListPart/column_folder_sportlist.dart';

import '../../baseModel/sport_folder_model.dart';
import '../../common/widget/layOut/base_layout.dart';
import '../../common/widget/widget_custom_text_box.dart';
import '../../managerClass/sport_list_manage/sport_list_manager.dart';
import '../../managerClass/sport_list_manage/sportfolder_list_manager.dart';

class SportListView extends ConsumerWidget {
  ///trainingGoal 입력
  static String  routeForInsertTrainGoal = "routeForInsertTrainGoal";

  ///Training계획 입력
  static String  routeForInsertTrainPlan = "routeForInsertTrainPlan";

  ///Training 계획 업데이트
  static String  routeForUpdatePlan = "routeForUpdatePlan";

  ///계획없이 운동하기.
  static String  routeForTrainWithout = "routeForTrainWithout";

  ///계획 있게 운동하기. 근데 추가할거있을때
  static String  routeForTrainAsPlan = "routeForTrainAsPlan";


  /// goal : 목표 입력
  /// plan : 운동 계획 입력
  /// trainAsPlan : 운동하러 왔는데 계획에 운동 추가
  /// trainWithoutPlan : 계획은 없는데 일단 운동.
  final String opt;
  const SportListView({
    super.key,
    this.opt = "goal",
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print("???? :${GoRouterState.of(context).uri.toString()}  ");
 
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth - 20;
        double maxHeight = constraints.maxHeight;

        //높이 계산
        double boxHeight = maxHeight * 0.7;
        double descriptHeight = maxHeight * 0.06;
        double cellHeight = maxHeight / 20;
        double cellWidth = maxWidth / 5;
        double dividerPad = 3;
        //박스 안에 스포츠 리스트 들어가는 길이
        double columnHeight = boxHeight - cellHeight - (dividerPad * 5);

        // double borderWidthBold = 3;
        double borderWidthLight = 2;
        double borderWidthThin = 1;

        //글자크기
        double indexFontSize = fontSize(context, 3);
        // double nameFontSize = fontSize(context, 2);

        //데이터 상태관리 이 뷰에서 필요한 상태는 List로 2개이다.
        //1. 가장 왼쪽 열에서 모든 스포츠 목록을 보여주기 list
        //final sportList = ref.watch(wholeListStateProvider); // 해당 파트만 부분적으로 렌더링  파트검색 : wholeListStateProvider

        //2. 가장 위쪽에서 종목 분류 폴더를 보여주기 위한 list
        final folderList = ref.watch(folderListProvider);

        //폴더명들을 관리하는 부분

        SportListManager manager = SportListManager(ref: ref, context: context);
        SportFolderListManager folderManager =
            SportFolderListManager(context: context, ref: ref);
        //위젯 구성은 Row 안에 Column 을 배열한다.
        //각Column은 indexCell 1개 / 스포츠 종목 cell 리스트로 이루어진다.
        return BaseLayout(
          barTitle: "운동 종목 선택",
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                      horizontal: BorderSide(
                          width: borderWidthThin, color: Colors.black),
                    ),
                  ),
                  width: maxWidth,
                  height: boxHeight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      //전체를 관통하는 row
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          // color: Colors.grey,
                          width: cellWidth,
                          // height: boxHeight,
                          child: Column(
                            //리스트 전체를 보여주기위한 column
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              WidgetCustomTextBox(
                                verAlign: 1,
                                width: cellWidth,
                                height: cellHeight,
                                msg: "전체 목록",
                                fontSize: indexFontSize,
                                bold: true,
                              ),
                              SizedBox(
                                  width: cellWidth,
                                  height: dividerPad,
                                  child: Divider(
                                    thickness: borderWidthLight,
                                    color: Colors.black,
                                  )),
                              Consumer(builder: (context, ref, child) {
                                final sportList =
                                    ref.watch(wholeListStateProvider);
                                return ColumnAllSportsList(
                                  list: sportList,
                                  width: cellWidth,
                                  height: columnHeight,
                                  cellHeight: cellHeight,
                                  opt: opt,
                                );
                              })
                            ],
                          ),
                        ),
//전체 스포츠 목록 모여주는파트 끝
// 각 폴더마다 종목 보여주는 부문
                        SizedBox(
                          height: boxHeight,
                          width: dividerPad,
                          child: VerticalDivider(
                            color: Colors.black,
                            thickness: borderWidthLight,
                          ),
                        ),
                        //전체 스포츠 목록 보는 열 끝
                        //각 폴더별 목록 보여주기
                        for (SportFolderModel folder in folderList)
                          SizedBox(
                            width: cellWidth + 4,
                            height: boxHeight,
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    GestureDetector(
                                      //폴더명 길게 클릭하면 폴더 지우기
                                      onLongPress: () async {
                                        bool confirm =
                                            await baseAlertForConfirm(
                                                context, "폴더를 지우시겠습니까?");
                                        if (confirm) {
                                          //삭제하고
                                          ref
                                              .read(
                                                  folderStateForDeleteProvider(
                                                          folder.sfId!)
                                                      .notifier)
                                              .deleteFolder();
                                          //폴더리스트 초기화
                                          ref
                                              .read(folderListProvider.notifier)
                                              .setState();
                                        }
                                      },
                                      child: Container(
                                        // 폴더명 들어가는 박스
                                        color: Colors.grey[200],
                                        width: cellWidth,
                                        height: cellHeight,
                                        child: WidgetCustomTextBox(
                                            verAlign: 1,
                                            msg: folder.sfName,
                                            fontSize: indexFontSize),
                                      ),
                                    ),
                                    SizedBox(
                                      width: cellWidth,
                                      height: dividerPad,
                                      child: Divider(
                                        thickness: borderWidthLight,
                                        color: Colors.black,
                                      ),
                                    ),
                                    ColumnFolderSportList(
                                      folderID: folder.sfId!,
                                      widthSize: cellWidth,
                                      heightSize: columnHeight,
                                      cellHeight: cellHeight,
                                      opt: opt,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: boxHeight,
                                  width: dividerPad,
                                  child: VerticalDivider(
                                    color: Colors.grey,
                                    thickness: borderWidthLight,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        SizedBox(
                          // color: Colors.grey,
                          width: cellWidth,
                          height: boxHeight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                // color: Colors.red[100],
                                width: cellWidth,
                                height: cellHeight,
                                child: Container(
                                  color: Colors.grey[300],
                                  child: Center(
                                    child: IconButton(
                                        onPressed: () {
                                          folderManager.addFodlerAlert();
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          size: fontSize(context, 8),
                                        )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: cellWidth,
                                  height: dividerPad,
                                  child: Divider(
                                    thickness: borderWidthLight,
                                    color: Colors.black,
                                  )),
                              // SportListWidget(list: wholeState),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: dividerPad,
                          child: VerticalDivider(
                            color: Colors.grey,
                            thickness: borderWidthLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: maxWidth,
                  height: descriptHeight,
                  // color: Colors.blue[100],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WidgetCustomTextBox(
                        fontAlign: 0,
                        width: maxWidth * 0.7,
                        height: descriptHeight * 0.4,
                        msg: '종목 길게 눌러서 삭제.(폴더명에서 제거)',
                        fontSize: fontSize(context, 1),
                      ),
                      WidgetCustomTextBox(
                        fontAlign: 0,
                        width: maxWidth * 0.7,
                        height: descriptHeight * 0.4,
                        msg: '폴더도 길게 눌러서 목록에서 삭제',
                        fontSize: fontSize(context, 1),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          floatbtn: FloatingActionButton(
            onPressed: () {
              manager.addSportAlert();
              //스포츠 테이블에 스포츠 종목 추가하는 함수 실행하기.
            },
            child: SizedBox(
              width: 50,
              height: 50,
              // color: Colors.white,
              child: Center(
                child: WidgetCustomTextBox(
                  verAlign: 1,
                  msg: "+ ADD\nSport",
                  fontSize: fontSize(context, 3),
                  fontAlign: 1,
                  bold: true,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
