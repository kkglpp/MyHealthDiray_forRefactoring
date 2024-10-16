// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SportModel {
  final int? sport_id;
  final String sport_name;
  final String sport_metric1;
  final String sport_metric2;
  final String sport_description;
  final int sport_del;

  SportModel({required this.sport_id, required this.sport_name, required this.sport_metric1, required this.sport_metric2, required this.sport_description, required this.sport_del});

  SportModel copyWith({
    int? sport_id,
    String? sport_name,
    String? sport_metric1,
    String? sport_metric2,
    String? sport_description,
    int? sport_del,
  }) {
    return SportModel(
      sport_id: sport_id ?? this.sport_id,
      sport_name: sport_name ?? this.sport_name,
      sport_metric1: sport_metric1 ?? this.sport_metric1,
      sport_metric2: sport_metric2 ?? this.sport_metric2,
      sport_description: sport_description ?? this.sport_description,
      sport_del: sport_del ?? this.sport_del,
    );
  }






  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sport_id': sport_id,
      'sport_name': sport_name,
      'sport_metric1': sport_metric1,
      'sport_metric2': sport_metric2,
      'sport_description': sport_description,
      'sport_del': sport_del,
    };
  }

  factory SportModel.fromMap(Map<String, dynamic> map) {
    return SportModel(
      sport_id: map['sport_id'] != null ? map['sport_id'] as int : null,
      sport_name: map['sport_name'] as String,
      sport_metric1: map['sport_metric1'] as String,
      sport_metric2: map['sport_metric2'] as String,
      sport_description: map['sport_description'] as String,
      sport_del: map['sport_del'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory SportModel.fromJson(String source) => SportModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
