import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/view/IndexRecPart/index_rec_insert_view.dart';

import '../../baseModel/health_index_record_model.dart';
import '../../common/const/basic_method.dart';
import '../../common/const/colors.dart';

import '../../common/widget/widget_custom_text_box.dart';
import '../../provider/collection_of_basic_state_provider.dart';
import 'bar_card_index_rec_list_view.dart';

class CardIndexRecList extends ConsumerWidget {
  final HealthIndexRecordModel model;
  final double width;
  final double height;
  const CardIndexRecList({
    super.key,
    required this.model,
    required this.width,
    required this.height,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double imgSize = (width * 0.4).clamp(height * 0.2, height);
    final List<String> titleList = ["BMI", "체 중", "체지방율", "골격근량"];
    final List<Color> colorList = [
      bmiColor,
      weightColor,
      fatColor,
      muscleColor
    ];
    final List<double?> valueList = [calcBMI(model.hrHeight, model.hrWeight),model.hrWeight,model.hrFat,model.hrMuscle  ];
    final List<double> maxValueList = [70,150,70,90];
    return GestureDetector(
      onTap: () {
        //화면에 보여줄 id로  provider를 셋팅 한다.
        ref.read(showHealthIndexRecordIDProvider.notifier).state =
            model.hrId!;
        context.goNamed(IndexRecInsertView.routeForIndexRecDetailView);
      },
      child: Container(
        width: width,
        height: height,
        color: const Color.fromARGB(255, 242, 240, 240),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  width: imgSize,
                  height: imgSize,
                  color: Colors.black,
                  child: model.hrImg == null
                      ? Center(
                          child: WidgetCustomTextBox(
                            verAlign: 1,
                            width: imgSize,
                            height: imgSize,
                            msg: "No\nImage",
                            fontSize: fontSize(context, 5),
                            fontColor: Colors.white,
                            bold: true,
                          ),
                        )
                      : Center(
                          child: WidgetCustomTextBox(
                            verAlign: 1,
                            width: imgSize,
                            height: imgSize,
                            msg: "이미지 불러오기 \n 작업해야 함",
                            fontSize: fontSize(context, 12),
                            fontColor: const Color.fromARGB(255, 30, 21, 21),
                            bold: true,
                          ),
                        ),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: imgSize,
                      height: (height * (0.2)).clamp(15, 25),
                      color: Colors.white.withAlpha(200),
                      child: WidgetCustomTextBox(
                        verAlign: 1,
                        msg: model.hrInsertDate,
                        fontSize: fontSize(context, 3),
                        fontAlign: 0,
                      ),
                    ))
              ],
            ),
            SizedBox(
              width: (width - imgSize - 5),
              height: height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (int i = 0; i < 4; i++)
                        BarCardIndexRecListView(
                          maxValue: maxValueList[i],
                          value: valueList[i],
                          height: height,
                          width: width * (1 / 12),
                          color: colorList[i],
                          sort: titleList[i],
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