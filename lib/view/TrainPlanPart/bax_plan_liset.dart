import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';

class BoxPlanList extends ConsumerWidget {
  final double width;
  final double height;
  final List<String> dailyPlanList;
  const BoxPlanList({super.key,required this.width,required this.height,required this.dailyPlanList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
 
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: constMainColor
        ),
      borderRadius: BorderRadius.circular(20),
      ),
      width: width,
      height: height,
      child: ListView.builder(
        itemCount: dailyPlanList.length,
        itemBuilder:(context, index) {
          
        },)
    );
  }
}