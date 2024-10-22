// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MappedSportModel {
  final String sportName; 
  final String metric1;
  final String metric2;

  MappedSportModel({required this.sportName, required this.metric1, required this.metric2});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sport_id': sportName, 
      'metric1': metric1,
      'metric2': metric2,
    };
  }

  factory MappedSportModel.fromMap(Map<String, dynamic> map) {
    return MappedSportModel(
      sportName: map['sport_id'] as String, 
      metric1: map['metric1'] as String,
      metric2: map['metric2'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MappedSportModel.fromJson(String source) => MappedSportModel.fromMap(json.decode(source) as Map<String, dynamic>);

  MappedSportModel copyWith({
    String? sportName, 
    String? metric1,
    String? metric2,
  }) {
    return MappedSportModel(
      sportName: sportName ?? this.sportName, 
      metric1: metric1 ?? this.metric1,
      metric2: metric2 ?? this.metric2,
    );
  }
}