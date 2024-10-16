/*
Sport 테이블에서 데이터를 CRUD 하기위한 기능들이 있어야함.

0. db열기
1. 종목 추가하기
2. 종목 리스트 가져오기
3. 종목 삭제하기
4. 한종목의 정보 가져오기
5. 종목 설명 수정하기. (Description)

 */

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../baseModel/sport_model.dart';
import '../common/basicMethod.dart';

class SportTableImpl {
  final String _createSport_str = '''CREATE TABLE sport(
      sport_id INTEGER PRIMARY KEY AUTOINCREMENT,
      sport_name TEXT,
      sport_metric1 TEXT,
      sport_metric2 TEXT,
      sport_description TEXT,
      sport_del INTEGER
      );''';

  final String _insertSport_str = '''
INSERT INTO sport(
sport_name,
sport_metric1,
sport_metric2,
sport_description,
sport_del
) VALUES (?,?,?,?,?)
''';
  final String _getSportList_str =
      "SELECT * FROM sport WHERE sport_del IS NOT 1";
  final String _getSportmap_str =
      "SELECT sport_id, sport_name FROM sport WHERE sport_del IS NOT 1";
  final String _getMetric1map_str =
      "SELECT sport_id, sport_Metric1 FROM sport WHERE sport_del IS NOT 1";
  final String _getMetric2map_str =
      "SELECT sport_id, sport_Metric2 FROM sport WHERE sport_del IS NOT 1";

  final String _getSport_str = "SELECT * FROM sport WHERE sport_id = ? ";
  final String _deleteSport_str =
      "UPDATE sport SET sport_del = 1 WHERE sport_id =? ";
  final String _updateSport_str =
      "UPDATE sport SET sport_description = ? WHERE sport_id =? ";
  final getSportName_str = "SELECT sport_name FROM sport WHERE sport_id = ? ";
  final getSportMetric1_str = "SELECT sport_metric1 FROM sport WHERE sport_id = ? ";
  final getSportMetric2_str = "SELECT sport_metric2 FROM sport WHERE sport_id = ? ";

// 0. db열기

// 0. db를 여는 함수.
  Future<Database> initializeTable() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'HealthLife.db'),
      onCreate: (db, version) async {
        await db.execute(_createSport_str);
      },
      version: 1,
    );
  }

// 1. 종목 추가하기
  Future<bool> insertSport(SportModel sport) async {
    int result;
    final Database db = await initializeTable();
    try {
      result = await db.rawInsert(
        _insertSport_str,
        modelToList(sport.toMap()).sublist(1),
      );
      // print(result);
      db.close();
      return true;
    } catch (e) {
      print("table : $e");
      db.close();
      return false;
    }
    
  }

// 2. 종목 리스트 가져오기

  Future<List<SportModel>> getSportList() async {
    final Database db = await initializeTable();
    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getSportList_str, []);
      print(result.toString());

      return result.map((e) => SportModel.fromMap(e)).toList();
    } catch (e) {
      print("table error : ${e.toString()}");
      return [];
    }
  }

  //2.1 종목을 map으로 가져오기

  Future<Map<int, String>> getSportMap() async {
    final Database db = await initializeTable();
    List<Map<String, dynamic>> result;
    try {
      result = await db.rawQuery(_getSportList_str);
    } catch (e) {
      print(e);
      result = [];
    }

    Map<int, String> sportMap = {};

    for (var row in result) {
      int sportId = row['sport_id'];
      String sportName = row['sport_name'];
      sportMap[sportId] = sportName;
    }
    print("datagetSportMap  Table : $sportMap");
    return sportMap;
  }

  //Metric1 가져오기
  Future<Map<int, String>> getMetric1Map() async {
    final Database db = await initializeTable();
    List<Map<String, dynamic>> result;
    try {
      result = await db.rawQuery(_getSportList_str);
    } catch (e) {
      print(e);
      result = [];
    }

    Map<int, String> sportMap = {};

    for (var row in result) {
      int sportId = row['sport_id'];
      String sport_metric1 = row['sport_metric1'];
      sportMap[sportId] = sport_metric1;
    }
    print("getMetric1 Map Table : $sportMap");
    return sportMap;
  }

  //Metric2 가져오기
  Future<Map<int, String>> getMetric2Map() async {
    final Database db = await initializeTable();
    List<Map<String, dynamic>> result;
    try {
      result = await db.rawQuery(_getSportList_str);
    } catch (e) {
      print(e);
      result = [];
    }

    Map<int, String> sportMap = {};

    for (var row in result) {
      int sportId = row['sport_id'];
      String sport_metric2 = row['sport_metric2'];
      sportMap[sportId] = sport_metric2;
    }
        print("getMetric2 Map Table : $sportMap");

    return sportMap;
  }

  Future<String> getSportName(int id) async {
    final Database db = await initializeTable();
    String result = "";
    try{
      List<Map<String, dynamic>> rs = (await db.rawQuery(getSportName_str,[id]));
      result = rs[0]['sport_name'];
    }catch(e){
      print(e);
    }
    return result;
  }
  Future<String> getSportMetric1(int id) async {
    final Database db = await initializeTable();
    String result = "";
    try{
      List<Map<String, dynamic>> rs = (await db.rawQuery(getSportMetric1_str,[id]));
      result = rs[0]['sport_metric1'];
    }catch(e){
      print(e);
    }
    return result;
  }
  Future<String> getSportMetric2(int id) async {
    final Database db = await initializeTable();
    String result = "";
    try{
      List<Map<String, dynamic>> rs = (await db.rawQuery(getSportMetric2_str,[id]));
      result = rs[0]['sport_metric2'];
    }catch(e){
      print(e);
    }
    return result;
  }




// 3. 종목 삭제하기

  Future<bool> deleteSport(int id) async {
    final Database db = await initializeTable();
    int result = 0;
    try {
      result = await db.rawUpdate(_deleteSport_str, [id]);
    } catch (e) {
      print("deleteSport : $e");
      return false;
    }
    return true;
  }

// 4. 한종목의 정보 가져오기
  Future<SportModel?> getSport(int id) async {
    final Database db = await initializeTable();
    try {
      List<Map<String, dynamic>> rs = await db.rawQuery(_getSport_str, [id]);
      return rs.map((e) => SportModel.fromMap(e)).toList()[0];
    } catch (e) {
      return null;
    }
  }
// 5. 종목 설명 수정하기. (Description)

  Future<bool> updateSport(String description, int id) async {
    final Database db = await initializeTable();
    int result = 0;
    try {
      result = await db.rawUpdate(_updateSport_str, [description, id]);
    } catch (e) {}
    return result == 1;
  }
}//end class
