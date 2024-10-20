import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/baseModel/training_plan_model.dart';
import 'package:myhealthdiary_app/common/const/base_alert.dart';
import 'package:myhealthdiary_app/common/const/basic_method.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/widget/layOut/base_layout.dart';
import 'package:myhealthdiary_app/common/widget/widget_banner_for_ad.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_elebtn.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_text_box.dart';
import 'package:myhealthdiary_app/common/widget/widget_double_btn.dart';
import 'package:myhealthdiary_app/managerClass/train_plan_manager/train_plan_add_manager.dart';
import 'package:myhealthdiary_app/provider/providerForShared/collection_of_basic_state_provider.dart';
import 'package:myhealthdiary_app/provider/providerForTrainPart/train_plan_daily_notifier.dart';
import 'package:myhealthdiary_app/provider/providerForTrainPart/train_plan_list_notifier.dart';
import 'package:myhealthdiary_app/view/SportListPart/sport_list_view.dart';
import 'package:myhealthdiary_app/view/TrainPlanPart/plan_day_todo_list_card.dart';

/// 운동 계획을 insert하고 d
class PlanDayTodoListView extends ConsumerWidget {
  static String routeForPlanAddNewTitle = "routeForPlanAddNewTitle";
  static String routeForPlanDetailView = "routeForPlanDetailView";
  static String routeForReadyWithoutPlan = "routeForReadyWithoutPlan";
  static String routeForReadyAsPlan = "routeForReadyAsPlan";
  ///True 면 신규등록, False 면 상세보기/수정하기
  final bool isNew;

  /// plan : 계획 관리 하는 옵션.
  /// trainAsPlan : 계획있이 운동하러 가는 옵션
  /// trainWithoutPlan: 계획 없이.
  final String opt;
  const PlanDayTodoListView({super.key, required this.isNew,required this.opt});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return BaseLayout(
      barTitle: "훈련 일정 확인",
      leadbtn: const SizedBox(),
      body: LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth - 20;
        double maxHeight = constraints.maxHeight;

        //높이 계산
        double titlePartHeight = maxHeight * 0.06;
        double divHeight = maxHeight * 0.01;
        double datePartHeight = maxHeight * 0.04;
        double sportListPart = maxHeight * 0.58;
        double btnPartHeight = maxHeight * 0.08;
        //세부 높이 계산
        double cardHeight = maxHeight * 0.08;
        double addSportBtnPadding = maxHeight * 0.1;

        //넓이 계산
        double titleLefitWidth = maxWidth * 0.3;
        double titleRightWidth = maxWidth * 0.5;
        double dateLeftWidth = maxWidth * 0.2;
        double dateRightWidth = maxWidth * 0.35;
        //글자크기
        double titleLeftFz = fontSize(context, 3);
        double titleRightFz = fontSize(context, 7);
        double dateLeftFz = fontSize(context, 3);
        double dateRightFz = fontSize(context, 4);
        double cardLeftFz = fontSize(context, 4);
        //계획의 타이틀과 날짜를 관찰 / 가져오는 provier
        final planTitle = ref.watch(titleProvider);
        final planDate = ref.watch(selectedDayProvider);
        // 계획에 들어가는 운동들을 보여주는 Provider
        final state = ref.watch(trainPlanDailyNotifierProvider);
        List<PlanListOfPlanSet> stateList = state.when(
          data: (data) {return data;},
          error: (error, stackTrace) {
            return [];
          },
          loading: () {
            return [];
          },
          );

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: maxWidth,
                height: titlePartHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    WidgetCustomTextBox(
                        width: titleLefitWidth,
                        msg: "Train Title : ",
                        fontSize: titleLeftFz,
                        verAlign: 1,
                        fontAlign: 2,
                      ),

                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        onTap: () async {
                          if(!isNew){return;}
                          // 타이틀은 한번에 설정할 수 있도록 해야 추가적인 로직을 생략 할 수 있다.
                          // 하지만 편의성을 위해서 다음 버전에서는 로직을 추가하든, 화면 class를 분리하든
                          // 또다른 방법을 찾든 하자.
                          if(planTitle.trim().isNotEmpty){return;}
                          TrainPlanAddManager manager =
                              TrainPlanAddManager(context, ref);
                          String newTitle = await manager.setTitleManager();
                          ref.read(titleProvider.notifier).state = newTitle;
                        },
                        child: WidgetCustomTextBox(
                          maxLine: 1,
                          width: titleRightWidth,
                          height: titlePartHeight,
                          msg: planTitle.trim() == ""
                              ? "타이틀을 입력하세요."
                              : planTitle,
                          fontSize: titleRightFz,
                          verAlign: 1,
                          fontAlign: 0,
                        )),
                  ],
                ),
              ),
              SizedBox(
                width: maxWidth,
                height: divHeight,
                child: const Divider(
                  color: constMainColor,
                ),
              ),
              /* 날짜 선택하는 파트 */
              SizedBox(
                // color: Colors.green[100],
                width: maxWidth,
                height: datePartHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    WidgetCustomTextBox(
                      width: dateLeftWidth,
                      height: datePartHeight,
                      msg: "계획 날짜  : ",
                      fontSize: dateLeftFz,
                      verAlign: 2,
                      fontAlign: 1,
                    ),
                    WidgetCustomTextBox(
                      maxLine: 1,
                      width: dateRightWidth,
                      height: datePartHeight,
                      fontColor: Colors.deepPurple,
                      bold: true,
                      msg: onlyDay(planDate),
                      fontSize: dateRightFz,
                      verAlign: 2,
                      fontAlign: 0,
                    ),
                  ],
                ),
              ),
              /* 각 운동 종목과 세트들을 입력하는 파트 */
              SizedBox(
                // Container(
                // color: Colors.amber[100],
                width: maxWidth,
                height: sportListPart,
                child: ListView.builder(
                  itemCount: stateList.length+1,
                  itemBuilder: (context, index) {
                    return index == stateList.length
                        ? Padding(
                            padding:  EdgeInsets.fromLTRB(0, addSportBtnPadding, 0, 20),
                            child: WidgetCustomEleBtn(
                                color: Colors.purple,
                                fontSize: cardLeftFz,
                                height: cardHeight,
                                msg: "운동 추가하기",
                                width: maxWidth,
                                onPressed: () async {
// 운동 종목을 고르는 페이지로 이동한다. 이동한 페이지는 같지만, 이동되는 경로가 다르다.
// 근데 이럴거면 sportList 쪽은 그냥 별도의 루트로 뺴는게 맞지 않나 싶다.                                  
                                  // print(planTitle);
                                  if (planTitle.trim() == "") {
                                    await baseAlertForConfirm(
                                        context, "타이틀을 먼저 입력해 주세요.");
                                    return;
                                  }
                                  if(opt =="trainWithoutPlan"){
                                    context.goNamed(SportListView.routeForTrainWithout);
                                    return;
                                  }
                                  if(opt=="trainAsPlan"){
                                    context.goNamed(SportListView.routeForTrainAsPlan);
                                    return;
                                  }
//운동하러 가는 경우는 다 처리했다.                                  
                                  //처음 등록이면 insertTrainPlan 옵션이다
                                  if (stateList.isEmpty) {
                                    context.goNamed(
                                        SportListView.routeForInsertTrainPlan);
                                        return;
                                  }
                                  //이미 운동이 있으면 UpdatePlan 옵션이다.
                                  if (stateList.isNotEmpty) {
                                    context.goNamed(
                                        SportListView.routeForUpdatePlan);
                                        return;
                                  }
                                }),
                          )
                        : Dismissible(
                          direction: DismissDirection.startToEnd,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerLeft,
                            child: Icon(Icons.delete_forever, size: fontSize(context, 7)),
                          ),
                          key: ValueKey(index),
                          onDismissed: (direction) {
                            ref.read(trainPlanDailyNotifierProvider.notifier).deleteList(index);
                          },
                          child: PlanDayTodoListCard(
                            set: stateList[index],
                            width: maxWidth,
                            height: cardHeight,
                            opt: opt,
                            ),
                        );
                    // : TrainingPlanSetCard(set: state[index],opt: opt,);
                  },
                ),
              ),
              const BannerForAd(),
              SizedBox(
                // color: Colors.green[100],
                width: maxWidth,
                height: btnPartHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WidgetDoubleBtn(
                      leftFunc: () {
                        ref.read(titleProvider.notifier).state = "";
                        ref.read(selectedDayProvider.notifier).state =
                            DateTime.now();
                        ref.read(trainPlanListProvider.notifier).initState();
                        context.pop();
                      },
                      rightFunc: () {
                        ref.read(titleProvider.notifier).state = "";
                        ref.read(selectedDayProvider.notifier).state =
                            DateTime.now();
                        ref.read(trainPlanListProvider.notifier).initState();                            
                        context.go("/");
                      },
                      width: maxWidth,
                      height: btnPartHeight,
                      rightMsg: "🏠 Home",
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}
