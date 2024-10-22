/*
Sport 테이블에서 데이터를 CRUD 하기위한 기능들이 있어야함.

0. db열기
1. 종목 추가하기
2. 종목 리스트 가져오기
3. 종목 삭제하기
4. 한종목의 정보 가져오기
5. 종목 설명 수정하기. (Description)

 */

import 'package:myhealthdiary_app/datasource/sport_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/sport_model.dart';
import '../common/const/basic_method.dart';

class SportTableImpl implements SportTable {
  final String _createSportStr = '''CREATE TABLE sport(
      sport_id INTEGER PRIMARY KEY AUTOINCREMENT,
      sport_name TEXT,
      sport_metric1 TEXT,
      sport_metric2 TEXT,
      sport_description TEXT,
      sport_del INTEGER
      );''';

  final String _insertSportStr = '''
      INSERT INTO sport(
      sport_name,
      sport_metric1,
      sport_metric2,
      sport_description,
      sport_del
      ) VALUES (?,?,?,?,?)
      ''';
  final String _getSportListStr =
      "SELECT * FROM sport WHERE sport_del IS NOT 1";
  // final String _getSportmapStr =
  //     "SELECT sport_id, sport_name FROM sport WHERE sport_del IS NOT 1";
  // final String _getMetric1mapStr =
  //     "SELECT sport_id, sport_Metric1 FROM sport WHERE sport_del IS NOT 1";
  // final String _getMetric2mapStr =
  //     "SELECT sport_id, sport_Metric2 FROM sport WHERE sport_del IS NOT 1";

  final String _getSportStr = "SELECT * FROM sport WHERE sport_id = ? ";
  final String _deleteSportStr =
      "UPDATE sport SET sport_del = 1 WHERE sport_id =? ";
  final String _updateSportStr =
      "UPDATE sport SET sport_description = ? WHERE sport_id =? ";
  final getSportNameStr = "SELECT sport_name FROM sport WHERE sport_id = ? ";
  final getSportMetric1Str =
      "SELECT sport_metric1 FROM sport WHERE sport_id = ? ";
  final getSportMetric2Str =
      "SELECT sport_metric2 FROM sport WHERE sport_id = ? ";

// 0. db열기

// 0. db를 여는 함수.
  @override
  Future<Database> initializeTable() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'HealthLife.db'),
      onCreate: (db, version) async {
        await db.execute(_createSportStr);
      },
      version: 1,
    );
  }

// 1. 종목 추가하기
  @override
  Future<bool> insertSport(SportModel sport) async {
    final Database db = await initializeTable();
    try {
      await db.rawInsert(
        _insertSportStr,
        modelToList(sport.toMap()).sublist(1),
      );
      // print(result);
      db.close();
      return true;
    } catch (e) {
      db.close();
      return false;
    }
  }

// 2. 종목 리스트 가져오기

  @override
  Future<List<SportModel>> getSportList() async {
    final Database db = await initializeTable();
    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getSportListStr, []);
      return result.map((e) => SportModel.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

  //2.1 종목을 map으로 가져오기

  @override
  Future<Map<int, String>> getSportMap() async {
    final Database db = await initializeTable();
    List<Map<String, dynamic>> result;
    try {
      result = await db.rawQuery(_getSportListStr);
    } catch (e) {
      result = [];
    }

    Map<int, String> sportMap = {};

    for (var row in result) {
      int sportId = row['sport_id'];
      String sportName = row['sport_name'];
      sportMap[sportId] = sportName;
    }
    return sportMap;
  }

  //Metric1 가져오기
  @override
  Future<Map<int, String>> getMetric1Map() async {
    final Database db = await initializeTable();
    List<Map<String, dynamic>> result;
    try {
      result = await db.rawQuery(_getSportListStr);
    } catch (e) {
      result = [];
    }

    Map<int, String> sportMap = {};

    for (var row in result) {
      int sportId = row['sport_id'];
      String sportMetric1 = row['sport_metric1'];
      sportMap[sportId] = sportMetric1;
    }
    return sportMap;
  }

  //Metric2 가져오기
  @override
  Future<Map<int, String>> getMetric2Map() async {
    final Database db = await initializeTable();
    List<Map<String, dynamic>> result;
    try {
      result = await db.rawQuery(_getSportListStr);
    } catch (e) {
      result = [];
    }
    Map<int, String> sportMap = {};
    for (var row in result) {
      int sportId = row['sport_id'];
      String sportMetric2 = row['sport_metric2'];
      sportMap[sportId] = sportMetric2;
    }
    return sportMap;
  }

  Future<String> getSportName(int id) async {
    final Database db = await initializeTable();
    String result = "";

    try {
      List<Map<String, dynamic>> rs =
          (await db.rawQuery(getSportNameStr, [id]));
      result = rs[0]['sport_name'];
    } catch (e) {
      return "";
    }
    return result;
  }

  Future<String> getSportMetric1(int id) async {
    final Database db = await initializeTable();
    String result = "";
    try {
      List<Map<String, dynamic>> rs =
          (await db.rawQuery(getSportMetric1Str, [id]));
      result = rs[0]['sport_metric1'];
    } catch (e) {
      return "";
    }
    return result;
  }

  Future<String> getSportMetric2(int id) async {
    final Database db = await initializeTable();
    String result = "";
    try {
      List<Map<String, dynamic>> rs =
          (await db.rawQuery(getSportMetric2Str, [id]));
      result = rs[0]['sport_metric2'];
    } catch (e) {
      return "";
    }
    return result;
  }

// 3. 종목 삭제하기

  @override
  Future<bool> deleteSport(int id) async {
    final Database db = await initializeTable();
    try {
      await db.rawUpdate(_deleteSportStr, [id]);
    } catch (e) {
      return false;
    }
    return true;
  }

// 4. 한종목의 정보 가져오기
  @override
  Future<SportModel?> getSport(int id) async {
    final Database db = await initializeTable();
    try {
      List<Map<String, dynamic>> rs = await db.rawQuery(_getSportStr, [id]);
      return rs.map((e) => SportModel.fromMap(e)).toList()[0];
    } catch (e) {
      return null;
    }
  }
// 5. 종목 설명 수정하기. (Description)

  @override
  Future<bool> updateSport(String description, int id) async {
    final Database db = await initializeTable();

    try {
      await db.rawUpdate(_updateSportStr, [description, id]);
    } catch (e) {
      return false;
    }
    return true;
  }
}//end class
