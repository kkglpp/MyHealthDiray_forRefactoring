import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_text_box.dart';
import 'package:myhealthdiary_app/train.plan.part/provider/train_plan_add_new_sport_notifier.dart';

import '../../baseModel/training_plan_model.dart';


class TrainStartCard extends ConsumerWidget {
  final TrainingPlanModel model;
  final String metric1;
  final String metric2;
  final double fontsize;
  final double height;
  final Function() timerAct;
  const TrainStartCard({
    super.key,
    required this.model,
    required this.metric1,
    required this.metric2,
    required this.fontsize,
    required this.height,
    required this.timerAct,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final state =
    //     ref.watch(planListProviderForAdd((sportId, sportName, sportDate)));
    // int sportId = ref.read(showSportIdProvider.notifier).state;
    // String sportTitle = ref.read(titleProvider.notifier).state;
    // String trainDate = onlyDay(ref.read(selectedDayProvider.notifier).state);

    // bool done = ref.watch(boolForTrainingCard(model.tpId!));
    return LayoutBuilder(
      builder: (context,constraints) {
        double maxWidth = constraints.maxWidth-20;
        double setNumWidth = maxWidth * 0.15; //1개
        double valueWidth = maxWidth * 0.15; //2개
        double metricWidth = maxWidth * 0.15; //2개
        double doneBtnWidth = maxWidth * 0.2;

        return Container(
          width: maxWidth,
          height: height,
          decoration: BoxDecoration(
              color: model.tpDone==1 ? Colors.grey : null,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              WidgetCustomTextBox(
                width: setNumWidth,
                fontAlign: 2,
                verAlign: 1,            
                msg: "${model.tpSet} set", fontSize: fontsize),      
              WidgetCustomTextBox(
                width: valueWidth,
                fontAlign: 2,
                verAlign: 1,
                msg: model.tpRec1.toString(),
                fontSize: fontsize,
              ),

              WidgetCustomTextBox(
                width: metricWidth,
                verAlign: 1,
                fontAlign: 0,
                msg: metric1,
                fontSize: fontsize,
              ),
              WidgetCustomTextBox(
                width: valueWidth,
                fontAlign: 2,
                verAlign: 1,
                msg: model.tpRec2.toString(),
                fontSize: fontsize,
              ),
              WidgetCustomTextBox(
                width: metricWidth,
                verAlign: 1,
                fontAlign: 0,
                msg: metric2,
                fontSize: fontsize,
              ),

              SizedBox(
                width: doneBtnWidth,
                child: IconButton(
                    onPressed: () async {
                      if (model.tpDone==1) {
                        return;
                      }
                      bool rs = await ref
                          .read(trainPlanAddNewSportNotifierProvider.notifier)
                          .donePlanRow(model.tpId!);
                      // // print(rs);
                      // ref.read(boolForTrainingCard(model.tpId!).notifier).state =
                      //     rs;
                      if(!rs){return;}
                      timerAct();
                    },
                    icon: Icon(
                      Icons.thumb_up,
                      color: model.tpDone!=1 ? Colors.blue : Colors.black,
                    ),
                    ),
              ),

            ],
          ),
        );
      }
    );
  }
}
