// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SortSportModel {
  final int sf_id;
  final int sport_id;
  final String sport_name;

  SortSportModel(
      {required this.sf_id, required this.sport_id, required this.sport_name});

  SortSportModel copyWith({
    final int? sf_id,
    final int? sport_id,
    final String? sport_name,
  }) {
    return SortSportModel(
      sf_id: sf_id ?? this.sf_id,
      sport_id: sport_id ?? this.sport_id,
      sport_name: sport_name ?? this.sport_name,
    );
  }



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sf_id': sf_id,
      'sport_id': sport_id,
      'sport_name': sport_name,
    };
  }

  factory SortSportModel.fromMap(Map<String, dynamic> map) {
    return SortSportModel(
      sf_id: map['sf_id'] as int,
      sport_id: map['sport_id'] as int,
      sport_name: map['sport_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SortSportModel.fromJson(String source) =>
      SortSportModel.fromMap(json.decode(source) as Map<String, dynamic>);




  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SortSportModel) return false;
    return sf_id == other.sf_id &&
        sport_id == other.sport_id &&
        sport_name == other.sport_name;
  }

  @override
  int get hashCode => sf_id.hashCode ^ sport_id.hashCode ^ sport_name.hashCode;



}
