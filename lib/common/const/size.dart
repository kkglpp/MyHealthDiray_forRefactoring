import 'package:flutter/material.dart';
/*
****************************************** 
요소들의 Size 들을 계산 하는 함수 모음   
******************************************
 */


  ///fontSize를 0~5까지 5단계로 나누어서 계산.
  ///해당 사이즈는 기종의 넓이와 높이값을 가지고 계산할건데 일단 넓이만 가지고 계산
  double fontSize(BuildContext context, int sizeOpt) {
    /* 
    일단 넓이를 60으로 나눈다.
    360 넓이 기준으로 일단 6을 기본 인수로 설정
    tablet pro 의 경우 1204 or 1366 이다.
    1024 -> 17이 기본인수
    1366 ->24가 기본인수이다.
    거기에 화면 비율도 기형적인 기종이 있다. flipPhone
    따라서 인자 두번째로 가로 세로 비율을 반영한다.
    사이즈 옵션 단계마다 기본 인수의 25%씩 크기를 향상시킨다.
    6:  7.5-> 9 -> 10.5 ->12 -> 13.5->15
    가로가 지나치게 크게 잡히는 경우 (가로 비율이 세로의 70%%가 넘을 경우)
    70%만 적용한다
    1024원본: 17  ->  25 -> 29 ->33->37->41
    1024반영: 11 ->
    가로비율이 세로비율의 50%가 안되는경우 -> 글자 크기는 상관 없는데, 문제는 글자가 담기는 그릇의 크기가 문제가 되겠다. 개꿀잼이다.
    */

    double width = MediaQuery.of(context).size.width;
    double height= MediaQuery.of(context).size.height;

    double var01 = (5+sizeOpt)/4;
    double var02 = width>height*0.7 ? 0.7 :1;

    return ((width / 60) * var01*var02); //9 ~
  } //end calc

  double boxheightSize(double size){

    //일단 안쓸건데, 나중에 분명히 다 적용하고 싶어질거야. 그러니까 미리 만들어서 적용해두자.
    return size;

  }