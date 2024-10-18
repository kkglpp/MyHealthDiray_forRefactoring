import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/view/IndexGoalPart/index_goal_detail_view.dart';
import 'package:myhealthdiary_app/view/IndexGoalPart/index_goal_insert_view.dart';
import 'package:myhealthdiary_app/view/IndexGoalPart/index_goal_list_view.dart';
import 'package:myhealthdiary_app/view/IndexRecPart/index_rec_insert_view.dart';
import 'package:myhealthdiary_app/view/IndexRecPart/index_rec_list_view.dart';

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
                    return const IndexRecInsertView(opt: true,);
                  },
                ),
                GoRoute(
                  path: "detail",
                  name: IndexRecInsertView.routeForIndexRecDetailView,
                  builder: (context, state) {
                    return const IndexRecInsertView(opt: false,);
                  },
                ),
              ],
            ),
            
          ],
        )
      ];
}
