/*
TrainingPlan 운동 계획을 CRUD 하는 기능들이 있어야함 

  // 0. db여는 기능
  
  // 1. 여러 row를 한번에 입력하는 기능
  
  // 2. Row의 기록들을 수정 update 하는 기능 (rec1, rec2 를 수정하는 기능)
  
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

import '../baseModel/trainingPlan_model.dart';
import '../common/basicMethod.dart';

class TrainingPlanTableDataImpl {
// 0. db여는 기능
  final String _createTraingPlanStr = '''CREATE TABLE training_plan(
      tp_id INTEGER PRIMARY KEY AUTOINCREMENT,
      tp_title TEXT,
      tp_s_id INTEGER,
      tp_set INTEGER,
      tp_rec1 real,
      tp_rec2 real,
      tp_traindate TEXT,
      tp_done int
      FOREIGN KEY (tp_s_id) REFERENCES sport (sport_id) ON UPDATE CASCADE,
      UNIQUE (tp_title, tp_s_id, tp_set, tp_traindate) 
      );''';
// insert
// 1. 여러 row를 한번에 입력하는 기능
  final String _insertTrainingPlanStr = '''INSERT INTO training_plan (
  tp_title,
  tp_s_id,
  tp_set,
  tp_rec1,
  tp_rec2,
  tp_traindate,
  tp_done
  )VALUES (?, ?, ?, ?, ?, ?,?);
''';

// update
// 2. 한 row를 수정 update 하는 문구 (rec1, rec2)
  final String _updateTrainingPlanRowStr = '''
UPDATE training_plan 
SET tp_rec1 = ?, tp_rec2 = ? 
WHERE tp_id=?;
''';

// 3. 수행 했는지 Update하는 기능 (% 단위로)
  final String _updateTrainingDoneStr = '''
UPDATE training_plan 
SET tp_done = ? 
WHERE tp_id = ?;
''';

// Query
// 4. 특정 기간의 운동 계획 가져오기 (하루 포함)
// { title, traindate, 실행 안한 row , 실행한 row, 실패한 row를} 형태로 조회한다.
// 수행정도를 %로 표현하기 위해서 각 row의 수 (set수)를 따로 조회한 것이다.
// 입력할 값은 최소날짜, 최대날짜, 가져올 개수 이다.
  final String _getDaysPlanSummaryStr = '''
SELECT 
  tp_title, 
  tp_traindate,
  COUNT(*) AS total_count,
  SUM(CASE WHEN tp_done = 1 THEN 1 ELSE 0 END) AS done_count,
FROM training_plan
WHERE tp_traindate BETWEEN ? AND ?
GROUP BY tp_title, tp_traindate
ORDER BY tp_traindate ASC
LIMIT = ?
''';

//5. 타이틀과 날짜 가지고 그날 운동 계획 종목들을 가져와야한다.
// {title, s_id, traindate, 총 세트수, 수행 완료한 세트수} 형태로 데이터를 반환한다.
// 넣어줄 값은 title, traindate 두가지 이다.
  final String _getDaysPlanSportListStr = '''
SELECT 
    tp_title,
    tp_s_id,
    tp_traindate,
    COUNT(*) AS total_count,
    SUM(CASE WHEN tp_done = 1 THEN 1 ELSE 0 END) AS done_count
FROM training_plan
WHERE tp_title = ?
AND tp_traindate = ?
GROUP BY tp_title, tp_s_id, tp_traindate;
''';

// 6. 5에서 가져온 정보에서 각 s_id 들을 통해서 가져올 수 있어야한다.
// 즉 해당 날짜, 해당 타이틀의 해당 종목 운동 계획의 모든 세트 수를 가져오는 구문
  final String _getDaysEachSportPlanStr = '''
SELECT *
FROM training_plan 
WHERE tp_title=? AND tp_s_id = ? AND tp_traindate = ?
ORDER By tp_set ASC
''';

//6.2 각날짜마다 title을 가져오는 구문
final String _getTitlesPerdayForCarlendarStr = '''
    SELECT DISTINCT tp_traindate, tp_title
    FROM training_plan
    ORDER BY tp_traindate;
''';
//6.3 기간의 title을 가져오는 구문
final String _getTitlesPerdayForPeriod = '''
    SELECT DISTINCT tp_traindate, tp_title
    FROM training_plan
    WHERE tp_traindate BETWEEN ? AND ? 
    ORDER BY tp_traindate ASC
    ;
''';


// DELETE
// 7. 한 row를 삭제하는 기능

  final String _deleteOnePlanStr = "DELETE FROM training_plan WHERE tp_id = ?;";

// 8. title과 날짜를 받아서 해당 row 삭제하는 기능
  final String _deleteDayPlanStr =
      "DELETE FROM training_plan WHERE tp_title = ? AND tp_traindate = ?;";

// 9. title과 날짜, 종목을 받아서 삭제하는 기능
  final String _deleteDaySpecificSportStr =
      "DELETE FROM training_plan WHERE tp_title =? AND tp_traindate = ? AND tp_s_id = ?;";

/* Method */

/// 0. db여는 기능
  Future<Database> initializeTable() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'HealthLife.db'),
      onCreate: (db, version) async {
        await db.execute(_createTraingPlanStr);
      },
      version: 1,

    );
  } //db 시작 함수 끝

//insert
/// 1. 여러 row를 한번에 입력하는 기능
  Future<bool> insertMultipleTrainingPlans(
      List<TrainingPlanModel> plans) async {
    final Database db = await initializeTable();
    int result = 0;
    try {
      await db.transaction((txn) async {
        for (var plan in plans) {
          result = await txn.rawInsert(
            _insertTrainingPlanStr,
            modelToList(plan.toMap()).sublist(1),
          );
        }
      });
    } catch (e) {
      print("$e");
      return false;
    }
    print("들어간 개수? : $result");
    db.close();
    return true;
  }

//update
/// 2. Row의 기록들을 수정 update 하는 기능 (rec1, rec2 를 수정하는 기능)
  // Future<bool> updateTrainingPlanRow(
  //     List<TrainingPlanModelForUpdateRow> models) async {
  //   int result = 0;
  //   Database db = await initializeTable();

  //   try {
  //     await db.transaction((txn) async {
  //       for (var model in models) {
  //         result = await txn.rawUpdate(
  //             _updateTrainingPlanRowStr, modelToList(model.toMap()));
  //       }
  //     });
  //   } catch (e) {
  //     print("$e");
  //     result = 0;
  //   }
      
  //   return result == 1;
  // }

/// 3. done을 Update하는 기능
  Future<bool> updateDone(int done, int id) async {
    Database db = await initializeTable();
    int result = 0;
    try {
      result = await db.rawUpdate(_updateTrainingDoneStr, [done, id]);
    } catch (e) {
      result = 0;
    }

    return result == 1;
  } //updateDone

// Query
  /// 4. 특정 기간의 운동 계획 가져오기 (하루 포함)
  /// 하루 플랜의 타이틀과 날짜를 가져온다. 해당 정보를 통해서 그날 전체 운동을 플랜을 조회해 올 수 있어야 한다.
  /// { title, traindate, 실행 안한 row , 실행한 row, 실패한 row를} 형태로 조회한다.
  /// 수행정도를 %로 표현하기 위해서 각 row의 수 (set수)를 따로 조회한 것이다.
  /// 입력할 값은 최소날짜, 최대날짜, 가져올 개수 이다.
  // Future<List<TrainingPlanModelForDailyList>> getDayPlanSummary(
  //     String date01, String date02, int limit) async {
  //   Database db = await initializeTable();
  //   try {
  //     final List<Map<String, dynamic>> result =
  //         await db.rawQuery(_getDaysPlanSummaryStr, [date01, date02, limit]);
  //             return result
  //         .map((e) => TrainingPlanModelForDailyList.fromMap(e))
  //         .toList();
  //   } catch (e) {
  //     print('$e');
  //     return [];
  //   }
  // }

  ///5. 타이틀과 날짜 가지고 그날 운동 계획 종목들을 가져와야한다.
  /// {title, s_id, traindate, 총 세트수, 수행 완료한 세트수} 형태로 데이터를 반환한다.
  /// 넣어줄 값은 title, traindate 두가지 이다.
  Future<List<PlanListOfPlanSet>> getDaysPlanSportList(
      String title, String date) async {
    Database db = await initializeTable();
    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getDaysPlanSportListStr, [title, date]);
      print("getDaysPlanSportList : ${result.toString()}")    ;
      return result
          .map((e) => PlanListOfPlanSet.fromMap(e))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// 6. 5에서 가져온 정보에서 각 s_id 들을 통해서 가져올 수 있어야한다.
  /// 즉 해당 날짜, 해당 타이틀의 해당 종목 운동 계획의 모든 세트 수를 가져오는 구문
  Future<List<TrainingPlanModel>> getDaysEachSportPlan(String title,
      int sportID, String date) async {
    Database db = await initializeTable();
    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getDaysEachSportPlanStr, [title,sportID, date]);
      return result.map((e) => TrainingPlanModel.fromMap(e)).toList();
    } catch (e) {
      print('$e');
      return [];
    }
  }

//DELETE
  /// 7. 한 row를 삭제하는 기능 (trainingPlan ID)
  Future<bool> deleteOnePlan(int id) async {
    Database db = await initializeTable();
    int result = 0;
    try {
      result = await db.rawDelete(_deleteOnePlanStr, [id]);
    } catch (e) {
      print(e);
      result = 0;
    }
      
    return result == 1;
  }

  /// 8. 제목과 날짜를 받아서 해당 row 삭제하는 기능
  Future<bool> deleteDayPlan(String title, String date) async {
    Database db = await initializeTable();
    int result = 0;
    try {
      result = await db.rawDelete(_deleteDayPlanStr, [title, date]);
    } catch (e) {
      print(e);
      result = 0;
    }
      
    return result == 1;
  }

  /// 9.제목과 날짜와 종목을 받아서 삭제하는 기능
  Future<bool> deleteDaySpecificSport(
      String title, String date, int sportID) async {
    Database db = await initializeTable();
    int result = 0;
    try {
      result = await db
          .rawDelete(_deleteDaySpecificSportStr, [title, date, sportID]);
    } catch (e) {
      print(e);
      return false;
    }
      
    return result >0;
  }

  Future<List<Map<String, dynamic>>> getTrainingListEachDay() async {
    Database db = await initializeTable();
    try{
      List<Map<String, dynamic>> result = await db.rawQuery(_getTitlesPerdayForCarlendarStr);
      return result;
    }catch(e){
      print(e);
      return [];
    }
  }

  Future<List<Map<String,dynamic>>> getTitlesPerdayForPeriod() async {
      Database db = await initializeTable();
      String yesterday = onlyDay(DateTime.now().subtract(Duration(days: 1)));
      String today = onlyDay(DateTime.now());
      String tomorrow = onlyDay(DateTime.now().add(Duration(days: 1)));
    try{
      List<Map<String, dynamic>> result = await db.rawQuery(_getTitlesPerdayForPeriod, [yesterday,tomorrow]);
      return result;
    }catch(e){
      print(e);
      return [];
    }
  }




} //end class
