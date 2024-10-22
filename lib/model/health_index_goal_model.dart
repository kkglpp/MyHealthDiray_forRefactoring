// ignore_for_file: public_member_api_docs, sort_constructors_first
// 운동 수행 능력 목표 데이터를 위한 모델
import 'dart:convert';

class HealthIndexGoalModel {
  final int? hgId;
  final double hgHeight;
  final double hgWeight;
  final double? hgFat;
  final double? hgMuscle;
  final String? hgImg;
  final String hgDuedate;
  final int hgSuccess;
  final String? hgSuccessdate;
  final int hgPriority;

  HealthIndexGoalModel({
    required this.hgId,
    required this.hgHeight,
    required this.hgWeight,
    required this.hgFat,
    required this.hgMuscle,
    required this.hgImg,
    required this.hgDuedate,
    required this.hgSuccess,
    required this.hgSuccessdate,
    required this.hgPriority,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'hg_id': hgId,
      'hg_height': hgHeight,
      'hg_weight': hgWeight,
      'hg_fat': hgFat,
      'hg_muscle': hgMuscle,
      'hg_img': hgImg,
      'hg_duedate': hgDuedate,
      'hg_success': hgSuccess,
      'hg_successdate': hgSuccessdate,
      'hg_priority': hgPriority,
    };
  }

  factory HealthIndexGoalModel.fromMap(Map<String, dynamic> map) {
    return HealthIndexGoalModel(
      hgId: map['hg_id'] != null ? map['hg_id'] as int : null,
      hgHeight: map['hg_height'] as double,
      hgWeight: map['hg_weight'] as double,
      hgFat: map['hg_fat'] != null ? map['hg_fat'] as double : null,
      hgMuscle: map['hg_muscle'] != null ? map['hg_muscle'] as double : null,
      hgImg: map['hg_img'] != null ? map['hg_img'] as String : null,
      hgDuedate: map['hg_duedate'] as String,
      hgSuccess: map['hg_success'] as int,
      hgSuccessdate: map['hg_successdate'] != null ? map['hg_successdate'] as String : null,
      hgPriority: map['hg_priority'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory HealthIndexGoalModel.fromJson(String source) => HealthIndexGoalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  HealthIndexGoalModel copyWith({
    int? hgId,
    double? hgHeight,
    double? hgWeight,
    double? hgFat,
    double? hgMuscle,
    String? hgImg,
    String? hgDuedate,
    int? hgSuccess,
    String? hgSuccessdate,
    int? hgPriority,
  }) {
    return HealthIndexGoalModel(
      hgId: hgId ?? this.hgId,
      hgHeight: hgHeight ?? this.hgHeight,
      hgWeight: hgWeight ?? this.hgWeight,
      hgFat: hgFat ?? this.hgFat,
      hgMuscle: hgMuscle ?? this.hgMuscle,
      hgImg: hgImg ?? this.hgImg,
      hgDuedate: hgDuedate ?? this.hgDuedate,
      hgSuccess: hgSuccess ?? this.hgSuccess,
      hgSuccessdate: hgSuccessdate ?? this.hgSuccessdate,
      hgPriority: hgPriority ?? this.hgPriority,
    );
  }
}