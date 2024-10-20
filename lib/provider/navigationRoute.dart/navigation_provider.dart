import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/view/IndexGoalPart/index_goal_detail_view.dart';
import 'package:myhealthdiary_app/view/IndexGoalPart/index_goal_insert_view.dart';
import 'package:myhealthdiary_app/view/IndexGoalPart/index_goal_list_view.dart';
import 'package:myhealthdiary_app/view/IndexRecPart/index_rec_insert_view.dart';
import 'package:myhealthdiary_app/view/IndexRecPart/index_rec_list_view.dart';
import 'package:myhealthdiary_app/view/SportListPart/sport_list_view.dart';
import 'package:myhealthdiary_app/view/TrainGoalPart/train_goal_detail_view.dart';
import 'package:myhealthdiary_app/view/TrainGoalPart/train_goal_insert_view.dart';
import 'package:myhealthdiary_app/view/TrainGoalPart/train_goal_list_view.dart';
import 'package:myhealthdiary_app/view/TrainPlanPart/plan_add_new_sport_view.dart';
import 'package:myhealthdiary_app/view/TrainPlanPart/plan_add_new_title_view.dart';
import 'package:myhealthdiary_app/view/TrainPlanPart/plan_list_view.dart';

import '../../view/home.dart';

// 다음 버전에서는 온라인 혹은 보안 설정까지 넣기 위해 미리 provider/notifier 활용하여 navigation 설정
final routerProvider = Provider<GoRouter>((ref) {
  final navigationProvider = NavigationNotifier();
  return GoRouter(
    initialLocation: '/',
    routes: navigationProvider._routes,
  );
});

class NavigationNotifier extends ChangeNotifier {
  NavigationNotifier();

  List<GoRoute> get _routes => [
        GoRoute(
          path: "/",
          name: "_",
          builder: (context, state) => const Home(),
          routes: [
// HealthIndex 목표 관리 페이지 루팅
            GoRoute(
                path: "Goal",
                name: IndexGoalListView.routeName,
                builder: (context, state) => const IndexGoalListView(),
                routes: [
                  GoRoute(
                    path: "Detail",
                    name: IndexGoalDetailView.routeNameForIndexGoalDetail,
                    builder: (context, state) => const IndexGoalDetailView(),
                  ),
                  GoRoute(
                    path: "Insert",
                    name: IndexGoalInsertView.routeNameForIndexGoalInsertView,
                    builder: (context, state) =>
                        const IndexGoalInsertView(forInsert: true),
                  ),
                ]),
// HealthIndex 기록 관리 페이지 루팅
            GoRoute(
              path: "Records",
              name: IndexRecListView.routeNameForIndexRecList,
              builder: (context, state) {
                return const IndexRecListView();
              },
              routes: [
                GoRoute(
                  path: "Insert",
                  name: IndexRecInsertView.routeForIndexRecInsertView,
                  builder: (context, state) {
                    return const IndexRecInsertView(
                      opt: true,
                    );
                  },
                ),
                GoRoute(
                  path: "detail",
                  name: IndexRecInsertView.routeForIndexRecDetailView,
                  builder: (context, state) {
                    return const IndexRecInsertView(
                      opt: false,
                    );
                  },
                ),
              ],
            ),
// 훈련 목표 관리 페이지 루팅
            GoRoute(
              path: "TrainGoal",
              name: TrainGoalListView.routeForTrainGoalListView,
              builder: (context, state) {
                return const TrainGoalListView();
              },
              routes: [
                //목표 입력하는 route  traingoal시작 -> SportList -> insertTrain (하지만 여기서 뒤로갈떄는 TrainGoal 로 가기.)
                  GoRoute(
                    path: 'selectSport',
                    name: SportListView.routeForInsertTrainGoal,
                    builder: (context, state) => const SportListView(opt: 'goal',),
                    ),
                GoRoute(
                  path: 'insert',
                  name: TrainGoalInsertView.routeForTrainGoalInertView,
                  builder: (context, state) => const TrainGoalInsertView(),
                ),
                //목표 상세보기 route  traingoal시작 -> insertTrain (하지만 여기서 뒤로갈떄는 TrainGoal 로 가기.)
                GoRoute(
                  path: 'detail',
                  name: TrainGoalDetailView.routeForTrainGoalDetailView,
                  builder: (context, state) => const TrainGoalDetailView(),
                ),
              ],
            ),
//운동 계획 관리 페이지 루트            
            GoRoute(
              path: "trainPlan",
              name: TrainPlanListView.routeForTrainPlanListView,
              builder: (context, state) => const TrainPlanListView(),
              routes: [
//운동 계획을 새로 입력하는 과정.
//add New Title . 모든 운동 계획은 Title + date 조합으로 분류 되도록 db를 짯다.
// 같은날 같은 Title로 계획 한 세트를 등록해야한다.
                GoRoute(
                  path: "addPlan",
                  name: PlanAddNewTitleView.routeForPlanAddNewTitle,
                  builder: (context, state) => const PlanAddNewTitleView(isNew: true, opt: "plan"),
                  routes: [                    
                  GoRoute(
                    path: 'selectSport',
                    name: SportListView.routeForInsertTrainPlan,
                    builder: (context, state) => const SportListView(opt: 'plan',),
                    ),
                  GoRoute(
                    path:'addSportSet',
                    name: PlanAddNewSportView.routeForPlanAddNewSportSet,
                    builder: (context, state) => const PlanAddNewSportView(),
                    )                    
                  ]
                  ),
                GoRoute(
                  path: "showPlan",
                  name: PlanAddNewTitleView.routeForPlanDetailView,
                  builder: (context, state) => const PlanAddNewTitleView(isNew: false,opt: "plan"),
                  routes: [                    
                  GoRoute(
                    path: 'selectSport',
                    name: SportListView.routeForUpdatePlan,
                    builder: (context, state) => const SportListView(opt: 'plan',),
                    ),
                  GoRoute(
                    path:'addSportSet',
                    name: PlanAddNewSportView.routeForPlanUpdateSportSet,
                    builder: (context, state) => const PlanAddNewSportView(),
                    )                    
                  ]
                  ),
              ]
              ),
//운동 하러 가기 페이지 루트              
            GoRoute(
              path: "train",
              name: "__",
              builder: (context, state) => const TrainPlanListView(),
              ),
          ],
        )
      ];
}
