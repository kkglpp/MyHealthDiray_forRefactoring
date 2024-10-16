// ignore_for_file: public_member_api_docs, sort_constructors_first
// 운동 수행 능력 목표 데이터를 위한 모델
import 'dart:convert';

class HealthIndexGoalModel {
  int? id;
  double height;
  double weight;
  double? fat;
  double? muscle;
  String?
      imgBase64; //UNIT8LIST를 base64로 ENCODE 해서 오고가자. why? JSON Serialization 하고싶어서.
  String duedate;
  int success;
  String? successdate;
  int priority;

  HealthIndexGoalModel({
    required this.id,
    required this.height,
    required this.weight,
    required this.fat,
    required this.muscle,
    required this.imgBase64,
    required this.duedate,
    required this.success,
    required this.successdate,
    required this.priority,
  });

  // copyWith 메서드
  HealthIndexGoalModel copyWith({
    int? id,
    double? height,
    double? weight,
    double? fat,
    double? muscle,
    String? imgBase64,
    String? duedate,
    int? success,
    String? successdate,
    int? priority,
  }) {
    return HealthIndexGoalModel(
      id: id ?? this.id,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      fat: fat ?? this.fat,
      muscle: muscle ?? this.muscle,
      imgBase64: imgBase64 ?? this.imgBase64,
      duedate: duedate ?? this.duedate,
      success: success ?? this.success,
      successdate: successdate ?? this.successdate,
      priority: priority ?? this.priority,
    );
  }


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'height': height,
      'weight': weight,
      'fat': fat,
      'muscle': muscle,
      'imgBase64': imgBase64,
      'duedate': duedate,
      'success': success,
      'successdate': successdate,
      'priority': priority,
    };
  }

  factory HealthIndexGoalModel.fromMap(Map<String, dynamic> map) {
    return HealthIndexGoalModel(
      id: map['id'] != null ? map['id'] as int : null,
      height: map['height'] as double,
      weight: map['weight'] as double,
      fat: map['fat'] != null ? map['fat'] as double : null,
      muscle: map['muscle'] != null ? map['muscle'] as double : null,
      imgBase64: map['imgBase64'] != null ? map['imgBase64'] as String : null,
      duedate: map['duedate'] as String,
      success: map['success'] as int,
      successdate:
          map['successdate'] != null ? map['successdate'] as String : null,
      priority: map['priority'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory HealthIndexGoalModel.fromJson(String source) =>
      HealthIndexGoalModel.fromMap(json.decode(source) as Map<String, dynamic>);


      
}
