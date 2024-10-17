// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TrainingRecModel {
  final int? tr_id;
  final String tr_title;
  final int tr_s_id;
  final int tr_set;
  final double tr_rec1;
  final double tr_rec2;
  final String tr_traindate;

  TrainingRecModel({this.tr_id=0, required this.tr_title, required this.tr_s_id, required this.tr_set, required this.tr_rec1, required this.tr_rec2, required this.tr_traindate});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tr_id': tr_id,
      'tr_title': tr_title,
      'tr_s_id': tr_s_id,
      'tr_set': tr_set,
      'tr_rec1': tr_rec1,
      'tr_rec2': tr_rec2,
      'tr_traindate': tr_traindate,
    };
  }

  factory TrainingRecModel.fromMap(Map<String, dynamic> map) {
    return TrainingRecModel(
      tr_id: map['tr_id'] != null ? map['tr_id'] as int : null,
      tr_title: map['tr_title'] as String,
      tr_s_id: map['tr_s_id'] as int,
      tr_set: map['tr_set'] as int,
      tr_rec1: map['tr_rec1'] as double,
      tr_rec2: map['tr_rec2'] as double,
      tr_traindate: map['tr_traindate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingRecModel.fromJson(String source) => TrainingRecModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TrainingRecModel copyWith({
    int? tr_id,
    String? tr_title,
    int? tr_s_id,
    int? tr_set,
    double? tr_rec1,
    double? tr_rec2,
    String? tr_traindate,
  }) {
    return TrainingRecModel(
      tr_id: tr_id ?? this.tr_id,
      tr_title: tr_title ?? this.tr_title,
      tr_s_id: tr_s_id ?? this.tr_s_id,
      tr_set: tr_set ?? this.tr_set,
      tr_rec1: tr_rec1 ?? this.tr_rec1,
      tr_rec2: tr_rec2 ?? this.tr_rec2,
      tr_traindate: tr_traindate ?? this.tr_traindate,
    );
  }
}

