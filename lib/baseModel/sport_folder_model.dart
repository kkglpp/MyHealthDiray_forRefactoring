import 'dart:convert';

class SportFolderModel {
  final int? sfId;
  final String sfName;

  SportFolderModel({
    required this.sfId,
    required this.sfName,
  });

  SportFolderModel copyWith({
    int? sfId,
    String? sfName,
  }) {
    return SportFolderModel(
      sfId: sfId ?? this.sfId,
      sfName: sfName ?? this.sfName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sf_id': sfId,
      'sf_name': sfName,
    };
  }

  factory SportFolderModel.fromMap(Map<String, dynamic> map) {
    return SportFolderModel(
      sfId: map['sf_id'] != null ? map['sf_id'] as int : null,
      sfName: map['sf_name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SportFolderModel.fromJson(String source) =>
      SportFolderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
