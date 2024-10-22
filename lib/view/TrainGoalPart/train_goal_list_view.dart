import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
<<<<<<< HEAD:lib/train.goal.part/view/train_goal_list_view.dart
import 'package:myhealthdiary_app/common/component/layOut/base_layout.dart';
import 'package:myhealthdiary_app/common/component/widget_custom_txt_btn.dart';
import 'package:myhealthdiary_app/common/component/widget_empty_card.dart';
import 'package:myhealthdiary_app/common/provider/providerForShared/collection_of_basic_state_provider.dart';
import 'package:myhealthdiary_app/sport.list.part/view/sport_list_view.dart';
import 'package:myhealthdiary_app/train.goal.part/provider/train_goal_list_notifier.dart';
import 'package:myhealthdiary_app/train.goal.part/view/card_for_goal_list.dart';
import 'package:myhealthdiary_app/train.goal.part/view/train_goal_detail_view.dart';
=======
import 'package:myhealthdiary_app/common/widget/layOut/base_layout.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_txt_btn.dart';
import 'package:myhealthdiary_app/common/widget/widget_empty_card.dart';
import 'package:myhealthdiary_app/provider/providerForShared/collection_of_basic_state_provider.dart';
import 'package:myhealthdiary_app/provider/providerForTrainPart/train_goal_list_notifier.dart';
import 'package:myhealthdiary_app/view/SportListPart/sport_list_view.dart';
import 'package:myhealthdiary_app/view/TrainGoalPart/card_for_goal_list.dart';
import 'package:myhealthdiary_app/view/TrainGoalPart/train_goal_detail_view.dart';
>>>>>>> parent of 6825cc4 (파트별로 폴더 분리.):lib/view/TrainGoalPart/train_goal_list_view.dart

import '../../common/component/widget_banner_for_ad.dart';

class TrainGoalListView extends ConsumerWidget {
  static String routeForTrainGoalListView = "routeForTrainGoalListView";
  const TrainGoalListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //목표 리스트를 관리한다.
    // 상태 관리는 TrainGoalListNotifier
    // TrainGoalListProvider
    final state = ref.watch(trainingGoalListPageProvider);

    //sport ID 랑 sportName과 Metric을 매칭하는 map을 하나 가져 와야  한다.
    //int 를 넣어서 String 을 가져와야 한다.

    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth - 20;
      double maxHeight = constraints.maxHeight;

      //높이값 계산
      double doneHeight = maxHeight * 0.07;
      double optHeight = maxHeight * 0.05;
      double listBoxHeight = maxHeight * 0.5; //
      double cardHeight = maxHeight * 0.08;

      //넓이값 계산
      double doneWidth = maxWidth * 0.31;
      double optWidth = maxWidth * 0.4;

      //글자크기 계산
      double doneSize = fontSize(context, 5);
      double optSize = fontSize(context, 4);

      return BaseLayout(
          barTitle: "훈련 목표 리스트",
          body: 
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(
                SizedBox(
                  width: maxWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
// 목표 리스트 종류를 선택하기 (진행중 / 성공한 / 실패한 목표)
                      WidgetCustomTxtBtn(
                        txt: "진행중 목표",
                        width: doneWidth,
                        height: doneHeight,
                        fsize: doneSize,
                        clr: Colors.black,
                        onTap: () {
                          // 진행중인 목표를 보여주기
                          ref
                              .read(trainingGoalListPageProvider.notifier)
                              .showProgressList();
                        },
                      ),
                      WidgetCustomTxtBtn(
                        txt: "성공한 목표",
                        width: doneWidth,
                        height: doneHeight,
                        fsize: doneSize,
                        clr: constConfirmColor,
                        onTap: () {
                          // 성공한 목표 보여주기
                          ref
                              .read(trainingGoalListPageProvider.notifier)
                              .showSuccessList();
                        },
                      ),
                      WidgetCustomTxtBtn(
                        txt: "실패한 목표",
                        width: doneWidth,
                        height: doneHeight,
                        fsize: doneSize,
                        clr: constCancleColor,
                        onTap: () {
                          // 실패한 목표 보여주기
                          ref
                              .read(trainingGoalListPageProvider.notifier)
                              .showFailList();
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: maxWidth,
                  height: 10,
                  child: const Divider(),
                ),
//목표 날짜를 기준으로 오름/내림차순 정렬하는 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WidgetCustomTxtBtn(
                      txt: "목표 날짜 ⬇️",
                      width: optWidth,
                      height: optHeight,
                      fsize: optSize,
                      clr: constConfirmColor,
                      onTap: () {
                        ref
                            .read(trainingGoalListPageProvider.notifier)
                            .sortForDESC();
                      },
                    ),
                    WidgetCustomTxtBtn(
                      txt: "목표 날짜 ⬆️ ",
                      width: optWidth,
                      height: optHeight,
                      fsize: optSize,
                      clr: constCancleColor,
                      onTap: () {
                        ref
                            .read(trainingGoalListPageProvider.notifier)
                            .sortForASC();
                      },
                    )
                  ],
                ),
                SizedBox(
                  width: maxWidth,
                  height: 10,
                  child: const Divider(),
                ),
                SizedBox(
                  width: maxWidth,
                  height: listBoxHeight,
                  child: state.isEmpty
                      ? Center(
                          child: WidgetEmptyCard(
                            width: maxWidth,
                            height: maxHeight * 0.45,
                            fontSize: fontSize(context, 8),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            ref
                                .read(trainingGoalListPageProvider.notifier)
                                .initiateState();
                          },
                          child: ListView.builder(
                            itemCount: state.length + 1,
                            itemBuilder: (context, index) {
//리스트뷰 빌더로 목표들을 보여준다,.
//마지막에 하나 더 넣어서 목록을 더 가져오는 버튼을 추가했다.
                              return index == state.length
                                  // 목록 10개 추가하는 버튼 먼저 넣자
                                  ? TextButton(
                                      style: TextButton.styleFrom(
                                          fixedSize:
                                              Size(maxWidth, cardHeight)),
                                      onPressed: () {
                                        // 10개 더보기
                                      },
                                      child: Icon(
                                        Icons.more_vert,
                                        size: fontSize(context, 10),
                                      ),
                                    )
                                  //각 리스트 카드 간단하게 보여주자
                                  : Padding(
                                    padding: const EdgeInsets.fromLTRB(0,8,0,0),
                                    child: GestureDetector(
                                      onTap: (){
                                        //Sport 정보를 보여주기위해서, showingSportIdProvider 를 업데이트
                                        ref.read(showSportIdProvider.notifier).state = state[index].tgSId;
                                        // 보여줄 목표 아이디를 관리하는 showingTrainIDProvider 업데이트
                                        ref.read(showTraingGoalIDProvider.notifier).state = state[index].tgId!;
                                        //화면이동.
                                        context.goNamed(TrainGoalDetailView.routeForTrainGoalDetailView);
                                      },
                                      child: CardForGoalList(
                                          goal: state[index],
                                          maxWidth: maxWidth,
                                          height: cardHeight,
                                        ),
                                    ),
                                  );
                            },
                          ),
                        ),
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20)),
                  width: maxWidth,
                  height: cardHeight,
                  child: IconButton(
                    onPressed: () {
                      context.goNamed(SportListView.routeForInsertTrainGoal);
                    },
                    icon: Icon(
                      Icons.add,
                      size: fontSize(context, 10),
                    ),
                  ),
                ),
                const Spacer(),
                const BannerForAd(),
              ],
            ),
          ));
    });
  }
}
