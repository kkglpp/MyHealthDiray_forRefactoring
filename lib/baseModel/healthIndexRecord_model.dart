// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HealthIndexRecordModel {
  final int? hr_id;
  final double hr_height;
  final double hr_weight;
  final double? hr_fat;
  final double? hr_muscle;
  final String?
      hr_img; //UNIT8LIST를 base64로 ENCODE 해서 오고가자. why? JSON Serialization 하고싶어서.
  final String hr_insertdate;

  HealthIndexRecordModel({
    required this.hr_id,
    required this.hr_height,
    required this.hr_weight,
    required this.hr_fat,
    required this.hr_muscle,
    required this.hr_img,
    required this.hr_insertdate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': hr_id,
      'height': hr_height,
      'weight': hr_weight,
      'fat': hr_fat,
      'muscle': hr_muscle,
      'imgBase64': hr_img,
      'insertdate': hr_insertdate,
    };
  }

  factory HealthIndexRecordModel.fromMap(Map<String, dynamic> map) {
    return HealthIndexRecordModel(
      hr_id: map['id'] != null ? map['id'] as int : null,
      hr_height: map['height'] as double,
      hr_weight: map['weight'] as double,
      hr_fat: map['fat'] != null ? map['fat'] as double : null,
      hr_muscle: map['muscle'] != null ? map['muscle'] as double : null,
      hr_img: map['imgBase64'] != null ? map['imgBase64'] as String : null,
      hr_insertdate: map['insertdate'] as String,
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
      hr_id: id ?? this.hr_id,
      hr_height: height ?? this.hr_height,
      hr_weight: weight ?? this.hr_weight,
      hr_fat: fat ?? this.hr_fat,
      hr_muscle: muscle ?? this.hr_muscle,
      hr_img: imgBase64 ?? this.hr_img,
      hr_insertdate: insertdate ?? this.hr_insertdate,
    );
  }          
}
