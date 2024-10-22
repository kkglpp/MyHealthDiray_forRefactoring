import 'dart:convert';

class SportModel {
  final int? sportId;
  final String sportName;
  final String sportMetric1;
  final String sportMetric2;
  final String sportDescription;
  final int sportDel;

  SportModel({
    required this.sportId,
    required this.sportName,
    required this.sportMetric1,
    required this.sportMetric2,
    required this.sportDescription,
    required this.sportDel,
  });

  SportModel copyWith({
    int? sportId,
    String? sportName,
    String? sportMetric1,
    String? sportMetric2,
    String? sportDescription,
    int? sportDel,
  }) {
    return SportModel(
      sportId: sportId ?? this.sportId,
      sportName: sportName ?? this.sportName,
      sportMetric1: sportMetric1 ?? this.sportMetric1,
      sportMetric2: sportMetric2 ?? this.sportMetric2,
      sportDescription: sportDescription ?? this.sportDescription,
      sportDel: sportDel ?? this.sportDel,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sport_id': sportId,
      'sport_name': sportName,
      'sport_metric1': sportMetric1,
      'sport_metric2': sportMetric2,
      'sport_description': sportDescription,
      'sport_del': sportDel,
    };
  }

  factory SportModel.fromMap(Map<String, dynamic> map) {
    return SportModel(
      sportId: map['sport_id'] != null ? map['sport_id'] as int : null,
      sportName: map['sport_name'] as String,
      sportMetric1: map['sport_metric1'] as String,
      sportMetric2: map['sport_metric2'] as String,
      sportDescription: map['sport_description'] as String,
      sportDel: map['sport_del'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory SportModel.fromJson(String source) =>
      SportModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
