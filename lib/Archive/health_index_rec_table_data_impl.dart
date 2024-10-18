/*
HealthIndexRec 테이블에서 데이터를 CURD 하는 기능들이 있어야함
기능상 제공할 기능들은 아래와 같음.
기록의 수정은 제공하지 않음.

0. db 열기
1. 오늘의 기록 넣기
2. 기록 1개 삭제하기
3. 기록 리스트 가져오기(n개씩 끊어서 / 전체)
4. 1개 기록 가져오기
5. 각 지표별로 누적 기록들 가져오기(n개씩 끊어서 / 전체)

 */

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../baseModel/health_index_record_model.dart';
import '../common/const/basic_method.dart';


class HealthIndexRecTableDataImpl {
  /* 사용될 SQL 구문들 정리*/
  final String _createHIRec = '''CREATE TABLE hi_rec(
      hr_id INTEGER PRIMARY KEY AUTOINCREMENT,
      hr_height real,
      hr_weight real,
      hr_fat real,
      hr_muscle  real,
      hr_img blob,
      hr_insertdate TEXT      
      );''';

  // 1. 오늘 입력할 기록 넣기.
  final String _insertHIRecStr = '''
    INSERT INTO hi_rec (
      hr_height, 
      hr_weight, 
      hr_fat, 
      hr_muscle, 
      hr_img, 
      hr_insertdate
    ) VALUES (?, ?, ?, ?, ?, ?)
    ''';
  // 2. 1개 기록 삭제하기
  final String _deleteHIRecStr = "DELETE FROM hi_rec WHERE hr_id = ?";

  //3.1 기록리스트를 최근 순서로 n개 가져오기
  final String _getRecordsStr = '''
SELECT * FROM (
  SELECT hr_id,
          hr_height ,
          hr_weight ,
          hr_fat ,
          hr_muscle ,
          hr_img ,
          hr_insertdate 
    FROM hi_rec
    ORDER BY hr_insertdate DESC
    LIMIT ?
)
ORDER BY insertdate ASC;
''';
  // "SELECT * FROM (SELECT * FROM hi_rec ORDER BY hr_insertdate DESC LIMIT ?) ORDER BY hr_insertdate ASC";

  //4.1개 기록 가져오기
  final String _getOneRecordStr = '''  SELECT hr_id AS id,
          hr_height ,
          hr_weight t,
          hr_fat ,
          hr_muscle ,
          hr_img ,
          hr_insertdate
      FROM hi_rec 
      WHERE hr_id = ?
''';
  // "SELECT * FROM hi_rec WHERE hr_id = ?";

  //5. 내가 원하는 항목의 데이터만 id, insertdate와 같이 n개 가져오기
  //SELECT * FROM (SELECT ? 를 앞에 붙일것
  final String _getSpecificRecordsStr =
      " hr_id FROM hi_rec ORDER BY hr_id DESC LIMIT ? ) ORDER BY hr_id ASC";

/* 메소드  */

// 0. db 열기

  Future<Database> initializeTable() async {
    String path = await getDatabasesPath();
    return openDatabase(join(path, 'HealthLife.db'),
        onCreate: (db, version) async {
      await db.execute(_createHIRec);
    }, version: 1);
  }

// 1. 오늘의 기록 넣기
  Future<bool> insertHIRec(HealthIndexRecordModel record) async {
    // int result = 0;
    final Database db = await initializeTable();

    try {
      await db.rawInsert(
        _insertHIRecStr,
        modelToList(record.toMap()).sublist(1),
      );
      // print('db: $rs');
      return true;
    } catch (e) {
      // print('db : $e');
      return false;
    }
  }

// 2. 기록 1개 삭제하기
  Future<bool> deleteHIRec(int id) async {
    int result;
    final Database db = await initializeTable();
    try {
      result = await db.rawDelete(_deleteHIRecStr, [id]);
    } catch (e) {
      // print('db : $e');
      return false;
    }
    return result == 1;
  }

// 3. 기록 리스트 가져오기(n개씩 끊어서 / 전체)

  Future<List<HealthIndexRecordModel>> getRecords(int limit) async {
    final Database db = await initializeTable();
    // print(db);
    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getRecordsStr, [limit]);
      return result.map((e) => HealthIndexRecordModel.fromMap(e)).toList();
    } catch (e) {
      // print('db : $e');
      return [];
    }
  }

// 4. 1개 기록 가져오기
  Future<HealthIndexRecordModel?> getOneRecord(int id) async {
    final Database db = await initializeTable();
    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getOneRecordStr, [id]);
      return result.map((e) => HealthIndexRecordModel.fromMap(e)).toList()[0];
    } catch (e) {
      // print('db : $e');
      return null;
    }
  }

// 5. 각 지표별로 누적 기록들 가져오기(n개씩 끊어서 / 전체)
  Future<List<dynamic>> getOneIndexRecords(String sort, int amount) async {
    String str =
        "SELECT hr_$sort FROM ( SELECT hr_$sort, $_getSpecificRecordsStr";
    List result = [];
    final Database db = await initializeTable();
    try {
      // print("db 열렸냐? 1: ${db.isOpen}");
      List<Map<String, dynamic>> rs = await db.rawQuery(str, [amount]);
      // print("db 열렸냐? 2: ${db.isOpen}");
      result = rs
          .map((e) => e.values.toList())
          .expand((element) => element)
          .toList();
      return result;
    } catch (e) {
      // print('db : $e');
      return [];
    } finally {
      // await db.close();
    }
  }
} // end class
