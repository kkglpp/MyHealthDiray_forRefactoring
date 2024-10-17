// ignore_for_file: public_member_api_docs, sort_constructors_first
// 운동 수행 능력 목표 데이터를 위한 모델
import 'dart:convert';

class HealthIndexGoalModel {
  final int? hg_id;
  final double hg_height;
  final double hg_weight;
  final double? hg_fat;
  final double? hg_muscle;
  final String? hg_img;
  final String hg_duedate;
  final int hg_success;
  final String? hg_successdate;
  final int hg_priority;

  HealthIndexGoalModel({required this.hg_id, required this.hg_height, required this.hg_weight, required this.hg_fat, required this.hg_muscle, required this.hg_img, required this.hg_duedate, required this.hg_success, required this.hg_successdate, required this.hg_priority});


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hg_id': hg_id,
      'hg_height': hg_height,
      'hg_weight': hg_weight,
      'hg_fat': hg_fat,
      'hg_muscle': hg_muscle,
      'hg_img': hg_img,
      'hg_duedate': hg_duedate,
      'hg_success': hg_success,
      'hg_successdate': hg_successdate,
      'hg_priority': hg_priority,
    };
  }

  factory HealthIndexGoalModel.fromMap(Map<String, dynamic> map) {
    return HealthIndexGoalModel(
      hg_id: map['hg_id'] != null ? map['hg_id'] as int : null,
      hg_height: map['hg_height'] as double,
      hg_weight: map['hg_weight'] as double,
      hg_fat: map['hg_fat'] != null ? map['hg_fat'] as double : null,
      hg_muscle: map['hg_muscle'] != null ? map['hg_muscle'] as double : null,
      hg_img: map['hg_img'] != null ? map['hg_img'] as String : null,
      hg_duedate: map['hg_duedate'] as String,
      hg_success: map['hg_success'] as int,
      hg_successdate: map['hg_successdate'] != null ? map['hg_successdate'] as String : null,
      hg_priority: map['hg_priority'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory HealthIndexGoalModel.fromJson(String source) => HealthIndexGoalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  HealthIndexGoalModel copyWith({
    int? hg_id,
    double? hg_height,
    double? hg_weight,
    double? hg_fat,
    double? hg_muscle,
    String? hg_img,
    String? hg_duedate,
    int? hg_success,
    String? hg_successdate,
    int? hg_priority,
  }) {
    return HealthIndexGoalModel(
      hg_id: hg_id ?? this.hg_id,
      hg_height: hg_height ?? this.hg_height,
      hg_weight: hg_weight ?? this.hg_weight,
      hg_fat: hg_fat ?? this.hg_fat,
      hg_muscle: hg_muscle ?? this.hg_muscle,
      hg_img: hg_img ?? this.hg_img,
      hg_duedate: hg_duedate ?? this.hg_duedate,
      hg_success: hg_success ?? this.hg_success,
      hg_successdate: hg_successdate ?? this.hg_successdate,
      hg_priority: hg_priority ?? this.hg_priority,
    );
  }
}
