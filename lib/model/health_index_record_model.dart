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
      'hr_id': hrId,
      'hr_height': hrHeight,
      'hr_weight': hrWeight,
      'hr_fat': hrFat,
      'hr_muscle': hrMuscle,
      'hr_img': hrImg,
      'hr_insertdate': hrInsertDate,
    };
  }

  factory HealthIndexRecordModel.fromMap(Map<String, dynamic> map) {
    return HealthIndexRecordModel(
      hrId: map['hr_id'] != null ? map['hr_id'] as int : null,
      hrHeight: map['hr_height'] as double,
      hrWeight: map['hr_weight'] as double,
      hrFat: map['hr_fat'] != null ? map['hr_fat'] as double : null,
      hrMuscle: map['hr_muscle'] != null ? map['hr_muscle'] as double : null,
      hrImg: map['hr_img'] != null ? map['hr_img'] as String : null,
      hrInsertDate: map['hr_insertdate'] as String,
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