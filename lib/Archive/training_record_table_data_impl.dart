/* 
매일 운동 한 일지를 기록하는 TrainingRecord 테이블

  // 0. db여는 기능
  // 1. 여러 row를 한번에 입력하는 기능
  ///2. 한 row를 수정 update 하는 기능 (rec1, rec2 를 수정하는 기능)
  // 3. done을 Update하는 기능
  // 4. 특정 기간의 운동 계획 가져오기 (하루 포함)
  // 하루 플랜의 타이틀과 날짜를 가져온다. 해당 정보를 통해서 그날 전체 운동을 플랜을 조회해 올 수 있어야 한다.
  // { title, traindate, 실행 안한 row , 실행한 row, 실패한 row를} 형태로 조회한다.
  // 수행정도를 %로 표현하기 위해서 각 row의 수 (set수)를 따로 조회한 것이다.
  // 입력할 값은 최소날짜, 최대날짜, 가져올 개수 이다.
  // 5. 타이틀과 날짜 가지고 그날 운동 계획 종목들을 가져와야한다.
  // {title, s_id, traindate, 총 세트수, 수행 완료한 세트수} 형태로 데이터를 반환한다.
  // 넣어줄 값은 title, traindate 두가지 이다.
  // 6. 5에서 가져온 정보에서 각 s_id 들을 통해서 가져올 수 있어야한다.
  // 즉 해당 날짜, 해당 타이틀의 해당 종목 운동 계획의 모든 세트 수를 가져오는 구문/// 
  // 7. 한 row를 삭제하는 기능 (trainingPlan ID)
  // 8. 제목과 날짜를 받아서 해당 row 삭제하는 기능
  // 9.제목과 날짜와 종목을 받아서 삭제하는 기능

*/

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../baseModel/training_rec_model.dart';
import '../common/basic_method.dart';

class TrainingRecordsTableDataImpl {
// 0. db여는 기능
final String _createTraingRec = '''CREATE TABLE training_rec(
      tr_id INTEGER PRIMARY KEY AUTOINCREMENT,
      tr_title TEXT,
      tr_s_id INTEGER,
      tr_set INTEGER,
      tr_rec1 real,
      tr_rec2 real,
      tr_traindate TEXT,
      FOREIGN KEY (tr_s_id) REFERENCES sport (sport_id) ON UPDATE CASCADE 
      );''';
// insert
// 1. 여러 row를 한번에 입력하는 기능
  final String _insertTrainingRecStr = '''INSERT INTO training_rec (
  tr_title,
  tr_s_id,
  tr_set,
  tr_rec1,
  tr_rec2,
  tr_traindate
  )VALUES (?, ?, ?, ?, ?, ?);
''';


// Query
// 4. 특정 기간의 운동 기록 가져오기 (하루 포함)
// 하루 플랜의 타이틀과 날짜를 가져온다. 해당 정보를 통해서 그날 전체 운동을 플랜을 조회해 올 수 있어야 한다.
// { title, traindate, 실행 안한 row , 실행한 row, 실패한 row를} 형태로 조회한다.
// 수행정도를 %로 표현하기 위해서 각 row의 수 (set수)를 따로 조회한 것이다.
// 입력할 값은 최소날짜, 최대날짜, 가져올 개수 이다.
  final String _getDaysRecSummaryStr = '''
SELECT 
  tr_title, 
  tr_traindate,
FROM training_rec
WHERE tr_traindate BETWEEN ? AND ?
GROUP BY tr_title, tr_traindate
ORDER BY tr_traindate ASC
LIMIT = ?
''';

//5. 타이틀과 날짜 가지고 그날 운동 계획 종목들을 가져와야한다.
// {title, s_id, traindate, 총 세트수, 수행 완료한 세트수} 형태로 데이터를 반환한다.
// 넣어줄 값은 title, traindate 두가지 이다.
/*
  final String _getDaysRecSportListStr = '''
SELECT 
    tr_title,
    tr_s_id,
    tr_traindate,
    COUNT(*) AS total_count,
FROM training_rec
WHERE tr_title = ?
AND tr_traindate = ?
GROUP BY tr_title, tr_s_id, tr_traindate;
''';
*/

// 6. 5에서 가져온 정보에서 각 s_id 들을 통해서 가져올 수 있어야한다.
// 즉 해당 날짜, 해당 타이틀의 해당 종목 운동 계획의 모든 세트 수를 가져오는 구문
  final String _getDaysEachSportRecStr = '''
SELECT *
FROM training_rec 
WHERE tr_title = ? AND tr_s_id = ? AND tr_traindate = ?
ORDER By tr_set ASC
''';

// DELETE
// 7. 한 row를 삭제하는 기능
  final String _deleteOneRecStr = "DELETE FROM training_rec WHERE tr_id = ?;";

// 8. title과 날짜를 받아서 해당 row 삭제하는 기능
  final String _deleteDayRecStr =
      "DELETE FROM training_rec WHERE tr_title = ? AND tr_traindate = ?;";

// 9. title과 날짜, 종목을 받아서 삭제하는 기능
  final String _deleteDaySpecificSportStr =
      "DELETE FROM training_rec WHERE tr_title =? AND tr_traindate = ? AND tr_s_id = ?;";

/* Method */

/// 0. db여는 기능
  Future<Database> initializeTable() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'HealthLife.db'),
      onCreate: (db, version) async {
        await db.execute(_createTraingRec);
      },
    );
  } //db 시작 함수 끝

//insert
/// 1. 기록을  입력하는 기능 한종목 한세트 단위로 기록한다.
  Future<bool> insertTrainingRecords(
      TrainingRecModel model) async {
    final Database db = await initializeTable();
    try {
      await db.rawInsert(_insertTrainingRecStr,
      modelToList(model.toMap()).sublist(1)
      );
    } catch (e) {
      return false;
    }
    return true;
  }

// Query
  /// 4. 특정 기간의 운동 기록 가져오기 (하루 포함)
  /// 하루 플랜의 타이틀과 날짜를 가져온다. 해당 정보를 통해서 그날 전체 운동을 플랜을 조회해 올 수 있어야 한다.
  /// { title, traindate } 형태로 조회한다.
  /// 입력할 값은 최소날짜, 최대날짜, 가져올 개수 이다.
  Future<List<TrainingRecModel>> getDayPlanSummary(
      String date01, String date02, int limit) async {
    Database db = await initializeTable();
    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getDaysRecSummaryStr, [date01, date02, limit]);
              return result
          .map((e) => TrainingRecModel.fromMap(e))
          .toList();
    } catch (e) {
      return [];
    }
  }

  ///5. 타이틀과 날짜 가지고 그날 운동 기록 종목들을 가져와야한다.
  /// {title, s_id, traindate, 총 세트수} 형태로 데이터를 반환한다.
  /// 넣어줄 값은 title, traindate 두가지 이다.
  // Future<List<TrainingRecodModelForSportListEachDay>> getDaysRecSportList(
  //     String title, String date) async {
  //   Database db = await initializeTable();
  //   try {
  //     final List<Map<String, dynamic>> result =
  //         await db.rawQuery(_getDaysRecSportListStr, [title, date]);
  //     return result
  //         .map((e) => TrainingRecodModelForSportListEachDay.fromMap(e))
  //         .toList();
  //   } catch (e) {
  //     return [];
  //   }
  // }

  /// 6. 5에서 가져온 정보에서 각 s_id 들을 통해서 가져올 수 있어야한다.
  /// 즉 해당 날짜, 해당 타이틀의 해당 종목 운동 계획의 모든 세트 수를 가져오는 구문
  Future<List<TrainingRecModel>> getDaysEachSportRec(String title,
      int sportID, String date) async {
    Database db = await initializeTable();
    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getDaysEachSportRecStr, [title, sportID, date]);
      return result.map((e) => TrainingRecModel.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

//DELETE
  /// 7. 한 row를 삭제하는 기능 (trainingPlan ID)
  Future<bool> deleteOneRec(int id) async {
    Database db = await initializeTable();
    int result = 0;
    try {
      result = await db.rawDelete(_deleteOneRecStr, [id]);
    } catch (e) {
      result = 0;
    }
      
    return result == 1;
  }

  /// 8. 제목과 날짜를 받아서 해당 row 삭제하는 기능
  Future<bool> deleteDayRec(String title, String date) async {
    Database db = await initializeTable();
    int result = 0;
    try {
      result = await db.rawDelete(_deleteDayRecStr, [title, date]);
    } catch (e) {
      result = 0;
    }
      
    return result == 1;
  }

  /// 9.제목과 날짜와 종목을 받아서 삭제하는 기능
  Future<bool> deleteDaySpecificSport(
      String title, String date, String sportID) async {
    Database db = await initializeTable();
    try {
      await db
          .rawDelete(_deleteDaySpecificSportStr, [title, date, sportID]);
    } catch (e) {
      return false;
    }
      
    return true;
  }
} //end class