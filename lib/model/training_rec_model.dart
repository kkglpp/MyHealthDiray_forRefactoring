import 'dart:convert';

class TrainingRecModel {
  final int? id;
  final String title;
  final int sId;
  final int set;
  final double rec1;
  final double rec2;
  final String trainDate;

  TrainingRecModel({
    this.id = 0,
    required this.title,
    required this.sId,
    required this.set,
    required this.rec1,
    required this.rec2,
    required this.trainDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'tr_id': id,
      'tr_title': title,
      'tr_s_id': sId,
      'tr_set': set,
      'tr_rec1': rec1,
      'tr_rec2': rec2,
      'tr_traindate': trainDate,
    };
  }

  factory TrainingRecModel.fromMap(Map<String, dynamic> map) {
    return TrainingRecModel(
      id: map['tr_id'] != null ? map['tr_id'] as int : null,
      title: map['tr_title'] as String,
      sId: map['tr_s_id'] as int,
      set: map['tr_set'] as int,
      rec1: map['tr_rec1'] as double,
      rec2: map['tr_rec2'] as double,
      trainDate: map['tr_traindate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TrainingRecModel.fromJson(String source) =>
      TrainingRecModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TrainingRecModel copyWith({
    int? id,
    String? title,
    int? sId,
    int? set,
    double? rec1,
    double? rec2,
    String? trainDate,
  }) {
    return TrainingRecModel(
      id: id ?? this.id,
      title: title ?? this.title,
      sId: sId ?? this.sId,
      set: set ?? this.set,
      rec1: rec1 ?? this.rec1,
      rec2: rec2 ?? this.rec2,
      trainDate: trainDate ?? this.trainDate,
    );
  }
}
