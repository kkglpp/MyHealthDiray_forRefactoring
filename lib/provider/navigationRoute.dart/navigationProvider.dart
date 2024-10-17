import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/home.dart';
import 'package:myhealthdiary_app/view/IndexGoalPart/IndexGoalDetailView.dart';
import 'package:myhealthdiary_app/view/IndexGoalPart/IndexGoalInsertView.dart';
import 'package:myhealthdiary_app/view/IndexGoalPart/IndexGoalListView.dart';
import 'package:myhealthdiary_app/view/IndexRecPart/IndexRecInsertView.dart';
import 'package:myhealthdiary_app/view/IndexRecPart/IndexRecListView.dart';

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
        GoRoute(
          path: "Goal",
          name: IndexGoalListView.routeName,
          builder: (context, state) => IndexGoalListView(),
          routes: [
            GoRoute(
              path: "Detail",
              name: IndexGoalDetailView.RouteNameForIndexGoalDetail,
              builder: (context, state) => IndexGoalDetailView(),
              ),
              
            GoRoute(
              path: "Insert",
              name: IndexGoalInsertView.routeNameForIndexGoalInsertView,
              builder: (context, state) => IndexGoalInsertView(forInsert: true),
              ),
          ]
          ),
          GoRoute(
            path: "Records",
            name: IndexRecListView.routeNameForIndexRecList,
            builder: (context, state) {
              return IndexRecListView();
            },
            routes: [
              GoRoute(path: "Insert",
              name: IndexRecInsertView.routeForIndexRecInsertView,
              builder: (context, state) {
                return IndexRecInsertView();
              },
              
              ),

            ]


            )
        
      ]

    )

  ];
}