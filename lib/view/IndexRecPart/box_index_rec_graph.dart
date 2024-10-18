import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_text_box.dart';
import 'package:myhealthdiary_app/common/widget/widget_empty_card.dart';
import 'package:myhealthdiary_app/managerClass/painterManage/line_graph_for_indexes.dart';
import 'package:myhealthdiary_app/provider/acuu_record_index_notifier.dart';

class BoxIndexRecGraph extends ConsumerWidget {
  ///insert 인지 Detail 인지 구분하는곳.
  ///그래프 마지막 빈칸을 넣을지 말지. insert 면 true
  final bool opt;
  final double width;
  final double height;
  const BoxIndexRecGraph(
      {super.key,
      required this.opt,
      required this.width,
      required this.height});

  ///지난 indexRecord를 토대로 그래프를 그려서 보여주는 위젯
  /// 각 지표마다 provider를 만들어서 관리한다.
  /// family param 이용해 오버라이드 시키다가 헷갈려서 나누었다.나중에 수정할떄 또 같은 짓 하지말자. ************
  /// notifier는 동일한 것을 쓴다. AccuRecordsIndexNotifier
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heightState = ref.watch(accuHeightNotifierProvider);
    final weightState = ref.watch(accuWeightNotifierProvider);
    final fatState = ref.watch(accuFatNotifierProvider);
    final muscleState = ref.watch(accuMuscleNotifierProvider);
    final insertDate = ref.watch(accuInsertDateNotifierProvider);
    //Legend 요소
    final List<String> legendTitle = ["BMI", "체 중", "체지방율", "골격근량"];
    final List<Color> legendColor = [
      bmiColor,
      weightColor,
      fatColor,
      muscleColor
    ];
    //넓이값 조절

    // final today = onlyDay(DateTime.now());
    //각 부분 높이 계산
    double legendHeight = height * 0.1;
    double graphHeight = height * 0.6;
    double dateHeight = height * 0.2;

    //legend 넓이 조절
    double legendWidth = width / 5;
    double legendIconWidth = legendWidth * 0.2;
    double legendTxtWidth = legendWidth * 0.7;

    //글자크기
    double legendSize = fontSize(context, 1);
    double dateSize = fontSize(context, 0.5);
    
    //그래프 간격
//insert 일때는 마지막 칸 비우자.
//하지만 데이터가 1개일떄는 insert에서도 걍 다 센터에 표시해야함.
// -> 개수가 2개 넘고, insert 아니면 (detail 이면) : 꽉채운다.
// 그 외에는 모두 한자리 비운다.    
    double interval = insertDate.length != 1 && opt? (insertDate.length - 1): (width - 20) / (insertDate.length);
    double sidePadding = interval/2;

    return Container(
      color: Colors.amber[100],
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
// legend 입력하는 파트
          SizedBox(
            width: width,
            height: legendHeight,
            // color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < legendTitle.length; i++)
                  SizedBox(
                    width: width * 0.2,
                    child: Row(
                      children: [
                        WidgetCustomTextBox(
                          fontAlign: 2,
                          width: legendIconWidth,
                          msg: "●",
                          fontSize: legendSize * 1.1,
                          fontColor: legendColor[i],
                        ),
                        const Spacer(),
                        WidgetCustomTextBox(
                          fontAlign: 0,
                          width: legendTxtWidth,
                          msg: legendTitle[i],
                          fontSize: legendSize,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
//그래프 들어가는 파트
// 오류 처리.
// 0개면 detailView에서 infinitiy 오류  -> 0개일때는 아무것도 안보여준다.
// 1개여도 insert에서 infinitiy 오류. -> 1개일때는 그냥 다보여준다.
          insertDate.isEmpty
              ? WidgetEmptyCard(
                  width: width - 20,
                  height: graphHeight,
                  fontSize: fontSize(context, 8),
                )
              : SizedBox(
                  // color: Colors.black26,
                  height: graphHeight,
                  width: width-sidePadding,
                  child: CustomPaint(
                    painter: LineGraphForIndexes(
                        heightList: heightState,
                        weightList: weightState,
                        fatList: fatState,
                        muscleList: muscleState,
                        canvasHeight: graphHeight,
                        widthInteval: interval),
                  ),
                ),
          Container(
            color: Colors.white,
            height: dateHeight,
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (String date in insertDate)
                  WidgetCustomTextBox(
                    verAlign: 0,
                    width: interval,
                    height: dateHeight,
                    msg: "${date.substring(0, 4)}\n${date.substring(5, 10)}",
                    fontSize: dateSize,
                    fontAlign: 0,
                    bold: true,
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
