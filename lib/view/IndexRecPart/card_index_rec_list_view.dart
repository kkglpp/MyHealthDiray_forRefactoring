import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/size.dart';

import '../../baseModel/health_index_record_model.dart';
import '../../common/const/basic_method.dart';
import '../../common/const/colors.dart';

import '../../common/widget/widget_custom_text_box.dart';
import '../../provider/collection_of_basic_state_provider.dart';
import 'bar_card_index_rec_list_view.dart';

class CardIndexRecListView extends ConsumerWidget {
  final HealthIndexRecordModel model;
  final double widthValue;
  final double heightValue;
  const CardIndexRecListView({super.key, required this.model,required this.widthValue,required this.heightValue, });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double imgSize = widthValue*(1/2.2).clamp(heightValue, heightValue);
    return GestureDetector(
      onTap: () {
        //화면에 보여줄 id로  provider를 셋팅 한다.
        ref.read(showingHealthIndexRecordIDProvider.notifier).state =model.hrId!;
        context.go('/IndexRecords/ShowDetail/${model.hrId}');
      },
      child: Container(
        width: widthValue,
        height: heightValue,
        color: const Color.fromARGB(255, 242, 240, 240),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(children: [
              Container(
                width: imgSize,
                height: imgSize,
                color: Colors.black,
                child:Center(
                          child: WidgetCustomTextBox(
                          verAlign: 1,
                          width: imgSize,
                          height: imgSize,
                          msg: "No\nImage",
                          fontSize: fontSize(context, 12),
                          fontColor: const Color.fromARGB(255, 30, 21, 21),
                          bold: true,
                        ),
                      )
                  // model.hrImg == null
                    // ? 
                    // Center(
                    // : Center(
                    //     child: WidgetCustomTextBox(
                    //       verAlign: 1,
                    //       width: imgSize,
                    //       height: imgSize,
                    //       msg: "이미지 불러오기 \n 작업해야 함",
                    //       fontSize: fontSize(context, 12),
                    //       fontColor: const Color.fromARGB(255, 30, 21, 21),
                    //       bold: true,
                    //     ),
                    //   ),
                    // : Image.memory(base64ToU8List(model.hrImg!)),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: imgSize,
                  height: (heightValue*(1/5)).clamp(20, 50),
                  color: Colors.white.withOpacity(0.9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.,
                    children: [
                      WidgetCustomTextBox(
                        verAlign: 1,
                        msg: model.hrInsertDate, fontSize: fontSize(context, 3),fontAlign: 2,),
                        SizedBox(
                          width: widthValue*(0.3),
                        )
                    ],
                  ),
                )
                )
            ],
            ),
            SizedBox(
              width: (widthValue- imgSize - 5),
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
                        value: calcBMI(model.hrHeight, model.hrWeight),
                        maxHeight: heightValue*0.95,
                        width: widthValue*(1/12),
                        color: bmiColor.withOpacity(
                            (calcBMI(model.hrHeight, model.hrWeight) / 50)
                                .clamp(0, 1)),
                        sort: "BMI",
                      ),
                      BarCardIndexRecListView(
                        maxValue: 80,
                        value: model.hrWeight,
                        maxHeight: heightValue*0.95,
                        width: widthValue*(1/12),
                        color: weightColor.withOpacity((model.hrWeight / 80).clamp(0, 1)),
                        sort: "몸무게",
                      ),
                      BarCardIndexRecListView(
                        maxValue: 40,
                        value: model.hrFat,
                        maxHeight: heightValue*0.95,
                        width: widthValue*(1/12),
                        color: fatColor
                            .withOpacity((model.hrFat ?? 40 / 40).clamp(0, 1)),
                        sort: "체지방",
                      ),
                      BarCardIndexRecListView(
                        maxValue: 50,
                        value: model.hrMuscle,
                        maxHeight: heightValue*0.95,
                        width: widthValue*(1/12),
                        color: muscleColor
                            .withOpacity((model.hrMuscle ?? 50 / 50).clamp(0, 1)),
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