import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/index.goal.part/provider/index_goal_notifier.dart';
import 'package:myhealthdiary_app/index.goal.part/view/index_goal_insert_view.dart';
import 'package:myhealthdiary_app/index.goal.part/view/card_index_goal_list.dart';

import '../../common/component/layOut/base_layout.dart';
import '../../common/component/widget_custom_flt_btn.dart';
import '../../common/component/widget_custom_txt_btn.dart';
import '../../common/component/widget_empty_card.dart';
import '../provider/index_goal_list_notifier.dart';

class IndexGoalListView extends ConsumerWidget {
  static String routeName = "HealthIndexGoalList";
  const IndexGoalListView({super.key});

/*
HealthIndexGoal 리스트를 보여주는 페이지.
HealthIndexGoalTableDataImpl 에서 목록을 가져온다.
List<  HealthIndexGoalModel  > 형태로 관리 된다.
Notifier : HealthGoalListNotifier 
Provider : healthGoalListProvider
 */
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalListState = ref.watch(healthIndexGoalListProvider);
    return BaseLayout(
        barTitle: " 내 건강 목표",
        body: LayoutBuilder(
          builder: (context, constraints) {
            // 높이 기준으로 크기들 설정하기
            double maxHeight = constraints.maxHeight;
            double optHeight = maxHeight * 0.07;
            double listViewHeight = (maxHeight) *0.9;
            double cardHeight = maxHeight / 4;
            //최대 넓이 기준으로 넓이 값설정하기
            double maxWidth = constraints.maxWidth;
            double width = maxWidth - 20;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
//페이지의 옵션으로  불러온 List를  목표날짜 기준 오름차순 내림차순 정리하는 파트.
//textBtn은 이후로도 계속 쓰일 예정.
                  SizedBox(
                    width: width,
                    height: optHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        WidgetCustomTxtBtn(
                          width: width/3,
                          height: optHeight,
                          txt: "목표일 ⬇️ ",
                          fsize: fontSize(context, 4),
                          clr: constConfirmColor,
                          onTap: () {
                            ref
                                .read(healthIndexGoalListProvider.notifier)
                                .sortByDuedateDESC();
                          },
                        ),
                        WidgetCustomTxtBtn(
                          width: width/3,
                          height: optHeight,
                          txt: "목표일 ⬆️ ",
                          fsize: fontSize(context, 4),
                          clr: constCancleColor,
                          onTap: () {
                            ref
                                .read(healthIndexGoalListProvider.notifier)
                                .sortByDuedateASC();
                          },
                        ),
                      ],
                    ),
                  ),
//리스트를 보여줄 파트
//CardIndexGoalList 위젯을 따로 만들 것.
//Card에 들어갈 것은 HealthIndexGoalModel 이면 된다.
                  SizedBox(
                    width: width,
                    height: listViewHeight,
                    child: goalListState.isEmpty
//List가 비어있으면  EmptyCard 를 보여준다.
                        ? Center(
                            child: WidgetEmptyCard(
                            width: width,
                            height: maxHeight * 0.5,
                            fontSize: fontSize(context, 4),
                          ))
                        : ListView.builder(
                            itemCount: goalListState.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: SizedBox(
                                  width: maxWidth - 20,
                                  height: cardHeight,
                                  child: CardIndexGoalList(
                                      model: goalListState[index],
                                      ),
                                ),
                              );
                            },
                          ),
                  )
                ],
              ),
            );
          },
        ),
        floatbtn: WidgetCustomFltBtn(onTap: () {
          //insert 하기위한 provider가  초기화 안되었을 수 있으니 초기화 한다.
          ref.read(insertIndexGoalModelProvider.notifier).initForInsertModel();
          //페이지 이동
          context.goNamed(IndexGoalInsertView.routeNameForIndexGoalInsertView);
        }));
  }
}
