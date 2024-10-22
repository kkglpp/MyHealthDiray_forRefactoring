/*
HI Goal Table에 데이터를 CRUD하는 기능들이 있어야함.
기능상 제공할 기능들은 아래와 같음.
0. db를 여는 함수.
1. healthIndex goal 리스트를 가져오는 함수 
2. healthIndex goal 1개를 가져오는 함수
3. healthIndex goal을 새로 입력하는 함수
4. healthIndex goal을 UPDATE 하는 함수
  - duedate 변경
  - success 여부 변경 + successdate 입력
5. healthIndex goal을 삭제하는 함수.
*/

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/health_index_goal_model.dart';
import '../common/const/basic_method.dart';

class HealthIndexGoalTableDataImpl {
  /*   SQL 구문들 정리 */
//0. db가 없을때 만드는 구문.
  final String _createHIgoal = '''CREATE TABLE hi_goal(
      hg_id INTEGER PRIMARY KEY AUTOINCREMENT,
      hg_height real,
      hg_weight real,
      hg_fat real,
      hg_muscle  real,
      hg_img blob,
      hg_duedate TEXT,
      hg_success INTEGER,
      hg_successdate TEXT,
      hg_priority INTEGER
      );''';

// 1. healthIndex goal 리스트를 가져오는 구문
  final String _getGoalListStr = '''
SELECT 
  hg_id,
  hg_height,
  hg_weight,
  hg_fat,
  hg_muscle,
  hg_img,
  hg_duedate,
  hg_success,
  hg_successdate,
  hg_priority 
  FROM hi_goal
''';
// 2. healthIndex goal 1개를 가져오는 구문
  final String _getGoalStr = '''
SELECT 
  hg_id ,
  hg_height ,
  hg_weight ,
  hg_fat ,
  hg_muscle,
  hg_img ,
  hg_duedate,
  hg_success ,
  hg_successdate,
  hg_priority 
  FROM hi_goal
  WHERE hg_id = ?''';
// 3. healthIndex goal을 새로 입력하는 구문
  final String _insertGoalStr = '''INSERT INTO hi_goal(
  hg_height,
  hg_weight,
  hg_fat,
  hg_muscle,
  hg_img,
  hg_duedate,
  hg_success,
  hg_successdate,
  hg_priority
  ) 
VALUES (?,?,?,?,?,?,?,?,?)
''';
// 4. healthIndex goal을 UPDATE 하는 구문
//   - duedate 변경 구문
//   - priority 변경 구문
//   - success 여부 변경 + successdate 입력

  final String _updateDuedateStr =
      "UPDATE hi_goal SET hg_duedate = ? WHERE hg_id = ?";
  final String _updatePriorityStr =
      "UPDATE hi_goal SET hg_priority = 1 WHERE hg_id = ?";
  final String _updateSuccessStr =
      "UPDATE hi_goal SET hg_success = 1, hg_successdate=?  WHERE hg_id = ?";
  final String _updateFailStr =
      "UPDATE hi_goal SET hg_success = 2, hg_successdate=?  WHERE hg_id = ?";

// 5. healthIndex goal을 삭제하는 구문.
  final String _deleteGoalStr = "DELETE FROM hi_goal WHERE hg_id = ? ";

/* Method */
// 0. db를 여는 함수.
  Future<Database> initializeTable() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'HealthLife.db'),
      onCreate: (db, version) async {
        await db.execute(_createHIgoal);
      },
      version: 1
    );
  }

// 1. healthIndex goal 리스트를 가져오는 함수
  Future<List<HealthIndexGoalModel>> getGoalList() async {
    final Database db = await initializeTable();
    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getGoalListStr);
      return result.map((e) => HealthIndexGoalModel.fromMap(e)).toList();
    } catch (e) {
      // print(e);
      // print("123213");
      return [];
    }
  }

// 2. healthIndex goal 1개를 가져오는 함수
  Future<HealthIndexGoalModel?> getGoal(int id) async {
    final Database db = await initializeTable();
    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getGoalStr, [id]);
      // print(result.toString());    
      return result.map((e) => HealthIndexGoalModel.fromMap(e)).toList()[0];
    } catch (e) {
      // print(e);
      return null;
    }
  }

// 3. healthIndex goal을 새로 입력하는 함수
  Future<bool> insertGoal(HealthIndexGoalModel goal) async {
    final Database db = await initializeTable();

    try {
      
      await db.rawInsert(
        _insertGoalStr,
        modelToList(goal.toMap()).sublist(1),
      );
    } catch (e) {
      // print(e);
      return false;
    }

    return true;
  }

// 4. healthIndex goal을 UPDATE 하는 함수
//   - duedate 변경
//   - 우선순위 변경
//   - success 여부 변경 + successdate 입력

//4.1 duedate 변경함수
  Future<bool> updateDuedate(int id, String newDate) async {
    final Database db = await initializeTable();

    try {
      await db.rawUpdate(_updateDuedateStr, [newDate, id]);
    } catch (e) {
      // print(e);
      return false;
    }
    return true;
  } //duedate 변경함수 끝 (updateDuedate)

//4.2 우선목표 변경 함수
  Future<bool> updatePriority(int id) async {
    final Database db = await initializeTable();
    try {
      int semiRS = await db.rawUpdate("UPDATE hi_goal SET hg_priority = 0");
      if (semiRS == 0) {
        return false;
      }
      await db.rawUpdate(
        _updatePriorityStr,
        [id],
      );
    } catch (e) {
      return false;
    }
    return true;
  }

  //4.3 success 여부 및 successdate 변경 함수
  Future<bool> goalSuccess(int id, String date) async {
    final Database db = await initializeTable();

    try {
      await db.rawUpdate(_updateSuccessStr, [date, id]);
    } catch (e) {
      return false;
    }
    return true;
  }

  //4.3 success 여부 및 successdate 변경 함수
  Future<bool> failSuccess(int id, String date) async {
    final Database db = await initializeTable();
    try {
      await db.rawUpdate(_updateFailStr, [date, id]);
    } catch (e) {
      return false;
    }
    return true;
  }

// 5. healthIndex goal을 삭제하는 함수.

  Future<bool> deleteGoal(int id) async {
    final Database db = await initializeTable();
    try {
      await db.rawDelete(_deleteGoalStr, [id]);
    } catch (e) {
      return false;
    }

    return true;
  }
}
