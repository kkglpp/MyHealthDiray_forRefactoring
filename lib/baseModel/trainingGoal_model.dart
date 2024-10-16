// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TrainingGoalModel {
  final int? tg_id; // 수정: tg_id로 이름 변경
  final int tg_s_id; // 수정: tg_s_id로 이름 변경
  final double tg_goal1; // 수정: tg_goal1로 이름 변경
  final double tg_goal2; // 수정: tg_goal2로 이름 변경
  final String tg_duedate; // 수정: tg_duedate로 이름 변경
  final String tg_insertdate; // 수정: tg_insertdate로 이름 변경
  final int tg_success; // 수정: tg_success로 이름 변경
  final String tg_successdate; // 수정: tg_successdate로 이름 변경
  final int tg_priority; // 수정: tg_priority로 이름 변경

  TrainingGoalModel({
    required this.tg_id,
    required this.tg_s_id,
    required this.tg_goal1,
    required this.tg_goal2,
    required this.tg_duedate,
    required this.tg_insertdate,
    required this.tg_success,
    required this.tg_successdate,
    required this.tg_priority,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tg_id': tg_id,
      'tg_s_id': tg_s_id,
      'tg_goal1': tg_goal1,
      'tg_goal2': tg_goal2,
      'tg_duedate': tg_duedate,
      'tg_insertdate': tg_insertdate,
      'tg_success': tg_success,
      'tg_successdate': tg_successdate,
      'tg_priority': tg_priority,
    };
  }

  factory TrainingGoalModel.fromMap(Map<String, dynamic> map) {
    return TrainingGoalModel(
      tg_id: map['tg_id'] != null ? map['tg_id'] as int : null,
      tg_s_id: map['tg_s_id'] as int,
      tg_goal1: map['tg_goal1'] as double,
      tg_goal2: map['tg_goal2'] as double,
      tg_duedate: map['tg_duedate'] as String,
      tg_insertdate: map['tg_insertdate'] as String,
      tg_success: map['tg_success'] as int,
      tg_successdate: map['tg_successdate'] as String,
      tg_priority: map['tg_priority'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingGoalModel.fromJson(String source) =>
      TrainingGoalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // copyWith 메소드 추가
  TrainingGoalModel copyWith({
    int? tg_id,
    int? tg_s_id,
    double? tg_goal1,
    double? tg_goal2,
    String? tg_duedate,
    String? tg_insertdate,
    int? tg_success,
    String? tg_successdate,
    int? tg_priority,
  }) {
    return TrainingGoalModel(
      tg_id: tg_id ?? this.tg_id,
      tg_s_id: tg_s_id ?? this.tg_s_id,
      tg_goal1: tg_goal1 ?? this.tg_goal1,
      tg_goal2: tg_goal2 ?? this.tg_goal2,
      tg_duedate: tg_duedate ?? this.tg_duedate,
      tg_insertdate: tg_insertdate ?? this.tg_insertdate,
      tg_success: tg_success ?? this.tg_success,
      tg_successdate: tg_successdate ?? this.tg_successdate,
      tg_priority: tg_priority ?? this.tg_priority,
    );
  }
}