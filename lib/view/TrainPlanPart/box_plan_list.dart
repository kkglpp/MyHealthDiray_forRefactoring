import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/basic_method.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_text_box.dart';
import 'package:myhealthdiary_app/provider/providerForShared/collection_of_basic_state_provider.dart';
import 'package:myhealthdiary_app/view/TrainPlanPart/plan_add_new_title_view.dart';

class BoxPlanList extends ConsumerWidget {
  final double width;
  final double height;
  final List<String> dailyPlanList;
  const BoxPlanList({super.key,required this.width,required this.height,required this.dailyPlanList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = onlyDay(ref.read(selectedDayProvider.notifier).state);
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
          return Padding(
            padding: const EdgeInsets.fromLTRB(10,10,10,0),
            child: GestureDetector(
              onTap: (){
                ref.read(titleProvider.notifier).state = dailyPlanList[index];
                context.goNamed(PlanAddNewTitleView.routeForPlanDetailView);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: constMainColor),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SizedBox(width: width*0.05,),
                    WidgetCustomTextBox(
                      fontAlign: 0,
                      width: (width-20) * 0.4,
                      height: (height/5).clamp(20, 40),
                      msg: dailyPlanList[index],
                      fontSize: fontSize(context, 3),
                      ),
                      WidgetCustomTextBox(
                      height: (height/5).clamp(20, 40),
                        width: (width-20) * 0.4,
                        msg:date,
                        fontSize: fontSize(context, 3)
                        )
                  ],
                ),
              ),
            ),
          );
          
        },)
    );
  }
}