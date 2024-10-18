import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/common/widget/layOut/base_layout.dart';

class TrainGoalInsertView extends ConsumerWidget {
  static String routeForTrainGoalInertView= "routeForTrainGoalInertView";
  static String routeForTrainGoalDetailView= "routeForTrainGoalDetailView";
  const TrainGoalInsertView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(builder: (context, constraints) {
      return BaseLayout(
        barTitle: "수행 능력 목표 리스트",
        body:Center(

        )
        );
    },);
  }
}