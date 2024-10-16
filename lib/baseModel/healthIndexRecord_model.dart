// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HealthIndexRecordModel {
  final int? id;
  final double height;
  final double weight;
  final double? fat;
  final double? muscle;
  final String?
      imgBase64; //UNIT8LIST를 base64로 ENCODE 해서 오고가자. why? JSON Serialization 하고싶어서.
  final String insertdate;

  HealthIndexRecordModel({
    required this.id,
    required this.height,
    required this.weight,
    required this.fat,
    required this.muscle,
    required this.imgBase64,
    required this.insertdate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'height': height,
      'weight': weight,
      'fat': fat,
      'muscle': muscle,
      'imgBase64': imgBase64,
      'insertdate': insertdate,
    };
  }

  factory HealthIndexRecordModel.fromMap(Map<String, dynamic> map) {
    return HealthIndexRecordModel(
      id: map['id'] != null ? map['id'] as int : null,
      height: map['height'] as double,
      weight: map['weight'] as double,
      fat: map['fat'] != null ? map['fat'] as double : null,
      muscle: map['muscle'] != null ? map['muscle'] as double : null,
      imgBase64: map['imgBase64'] != null ? map['imgBase64'] as String : null,
      insertdate: map['insertdate'] as String,
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
      id: id ?? this.id,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      fat: fat ?? this.fat,
      muscle: muscle ?? this.muscle,
      imgBase64: imgBase64 ?? this.imgBase64,
      insertdate: insertdate ?? this.insertdate,
    );
  }          
}
