// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HealthIndexRecordModel {
  final int? hrId; 
  final double hrHeight; 
  final double hrWeight; 
  final double? hrFat; 
  final double? hrMuscle; 
  final String? hrImg; 
  final String hrInsertDate; 

  HealthIndexRecordModel({
    required this.hrId,
    required this.hrHeight,
    required this.hrWeight,
    required this.hrFat,
    required this.hrMuscle,
    required this.hrImg,
    required this.hrInsertDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': hrId,
      'height': hrHeight,
      'weight': hrWeight,
      'fat': hrFat,
      'muscle': hrMuscle,
      'imgBase64': hrImg,
      'insertdate': hrInsertDate,
    };
  }

  factory HealthIndexRecordModel.fromMap(Map<String, dynamic> map) {
    return HealthIndexRecordModel(
      hrId: map['id'] != null ? map['id'] as int : null,
      hrHeight: map['height'] as double,
      hrWeight: map['weight'] as double,
      hrFat: map['fat'] != null ? map['fat'] as double : null,
      hrMuscle: map['muscle'] != null ? map['muscle'] as double : null,
      hrImg: map['imgBase64'] != null ? map['imgBase64'] as String : null,
      hrInsertDate: map['insertdate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HealthIndexRecordModel.fromJson(String source) =>
      HealthIndexRecordModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  HealthIndexRecordModel copyWith({
    int? id,
    double? height,
    double? weight,
    double? fat,
    double? muscle,
    String? imgBase64,
    String? insertdate,
  }) {
    return HealthIndexRecordModel(
      hrId: id ?? hrId,
      hrHeight: height ?? hrHeight,
      hrWeight: weight ?? hrWeight,
      hrFat: fat ?? hrFat,
      hrMuscle: muscle ?? hrMuscle,
      hrImg: imgBase64 ?? hrImg,
      hrInsertDate: insertdate ?? hrInsertDate,
    );
  }          
}