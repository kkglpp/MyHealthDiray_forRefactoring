import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/common/const/size.dart';

import '../../common/component/widget_custom_text_box.dart';
import '../../managerClass/double_value_alert_manager.dart';

class CardIndexRecord extends ConsumerWidget {
  /// 지표 이름. 왼쪽 상자 텍스트
  final String indexName;

  /// 지표 값. 가운데 상자.
  final double? value;

  /// 지표의 단위
  final String metric;

  ///  지표를 입력할떄 최소 값 : 필수는 아님
  final double min;

  ///  지표를 입력할떄 최대 값 : 필수는 아님
  final double max;

  /// 값을 입력박디 위한 상태이냐. 여부
  /// True가 기본값. false면 입력불가.
  final bool isInsert;

  ///값을 바꾸는 함수를 넣어라.
  final Function changeVal;

  const CardIndexRecord({
    super.key,
    required this.indexName,
    required this.value,
    required this.metric,
    required this.min,
    required this.max,
    this.isInsert = true,
    required this.changeVal,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth;
      double maxHeight = constraints.maxHeight;
      double fsize = fontSize(context, 3);
      //왼쪽 박스 기존 130w
      double firstWidth = maxWidth * (10 / 30);
      //가운데 및 오른쪽 박스
      double secondWidth = maxWidth * (10 / 30);
      double thirdWidth = maxWidth * (10 / 30);
      //여백을 뺀 높이
      double height = maxHeight * (7 / 10);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: firstWidth,
            height: height,
            // color: Colors.blue[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetCustomTextBox(
                  width: firstWidth,
                  height: height,
                  verAlign: 1,
                  msg: indexName,
                  fontSize: fsize,
                  fontAlign: 0,
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              if(!isInsert){return;}
              double? newValue = await doubleValueAlertManager(ref, indexName, metric, value ?? 30, min, max);
              changeVal(newValue);
            },
            child: Container(
              width: secondWidth,
              height: height,
              color: Colors.grey[200],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WidgetCustomTextBox(
                    verAlign: 1,
                    width: secondWidth,
                    height: height,
                    msg: value == null ? '-' : value.toString(),
                    fontSize: fsize,
                    fontAlign: 2,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: thirdWidth,
            height: height,
            // color: Colors.green[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                WidgetCustomTextBox(
                  width: thirdWidth,
                  height: height,
                  verAlign: 2,
                  fontAlign: 0,
                  msg: "   $metric",
                  fontSize: fsize,
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}

/*
날짜 파트만.  거의 양식이 같은데 별도 파일ㄹ로 만들 필요가 있을까?
날짜는 그날그날 기록하도록만 제한한다.
 */
class CardIndexRecForDate extends StatelessWidget {

  /// 지표 값. 가운데 상자.
  final String value;
  /// 값을 입력하기 위한 상태이냐. 여부
  /// True가 기본값. false면 입력불가.
  const CardIndexRecForDate({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth;
      double maxHeight = constraints.maxHeight;
      double fsize = fontSize(context, 5);
      //여백을 뺀 높이
      double height = maxHeight * (7 / 10);
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: maxWidth,
            height: height,
            // color: Colors.grey[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetCustomTextBox(
                  verAlign: 1,
                  width: maxWidth-20,
                  height: height,
                  msg: value ,
                  fontSize: fsize,
                  fontAlign: 1,
                )
              ],
            ),
          ),
        ],
      );
    }
    );
  }
}
