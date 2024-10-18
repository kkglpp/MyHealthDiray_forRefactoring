import 'dart:convert';

class TrainingGoalModel {
  final int? tgId;
  final int tgSId;
  final double tgGoal1;
  final double tgGoal2;
  final String tgDueDate;
  final String tgInsertDate;
  final int tgSuccess;
  final String tgSuccessDate;
  final int tgPriority;

  TrainingGoalModel({
    required this.tgId,
    required this.tgSId,
    required this.tgGoal1,
    required this.tgGoal2,
    required this.tgDueDate,
    required this.tgInsertDate,
    required this.tgSuccess,
    required this.tgSuccessDate,
    required this.tgPriority,
  });

  Map<String, dynamic> toMap() {
    return {
      'tg_id': tgId,
      'tg_s_id': tgSId,
      'tg_goal1': tgGoal1,
      'tg_goal2': tgGoal2,
      'tg_duedate': tgDueDate,
      'tg_insertdate': tgInsertDate,
      'tg_success': tgSuccess,
      'tg_successdate': tgSuccessDate,
      'tg_priority': tgPriority,
    };
  }

  factory TrainingGoalModel.fromMap(Map<String, dynamic> map) {
    return TrainingGoalModel(
      tgId: map['tg_id'] != null ? map['tg_id'] as int : null,
      tgSId: map['tg_s_id'] as int,
      tgGoal1: map['tg_goal1'] as double,
      tgGoal2: map['tg_goal2'] as double,
      tgDueDate: map['tg_duedate'] as String,
      tgInsertDate: map['tg_insertdate'] as String,
      tgSuccess: map['tg_success'] as int,
      tgSuccessDate: map['tg_successdate'] as String,
      tgPriority: map['tg_priority'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingGoalModel.fromJson(String source) =>
      TrainingGoalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TrainingGoalModel copyWith({
    int? tgId,
    int? tgSId,
    double? tgGoal1,
    double? tgGoal2,
    String? tgDueDate,
    String? tgInsertDate,
    int? tgSuccess,
    String? tgSuccessDate,
    int? tgPriority,
  }) {
    return TrainingGoalModel(
      tgId: tgId ?? this.tgId,
      tgSId: tgSId ?? this.tgSId,
      tgGoal1: tgGoal1 ?? this.tgGoal1,
      tgGoal2: tgGoal2 ?? this.tgGoal2,
      tgDueDate: tgDueDate ?? this.tgDueDate,
      tgInsertDate: tgInsertDate ?? this.tgInsertDate,
      tgSuccess: tgSuccess ?? this.tgSuccess,
      tgSuccessDate: tgSuccessDate ?? this.tgSuccessDate,
      tgPriority: tgPriority ?? this.tgPriority,
    );
  }
}