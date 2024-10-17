import 'dart:convert';

class TrainingGoalModel {
  final int? id;
  final int sId;
  final double goal1;
  final double goal2;
  final String dueDate;
  final String insertDate;
  final int success;
  final String successDate;
  final int priority;

  TrainingGoalModel({
    required this.id,
    required this.sId,
    required this.goal1,
    required this.goal2,
    required this.dueDate,
    required this.insertDate,
    required this.success,
    required this.successDate,
    required this.priority,
  });

  Map<String, dynamic> toMap() {
    return {
      'tg_id': id,
      'tg_s_id': sId,
      'tg_goal1': goal1,
      'tg_goal2': goal2,
      'tg_duedate': dueDate,
      'tg_insertdate': insertDate,
      'tg_success': success,
      'tg_successdate': successDate,
      'tg_priority': priority,
    };
  }

  factory TrainingGoalModel.fromMap(Map<String, dynamic> map) {
    return TrainingGoalModel(
      id: map['tg_id'] != null ? map['tg_id'] as int : null,
      sId: map['tg_s_id'] as int,
      goal1: map['tg_goal1'] as double,
      goal2: map['tg_goal2'] as double,
      dueDate: map['tg_duedate'] as String,
      insertDate: map['tg_insertdate'] as String,
      success: map['tg_success'] as int,
      successDate: map['tg_successdate'] as String,
      priority: map['tg_priority'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingGoalModel.fromJson(String source) =>
      TrainingGoalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TrainingGoalModel copyWith({
    int? id,
    int? sId,
    double? goal1,
    double? goal2,
    String? dueDate,
    String? insertDate,
    int? success,
    String? successDate,
    int? priority,
  }) {
    return TrainingGoalModel(
      id: id ?? this.id,
      sId: sId ?? this.sId,
      goal1: goal1 ?? this.goal1,
      goal2: goal2 ?? this.goal2,
      dueDate: dueDate ?? this.dueDate,
      insertDate: insertDate ?? this.insertDate,
      success: success ?? this.success,
      successDate: successDate ?? this.successDate,
      priority: priority ?? this.priority,
    );
  }
}
