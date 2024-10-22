/* 운동 종목을 사용자 마음대로 분류하기 위한 폴더 이름을 관리하는 테이블. */

// 0.db 시작 하는기능
// 1.폴더 추가기능
// 2.폴더 지우는 기능
// 3.폴더 리스트를 가져오는 기능
// 4.폴더명 바꾸는 기능

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/sport_folder_model.dart';
import '../common/const/basic_method.dart';

class SportFolderTableDataImpl {
  //db 시작 구문
  final String _createSportFolder = '''CREATE TABLE sport_folder(
      sf_id INTEGER PRIMARY KEY AUTOINCREMENT,
      sf_name TEXT,
      );''';

  final String _insertSportFolder = '''
INSERT INTO sport_folder(
sf_name
  ) VALUES (?)
  ''';
  final String _deleteSportFolder = "DELETE FROM sport_folder WHERE sf_id = ?";
  final String _getFolderList = "SELECT * FROM sport_folder";
  final String _updateFolderName =
      "UPDATE sport_folder SET sf_name = ? WHERE sf_id = ? ";

// 0.db 시작 하는기능

  Future<Database> initializeTable() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'HealthLife.db'),
      onCreate: (db, version) async {
        await db.execute(_createSportFolder);
      },
    );
  } //db 시작 함수 끝

// 1.폴더 추가기능
// String 하나만 가져와서 해도 되지만, 나중에 어떤 Column을 추가할지 모르니 일단 모델로 작업.
  Future<bool> insertSportFolder(SportFolderModel folder) async {
    final Database db = await initializeTable();

    try {
      await db.rawInsert(
        _insertSportFolder,
        modelToList(folder.toMap()).sublist(1),
      );
    } catch (e) {
      // print(e);
      return false;
    }
    return true;
  }

// 2.폴더 지우는 기능

  Future<bool> deleteSportFolder(int id) async {

    final Database db = await initializeTable();

    try {
      await db.rawDelete(_deleteSportFolder, [id]);
    } catch (e) {
      // print(e);
      return false;
    }

    return true;
  }
// 3.폴더 리스트를 가져오는 기능

  Future<List<SportFolderModel>> getSportFolder() async {
    final Database db = await initializeTable();
    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getFolderList);
      return result.map((e) => SportFolderModel.fromMap(e)).toList();
    } catch (e) {
      // print("SportFolderTableDataImpl : $e");
      return [];
    }
  }

// 4.폴더명 바꾸는 기능
  Future<bool> updateSportFolder(int id, String name) async {

    final Database db = await initializeTable();
    try {
      await db.rawUpdate(_updateFolderName, [name, id]);
    } catch (e) {
      return false;
    }
    return true;
  }
}//end class
