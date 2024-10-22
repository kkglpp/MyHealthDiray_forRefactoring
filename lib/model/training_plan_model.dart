import 'dart:convert';

/* --------- TrainingPlanModel :   TrainingPlan 테이블에 있는 그대로 오고가는 모델 ------------------ */

// 운동 계획을 위한 모델
class TrainingPlanModel {
  final int? tpId;
  final String tpTitle;
  final int tpSId;
  final int tpSet;
  final double tpRec1;
  final double tpRec2;
  final String tpTrainDate;
  final int tpDone;

  TrainingPlanModel({
    required this.tpId,
    required this.tpTitle,
    required this.tpSId,
    required this.tpSet,
    required this.tpRec1,
    required this.tpRec2,
    required this.tpTrainDate,
    required this.tpDone,
  });

  Map<String, dynamic> toMap() {
    return {
      'tp_id': tpId,
      'tp_title': tpTitle,
      'tp_s_id': tpSId,
      'tp_set': tpSet,
      'tp_rec1': tpRec1,
      'tp_rec2': tpRec2,
      'tp_traindate': tpTrainDate,
      'tp_done': tpDone,
    };
  }

  factory TrainingPlanModel.fromMap(Map<String, dynamic> map) {
    return TrainingPlanModel(
      tpId: map['tp_id'] != null ? map['tp_id'] as int : null,
      tpTitle: map['tp_title'] as String,
      tpSId: map['tp_s_id'] as int,
      tpSet: map['tp_set'] as int,
      tpRec1: map['tp_rec1'] as double,
      tpRec2: map['tp_rec2'] as double,
      tpTrainDate: map['tp_traindate'] as String,
      tpDone: map['tp_done'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingPlanModel.fromJson(String source) =>
      TrainingPlanModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TrainingPlanModel copyWith({
    int? tpId,
    String? tpTitle,
    int? tpSId,
    int? tpSet,
    double? tpRec1,
    double? tpRec2,
    String? tpTrainDate,
    int? tpDone,
  }) {
    return TrainingPlanModel(
      tpId: tpId ?? this.tpId,
      tpTitle: tpTitle ?? this.tpTitle,
      tpSId: tpSId ?? this.tpSId,
      tpSet: tpSet ?? this.tpSet,
      tpRec1: tpRec1 ?? this.tpRec1,
      tpRec2: tpRec2 ?? this.tpRec2,
      tpTrainDate: tpTrainDate ?? this.tpTrainDate,
      tpDone: tpDone ?? this.tpDone,
    );
  }
} // end TrainingPlanModel

/* --------- PlanListOfPlanSet :  해당 날짜 / title에 해당하는 운동들을 보기 위한 모델 ------------------ */
/* Table에 입력할 일은 없다. */
class PlanListOfPlanSet {
  final String tpTitle;
  final int tpSId;
  final String tpTrainDate;
  final int? totalCount;
  final int? doneCount;

  PlanListOfPlanSet({
    required this.tpTitle,
    required this.tpSId,
    required this.tpTrainDate,
    required this.totalCount,
    required this.doneCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'tp_title': tpTitle,
      'tp_s_id': tpSId,
      'tp_traindate': tpTrainDate,
      'total_count': totalCount,
      'done_count': doneCount,
    };
  }

  factory PlanListOfPlanSet.fromMap(Map<String, dynamic> map) {
    return PlanListOfPlanSet(
      tpTitle: map['tp_title'] as String,
      tpSId: map['tp_s_id'] as int,
      tpTrainDate: map['tp_traindate'] as String,
      totalCount: map['total_count'] != null ? map['total_count'] as int : null,
      doneCount: map['done_count'] != null ? map['done_count'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlanListOfPlanSet.fromJson(String source) =>
      PlanListOfPlanSet.fromMap(json.decode(source) as Map<String, dynamic>);

  PlanListOfPlanSet copyWith({
    String? tpTitle,
    int? tpSId,
    String? tpTrainDate,
    int? totalCount,
    int? doneCount,
  }) {
    return PlanListOfPlanSet(
      tpTitle: tpTitle ?? this.tpTitle,
      tpSId: tpSId ?? this.tpSId,
      tpTrainDate: tpTrainDate ?? this.tpTrainDate,
      totalCount: totalCount ?? this.totalCount,
      doneCount: doneCount ?? this.doneCount,
    );
  }
}

/* --------- PlanListModel :   Training Plan을  달력에  표시할 목록의 형태 ------------------ */
class PlanListModel {
  final String tpTitle;
  final String tpTrainDate;

  PlanListModel({
    required this.tpTitle,
    required this.tpTrainDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'tp_title': tpTitle,
      'tp_traindate': tpTrainDate,
    };
  }

  factory PlanListModel.fromMap(Map<String, dynamic> map) {
    return PlanListModel(
      tpTitle: map['tp_title'] as String,
      tpTrainDate: map['tp_traindate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlanListModel.fromJson(String source) =>
      PlanListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PlanListModel copyWith({
    String? tpTitle,
    String? tpTrainDate,
  }) {
    return PlanListModel(
      tpTitle: tpTitle ?? this.tpTitle,
      tpTrainDate: tpTrainDate ?? this.tpTrainDate,
    );
  }
} // end PlanListModel
