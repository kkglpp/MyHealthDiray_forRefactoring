// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SortSportModel {
  final int sfId;
  final int sportId;
  final String sportName;

  SortSportModel({
    required this.sfId,
    required this.sportId,
    required this.sportName,
  });

  SortSportModel copyWith({
    int? sfId,
    int? sportId,
    String? sportName,
  }) {
    return SortSportModel(
      sfId: sfId ?? this.sfId,
      sportId: sportId ?? this.sportId,
      sportName: sportName ?? this.sportName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sf_id': sfId,
      'sport_id': sportId,
      'sport_name': sportName,
    };
  }

  factory SortSportModel.fromMap(Map<String, dynamic> map) {
    return SortSportModel(
      sfId: map['sf_id'] as int,
      sportId: map['sport_id'] as int,
      sportName: map['sport_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SortSportModel.fromJson(String source) =>
      SortSportModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SortSportModel) return false;
    return sfId == other.sfId &&
        sportId == other.sportId &&
        sportName == other.sportName;
  }

  @override
  int get hashCode => sfId.hashCode ^ sportId.hashCode ^ sportName.hashCode;
}
