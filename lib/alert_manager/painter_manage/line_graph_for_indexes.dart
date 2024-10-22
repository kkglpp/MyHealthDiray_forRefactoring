import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../common/const/basic_method.dart';
import '../../common/const/colors.dart';

// HealthIndexRec 카드에 그림을 그리기 위한 Class.
class LineGraphForIndexes extends CustomPainter {
  /// 신장 (cm) 값을 List로 넘겨받는다
  final List<dynamic> heightList;

  /// 체중 값을 List로 넘겨받는다
  final List<dynamic> weightList;

  /// 체지방율 값을 List로 넘겨받는다
  final List<dynamic> fatList;

  /// 골격근량 값을 List로 넘겨받는다
  final List<dynamic> muscleList;

  /// 그림이 그려질 배경의 크기를 넘겨받는다.
  /// paint 내 size 활용시 오류가 잘난다. 공부 필요
  final double canvasHeight;
  final double widthInteval;

  LineGraphForIndexes({
    super.repaint,
    required this.heightList,
    required this.weightList,
    required this.fatList,
    required this.muscleList,
    required this.canvasHeight,
    required this.widthInteval,
  });

  @override
  void paint(Canvas canvas, Size size) {
    //각 HealthIndex마다 그려지는 선을 다르게 설정한다.
    final weightPaint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = weightColor;
    final bmiPaint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = bmiColor;
    final fatPaint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = fatColor;
    final musclePaint = Paint()
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke
      ..color = muscleColor;

    // 각 값의 최대값을 설정해둔다.
    // 각 값의 최대값을 넘으면 그냥 최대값과 동일하게 취급한다.
    double maxWeight = 120;
    double maxBMI = 45;
    double maxFat = 60;
    double maxMuscle = 60;

    //각 포인트들을 offset 리스트로 만들어야한다.
    // 그러기 위한 사전 그릇
    List<Offset?> weightPoints = [];
    List<Offset?> bmiPoints = [];
    List<Offset?> fatPoints = [];
    List<Offset?> musclePoints = [];
    double x = widthInteval;

    //offset List 로 만든다.
    //체중과 신장은 필수 입력으로 만들었지만, 체지방율, 근육량은 선택사항이기에 조금 복잡하다.
    for (int i = 0; i < weightList.length; i++) {
      // 일단 각 리스트마다 높이 값을 만든다.
      //사용된 메소드에서 null은 null로 뱉어준다.
      double? offWeight = calcHeightValue(weightList[i], maxWeight);
      double? offFat = calcHeightValue(fatList[i], maxFat);
      double? offMuscle = calcHeightValue(muscleList[i], maxMuscle);
      double? offBmi =
          calcHeightValue(calcBMI(heightList[i], weightList[i]), maxBMI);

      // 위에서 만든 offset 값을 리스트에 추가한다.
      weightPoints.add(offWeight != null ? Offset(x * i, offWeight) : null);
      fatPoints.add(offFat != null ? Offset(x * i, offFat) : null);
      musclePoints.add(offMuscle != null ? Offset(x * i, offMuscle) : null);
      bmiPoints.add(offBmi != null ? Offset(x * i, offBmi) : null);
    }
    // offset 리스트 만들기 끝.

    //기본 옵션으로 그리기에는 null 값도 있고, offset 리스트도  한번더 손봐야되니
    // 그냥 반복문 함수 만들어서 끝냈다. 복잡한 그림도 아니고 ㅡ.ㅡ;
    drawPoints(weightPoints, weightList, canvas, weightPaint);
    drawPoints(bmiPoints, [], canvas, bmiPaint);
    drawPoints(fatPoints, fatList, canvas, fatPaint);
    drawPoints(musclePoints, muscleList, canvas, musclePaint);
  } // end main painter

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  // 그림그리기위해 필요한 함수들
  ///실제 높이값을 계산하는 함수
  ///min 과 max를 지정해서, 작은 박스 안에서도 유의미하게 표시 될 수 있다.
  calcHeightValue(double? value, double maxValue) {
    double? rs;
    if (value == null) {
      rs = null;
    }
    if (value != null) {
      double temp = (value / maxValue).clamp(0, 1);
      double temp2 = 1 - temp;
      rs = temp2 * canvasHeight;
    }
    return rs;
  }

  ///value들의 상태에 따라case에 따라 그림을 다르게 그림.
  drawPoints(List<Offset?> points, List<dynamic> valuList, Canvas canvas,
      Paint paint) {
    List<Offset> validPoints =
        points.where((point) => point != null).cast<Offset>().toList();
    if (validPoints.length >= 2) {
      canvas.drawPoints(PointMode.polygon, validPoints, paint);
      canvas.drawPoints(PointMode.points, validPoints, paint..strokeWidth = 6);
    } else {
      canvas.drawPoints(PointMode.points, validPoints, paint);
    }
  }
}
