
import 'dart:convert';
import 'dart:typed_data';
import 'package:intl/intl.dart';

/* 기타 필요한 함수 */
// 객체를 Map으로 바꿔서, 이 함수에 넣으면 List로 자동으로 바꿔준다.
// model에서는 이미지를 base64 의 문자열로 받는다. 이를 UNIT8List로 바꿔야 한다.


List<dynamic> modelToList(Map<String, dynamic> map) {
  return map.values.map(
    (value) {
      if (value is String && value.length > 100 && isBase64(value)) {
        return base64Decode(value);
      }
      return value;
    },
  ).toList();
}

//값이 Base64 문자열인지 확인하는 함수
bool isBase64(String value) {
  final RegExp base64RegExp = RegExp(r'^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?$');
  return base64RegExp.hasMatch(value);
}

//이미지를 Bas64로 저장하면 나중에 online 서비스로 바꿀 때 편할거라 생각

//Sqlite 쓸때 이미지를 String으로 바꿔서 저장하기위함
String u8toBase64(Uint8List value) {
  return base64Encode(value);
}
//저장된 base64를 Unit8List
Uint8List base64ToU8List(String value) {
  return base64Decode(value);
}

String onlyDay(DateTime datetime) {
  return DateFormat('yyyy-MM-dd').format(datetime);
}

double calcBMI(double height, double weight) {
  return ((weight / ((height / 100) * (height / 100))) * 10).roundToDouble() /
      10;
}

double roundMethod(double num) {
  return (((num * 10).round()) / 10);
}
