import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/const/basic_method.dart';
import '../../common/widget/widget_custom_text_box.dart';
import '../../managerClass/double_value_alert_manager.dart';
import '../../managerClass/pick_date_method.dart';

//  IndexGoalInsertView Widget에서 사용하는 카드이다.
//  opt에 따라서 DetailView 에서도 재탕하자.
//  입력받아야 할 값은  초기 Value
//  값을 변경하는 Method 가 필요하다.

// 추가적으로  필요한 것들
// index / metric / min / max /
// Width1, 2, 3
//높이는 상관 없을듯.
class CardIndexGoalValue extends ConsumerWidget {
  ///초기값
  final dynamic value;
  /// 명칭
  final String index;
  /// 단위
  final String metric;
  /// 입력값의 최소값
  final double min;
  /// 입력값의 최대값
  final double max;
  ///왼쪽박스 넓이
  final double leftWidth;
  /// 가운데박스(값 넣는 곳) 넓이
  final double midWidth;
  ///단위 박스 넓ㄴ이
  final double rightWidth;
  ///전체 높이
  final double height;
  ///버튼 활성화 옵션
  final bool opt;
  ///날짜 선택이냐?
  final bool date;
  final Function changeValue;
  const CardIndexGoalValue({
    super.key,
    required this.value,
    required this.index,
    required this.metric,
    required this.min,
    required this.max,
    required this.leftWidth,
    required this.midWidth,
    required this.rightWidth,
    required this.height,
    required this.changeValue,
    this.opt = true,
    this.date = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.read(insertDoubleValueProvider.notifier).state = value;
    //입력받을 값을 관리하는 provider가 필요하다.
    // final valueState = ref.watch(insertDoubleValueProvider);
    // 글자 크기는 통일 시키자. 단위 크기는 조금 깍아야함.
    double fontSize = (leftWidth * 0.2).clamp(10, 14);
    double smallHeight = height / 2.5;

    return SizedBox(
      width: (midWidth + leftWidth + rightWidth),
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: height,
            width: leftWidth,
            child: WidgetCustomTextBox(
              verAlign: 1,
              msg: index,
              bold: true,
              fontSize: index.length < 7 ? fontSize + 1 : fontSize - 1,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () async {
              if (!opt) {
                return;
              }
              //터치해서 값을 입력 받을 거다.
              //입력은 alert 창에서 받자/
              if (date) {
                DateTime newdate =
                    await pickDateUsingDialog(context, onlyDay(DateTime.now()));
                changeValue(onlyDay(newdate));
                return;
              }
              double? newValue = await doubleValueAlertManager(
                  ref, index, metric, value, min, max);
              changeValue(newValue);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: const BorderRadius.all(Radius.circular(5))),
              width: midWidth,
              height: smallHeight,
              child: WidgetCustomTextBox(
                fontAlign: 2,
                verAlign: 1,
                msg: value == null ? "-" : value.toString(),
                fontSize:
                    value.toString().length > 6 ? fontSize / 1.5 : fontSize,
              ),
            ),
          ),
          SizedBox(
            height: smallHeight,
            width: rightWidth,
            child: WidgetCustomTextBox(
              fontAlign: 0,
              verAlign: 2,
              msg: '  $metric',
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
