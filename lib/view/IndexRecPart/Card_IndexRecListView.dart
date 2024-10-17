import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/widget/WidgetCustomTextBox.dart';

import '../../baseModel/healthIndexRecord_model.dart';
import '../../common/basicMethod.dart';
import '../../common/const/colors.dart';
import 'Bar_CardIndexRecListView.dart';

class CardIndexRecListView extends ConsumerWidget {
  final HealthIndexRecordModel model;
  final width;
  final height;
  const CardIndexRecListView({super.key, required this.model,required this.width,required this.height, });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double imgSize = width*(1/2.2).clamp(height, height);
    return GestureDetector(
      onTap: () {
        context.go('/IndexRecords/ShowDetail/${model.id}');
      },
      child: Container(
        width: width,
        height: height,
        color: Color.fromARGB(255, 242, 240, 240),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(children: [
              Container(
                width: imgSize,
                height: imgSize,
                color: Colors.black,
                child: model.imgBase64 == null
                    ? Center(
                        child: WidgetCustomTextBox(
                          verAlign: 1,
                          width: imgSize,
                          height: imgSize,
                          msg: "No\nImage",
                          fontSize: fontSize(context, 12),
                          fontColor: Colors.white,
                          bold: true,
                        ),
                      )
                    : Image.memory(base64ToU8List(model.imgBase64!)),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: imgSize,
                  height: (height*(1/5)).clamp(20, 50),
                  color: Colors.white.withOpacity(0.9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.,
                    children: [
                      WidgetCustomTextBox(
                        verAlign: 1,
                        msg: model.insertdate, fontSize: fontSize(context, 3),fontAlign: 2,),
                        SizedBox(
                          width: width*(0.3),
                        )
                    ],
                  ),
                )
                )
            ],
            ),
            Container(
              width: (width- imgSize - 5),
              height: imgSize,
              // color: Colors.red[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BarCardIndexRecListView(
                        maxValue: 50,
                        value: calcBMI(model.height, model.weight),
                        maxHeight: height*0.95,
                        width: width*(1/12),
                        color: bmiColor.withOpacity(
                            (calcBMI(model.height, model.weight) / 50)
                                .clamp(0, 1)),
                        sort: "BMI",
                      ),
                      BarCardIndexRecListView(
                        maxValue: 80,
                        value: model.weight,
                        maxHeight: height*0.95,
                        width: width*(1/12),
                        color: weightColor.withOpacity((model.weight / 80).clamp(0, 1)),
                        sort: "몸무게",
                      ),
                      BarCardIndexRecListView(
                        maxValue: 40,
                        value: model.fat,
                        maxHeight: height*0.95,
                        width: width*(1/12),
                        color: fatColor
                            .withOpacity((model.fat ?? 40 / 40).clamp(0, 1)),
                        sort: "체지방",
                      ),
                      BarCardIndexRecListView(
                        maxValue: 50,
                        value: model.muscle,
                        maxHeight: height*0.95,
                        width: width*(1/12),
                        color: muscleColor
                            .withOpacity((model.muscle ?? 50 / 50).clamp(0, 1)),
                        sort: "골격근",
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}//end of _RecordCard