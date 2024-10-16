// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SportFolderModel {
  final int? sf_id;
  final String sf_name;

  SportFolderModel({required this.sf_id, required this.sf_name});
  // copyWith 메서드
  SportFolderModel copyWith({int? sf_id, String? sf_name}) {
    return SportFolderModel(
      sf_id: sf_id ?? this.sf_id, // sf_id가 null일 경우 기존 값 사용
      sf_name: sf_name ?? this.sf_name, // sf_name이 null일 경우 기존 값 사용
    );
  }


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sf_id': sf_id,
      'sf_name': sf_name,
    };
  }

  factory SportFolderModel.fromMap(Map<String, dynamic> map) {
    return SportFolderModel(
      sf_id: map['sf_id'] != null ? map['sf_id'] as int : null,
      sf_name: map['sf_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SportFolderModel.fromJson(String source) => SportFolderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
