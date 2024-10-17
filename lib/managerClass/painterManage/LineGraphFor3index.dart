import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../common/basicMethod.dart';
import '../../common/const/colors.dart';


class LineGraphFor3Index extends CustomPainter {
  final List<dynamic> heightList;
  final List<dynamic> weightList;
  final List<dynamic> fatList;
  final List<dynamic> muscleList;
  final double canvasHeight;
  final double widthInteval;

  LineGraphFor3Index({
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


    double maxWeight = 120;
    double maxBMI = 45;
    double maxFat = 60;
    double maxMuscle = 60;

    List<Offset?> weightPoints = [];
    List<Offset?> bmiPoints = [];
    List<Offset?> fatPoints = [];
    List<Offset?> musclePoints = [];
    double x = widthInteval;
    for (int i = 0; i < weightList.length; i++) {
      double? offWeight = calcHeightValue(weightList[i], maxWeight);
      double? offFat = calcHeightValue(fatList[i], maxFat);
      double? offMuscle =calcHeightValue(muscleList[i], maxMuscle);
      double? offBmi= calcHeightValue( calcBMI(heightList[i], weightList[i])  , maxBMI);
      weightPoints.add(offWeight != null ? Offset(x * i, offWeight) : null);
      fatPoints.add(offFat !=null?  Offset(x*i, offFat) : null);
      musclePoints.add(offMuscle !=null?  Offset(x*i, offMuscle) : null);
      bmiPoints.add(offBmi !=null?  Offset(x*i, offBmi) : null);
    }
    drawPoints(weightPoints, weightList,canvas, weightPaint);
    drawPoints(bmiPoints,[] ,canvas, bmiPaint);
    drawPoints(fatPoints,fatList ,canvas, fatPaint);
    drawPoints(musclePoints, muscleList,canvas, musclePaint);
  } // end main painter

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

// 그림그리기위해 필요한 함수들
  ///실제 높이값을 계산하는 함수
  ///min 과 max를 지정해서, 작은 박스 안에서도 유의미하게 표시 될 수 있음.
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
  drawPoints(List<Offset?> points, List<dynamic> valuList,Canvas canvas, Paint paint) {
    List<Offset> validPoints = points.where((point) => point != null).cast<Offset>().toList();
      if (validPoints.length >= 2) {
    canvas.drawPoints(PointMode.polygon, validPoints, paint);
    canvas.drawPoints(PointMode.points, validPoints, paint..strokeWidth=6 );

  }else{
    canvas.drawPoints(PointMode.points, validPoints, paint);
  }

  }
}
