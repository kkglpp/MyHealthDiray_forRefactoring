// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

 /* ---------Plnamodel1  :   TrainingPlan  테이블에 있는 그대로 오고가는 모델------------------ */

//운동 계획을 위한 모델 
class TrainingPlanModel {
  final int? tp_id;
  final String tp_title;
  final int tp_s_id;
  final int tp_set;
  final double tp_rec1;
  final double tp_rec2;
  final String tp_traindate;
  final int tp_done;

  TrainingPlanModel({required this.tp_id, required this.tp_title, required this.tp_s_id, required this.tp_set, required this.tp_rec1, required this.tp_rec2, required this.tp_traindate, required this.tp_done});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tp_id': tp_id,
      'tp_title': tp_title,
      'tp_s_id': tp_s_id,
      'tp_set': tp_set,
      'tp_rec1': tp_rec1,
      'tp_rec2': tp_rec2,
      'tp_traindate': tp_traindate,
      'tp_done': tp_done,
    };
  }

  factory TrainingPlanModel.fromMap(Map<String, dynamic> map) {
    return TrainingPlanModel(
      tp_id: map['tp_id'] != null ? map['tp_id'] as int : null,
      tp_title: map['tp_title'] as String,
      tp_s_id: map['tp_s_id'] as int,
      tp_set: map['tp_set'] as int,
      tp_rec1: map['tp_rec1'] as double,
      tp_rec2: map['tp_rec2'] as double,
      tp_traindate: map['tp_traindate'] as String,
      tp_done: map['tp_done'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingPlanModel.fromJson(String source) => TrainingPlanModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TrainingPlanModel copyWith({
    int? tp_id,
    String? tp_title,
    int? tp_s_id,
    int? tp_set,
    double? tp_rec1,
    double? tp_rec2,
    String? tp_traindate,
    int? tp_done,
  }) {
    return TrainingPlanModel(
      tp_id: tp_id ?? this.tp_id,
      tp_title: tp_title ?? this.tp_title,
      tp_s_id: tp_s_id ?? this.tp_s_id,
      tp_set: tp_set ?? this.tp_set,
      tp_rec1: tp_rec1 ?? this.tp_rec1,
      tp_rec2: tp_rec2 ?? this.tp_rec2,
      tp_traindate: tp_traindate ?? this.tp_traindate,
      tp_done: tp_done ?? this.tp_done,
    );
  }
} // end TrainingPlanModel



 /* ---------Plnamodel2  :  해당 날짜 / title에 해당하는 운동들을 보기 위한 model.    ------------------ */
/* Table에 입력할 일은 없다. */
class PlanListOfPlanSet {
    final String tp_title;
    final int tp_s_id;
    final String tp_traindate;
    final int? total_count;
    final int? done_count;

  PlanListOfPlanSet({required this.tp_title, required this.tp_s_id, required this.tp_traindate, required this.total_count, required this.done_count});


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tp_title': tp_title,
      'tp_s_id': tp_s_id,
      'tp_traindate': tp_traindate,
      'total_count': total_count,
      'done_count': done_count,
    };
  }

  factory PlanListOfPlanSet.fromMap(Map<String, dynamic> map) {
    return PlanListOfPlanSet(
      tp_title: map['tp_title'] as String,
      tp_s_id: map['tp_s_id'] as int,
      tp_traindate: map['tp_traindate'] as String,
      total_count: map['total_count'] != null ? map['total_count'] as int : null,
      done_count: map['done_count'] != null ? map['done_count'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlanListOfPlanSet.fromJson(String source) => PlanListOfPlanSet.fromMap(json.decode(source) as Map<String, dynamic>);

  PlanListOfPlanSet copyWith({
    String? tp_title,
    int? tp_s_id,
    String? tp_traindate,
    int? total_count,
    int? done_count,
  }) {
    return PlanListOfPlanSet(
      tp_title: tp_title ?? this.tp_title,
      tp_s_id: tp_s_id ?? this.tp_s_id,
      tp_traindate: tp_traindate ?? this.tp_traindate,
      total_count: total_count ?? this.total_count,
      done_count: done_count ?? this.done_count,
    );
  }
  }





 /* ---------Plnamodel3  :   Training Plan을  달력에  표시할 목록의 형태------------------ */
class PlanListModel {
  final String tp_title;
  final String tp_traindate;

  PlanListModel({required this.tp_title, required this.tp_traindate});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tp_title': tp_title,
      'tp_traindate': tp_traindate,
    };
  }

  factory PlanListModel.fromMap(Map<String, dynamic> map) {
    return PlanListModel(
      tp_title: map['tp_title'] as String,
      tp_traindate: map['tp_traindate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlanListModel.fromJson(String source) => PlanListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  PlanListModel copyWith({
    String? tp_title,
    String? tp_traindate,
  }) {
    return PlanListModel(
      tp_title: tp_title ?? this.tp_title,
      tp_traindate: tp_traindate ?? this.tp_traindate,
    );
  }
}//end PlanListModel

