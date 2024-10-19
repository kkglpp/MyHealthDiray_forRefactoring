/*
TrainingGoal 테이블에 훈련 목표들을 CRUD 하는 기능들이 있어야함

0. db열기
1. goal 목표 추가하는 기능 : 
** 종목 구분 없이 조건에 만족하는 기능들 다가져오기
    2. 달성중인 목표들 가져오는 기능
    3. 우선순위 설정된 목표들만 가져오는 기능
    4. 성공한 목표들 가저오는 기능
    5. 실패한 목표들 가져오는 기능
    6. duedate 가 지난 목표들 가져오는 기능
** Sid를 받아서 해당 종목의 모든 목표들을 가져오는 기능들
    7. 달성중인 목표들 가져오는 기능
    8. 성공한 목표들 가저오는 기능
    9. 실패한 목표들 가져오는 기능
    10. duedate 가 지난 목표들 가져오는 기능
**     
11. 목표 삭제하기
12. 우선순위 바꾸기. (상단 고정하기.)
13. 성공여부를 성공으로 바꾸기
14. 성공여부를 실패로 바꾸기


 */

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../baseModel/training_goal_model.dart';
import '../common/const/basic_method.dart';

class TrainingGoalTableDataImpl {
//0. db열기

  final String _createTraingGoal = '''CREATE TABLE training_goal(
      tg_id INTEGER PRIMARY KEY AUTOINCREMENT,
      tg_s_id INTEGER,
      tg_goal1 real,
      tg_goal2 real,
      tg_duedate TEXT,
      tg_insertdate TEXT,
      tg_success INTEGER,
      tg_successdate TEXT,
      tg_priority INTEGER,
      FOREIGN KEY (tg_s_id) REFERENCES sport (sport_id) ON UPDATE CASCADE 
      );''';
// 1. goal 목표 추가하는 기능 :
  final String _insertGoalStr = '''
INSERT INTO training_goal(
      tg_s_id ,
      tg_goal1 ,
      tg_goal2 ,
      tg_duedate ,
      tg_insertdate ,
      tg_success ,
      tg_successdate ,
      tg_priority 
) VALUES (?,?,?,?,?,?,?,?)
''';

// 현재 달성중인 목표들 가져오는 기능
//2. 달성중인 모든 목표들 가져오는 기능 (priority 오름차순 / duedate 오름차순)
  final String _getProGoalListStr =
      "SELECT * FROM training_goal WHERE tg_success =0 ORDER BY tg_priority DESC, tg_id DESC, tg_insertdate DESC LIMIT ?;";

//3. 우선순위 설정된 목표들만 가져오는 기능 (insertDate 오름차순)
  final String _getProPriorityGoalsStr =
      "SELECT * FROM training_goal WHERE tg_success =0 AND tg_priority != 0 ORDER BY  tg_priority ASC, tg_duedate ASC, tg_insertdate ASC";

//     4. 성공한 목표들 가저오는 기능 (n개씩 잘라서)
  final String _getSuccessGoalsStr =
      "SELECT * FROM training_goal WHERE tg_success =1 ORDER BY tg_duedate DESC LIMIT ?";
//     5. 실패한 목표들 가져오는 기능
  final String _getFailedGoalsStr =
      "SELECT * FROM training_goal WHERE tg_success =2 ORDER BY tg_duedate DESC LIMIT ?";
//     6. duedate 가 지난 목표들 가져오는 기능
  final String _getPastGoalsStr =
      "SELECT * FROM training_goal WHERE tg_duedate < date('now') ORDER BY tg_priority ASC, tg_duedate ASC, tg_insertdate ASC;";
// 6.2 날짜가 2일이상 지난 항목들을 fail 상태로 바꾸기
  // final String _updateGoalFailed = '''
  //     UPDATE training_goal
  //     SET tgSuccess = 2
  //     WHERE tg_duedate < date('now','-2 days') AND tgSuccess = 0
  //     ''';
// ** Sid를 받아서 해당 종목의 모든 목표들을 가져오는 기능들
//     7. 달성중인 목표들 가져오는 기능
  final String _getProGoalListBySidStr =
      "SELECT * FROM training_goal WHERE tg_success = 0 AND tgS_id = ? ORDER BY tg_priority ASC, tg_duedate ASC, tg_insertdate ASC;";
//     8. 성공한 목표들 가저오는 기능
  final String _getSuccessGoalsBySidStr =
      "SELECT * FROM training_goal WHERE tg_success =1 AND tgS_id = ? ORDER BY tg_duedate DESC LIMIT ?";
//     9. 실패한 목표들 가져오는 기능
  final String _getFailedGoalsBySidStr =
      "SELECT * FROM training_goal WHERE tg_success =2 AND tgS_id = ? ORDER BY tg_duedate DESC LIMIT ?";
//     10. duedate 가 지난 목표들 가져오는 기능
  final String _getPastGoalsBySidStr =
      "SELECT * FROM training_goal WHERE tg_duedate < date('now') AND tg_s_id = ? ORDER BY tg_priority ASC, tg_duedate ASC, tg_insertdate ASC;";

// **
// 11. 목표 삭제하기
  final String _deleteGoalByGoalid = "DELETE FROM training_goal WHERE tg_id = ?";
  // final String _deleteGoalByGoalid = "DELETE FROM training_goal WHERE tg_id = ?";
// 12. 우선순위 바꾸기. (상단 고정하기.)
  final String _updatePriorityTxn1 = '''
      UPDATE training_goal 
      SET tg_priority = tg_priority + 1; 
      WHERE tg_priority >= ?;
      ''';
  final String _updatePriorityTxn2 = '''
      UPDATE training_goal 
      SET tg_priority = ? 
      WHERE tg_id = ?;
      ''';
// 13. 성공여부를 성공으로 바꾸기
  final String _updateSuccessStr = '''
UPDATE training_goal
SET tg_success = 1 , tg_successdate = ?
WHERE tg_id = ?
''';

//14. 성공여부를 실패로 바꾸기
  final String _updateFailStr = '''
UPDATE training_goal 
Set tg_success = 2 , tg_successdate = ?
WHERE tg_id = ?
''';

//15.목표 하나 가져오기
  final String _getGoalStr = "SELECT * FROM training_goal WHERE tg_id = ?";


/* Method */

// 0. db열기 / db 닫기
//우선순위 변경 페이지 에서는 db를 자주 수정해야하니, 함수마다 여고 닫는 것보다 페이지를 들어올떄, 나갈때 여고 닫는게 효율적일것.

  // Future<void> initializeTableSelf() async {
  //   Database db = await initializeTable();
  // }

  // Future<void> endTableSelf() async {
  //   Database db.close();
  // }

  Future<Database> initializeTable() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'HealthLife.db'),
      onCreate: (db, version) async {
        await db.execute(_createTraingGoal);
      },
    );
  }

// 1. goal 목표 추가하는 기능 :

  Future<bool> insertTrainGoal(TrainingGoalModel goal) async {
    final Database db = await initializeTable();
    try {
      await db.rawInsert(
        _insertGoalStr,
        modelToList(goal.toMap()).sublist(1),
      );
    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }

// ** 종목 구분 없이 조건에 만족하는 기능들 다가져오기
//     2. 달성중인 목표들 가져오는 기능
  Future<List<TrainingGoalModel>> getGoalList(int amount) async {
    final Database db = await initializeTable();
    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getProGoalListStr, [amount]);
      return result.map((e) => TrainingGoalModel.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

//     3. 우선순위 설정된 목표들만 가져오는 기능
  Future<List<TrainingGoalModel>> getProPriorityGoals() async {
    final Database db = await initializeTable();

    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getProPriorityGoalsStr);
      return result.map((e) => TrainingGoalModel.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

//     4. 성공한 목표들 가저오는 기능
  Future<List<TrainingGoalModel>> getSuccessGoals(int amount) async {
    final Database db = await initializeTable();
    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getSuccessGoalsStr, [amount]);
      return result.map((e) => TrainingGoalModel.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

//     5. 실패한 목표들 가져오는 기능
  Future<List<TrainingGoalModel>> getFailedGoals(int amount) async {
    final Database db = await initializeTable();
    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getFailedGoalsStr, [amount]);
      return result.map((e) => TrainingGoalModel.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

//     6. duedate 가 지난 목표들 가져오는 기능
  Future<List<TrainingGoalModel>> getPastGoals() async {
    final Database db = await initializeTable();
    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getPastGoalsStr);
      return result.map((e) => TrainingGoalModel.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

// ** Sid를 받아서 해당 종목의 모든 목표들을 가져오는 기능들
//     7. 종목 특정  달성중인 목표들 가져오는 기능
  Future<List<TrainingGoalModel>> getProGoalListBySid(int sportID) async {
    final Database db = await initializeTable();
    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getProGoalListBySidStr, [sportID]);
      return result.map((e) => TrainingGoalModel.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

//     8. 종목 특정 성공한 목표들 가저오는 기능
  Future<List<TrainingGoalModel>> getSuccessGoalsBySid(int sportID) async {
    final Database db = await initializeTable();
    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getSuccessGoalsBySidStr, [sportID]);
      return result.map((e) => TrainingGoalModel.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

//     9. 종목특정 실패한 목표들 가져오는 기능

  Future<List<TrainingGoalModel>> getFailedGoalsBySid(int sportID) async {
    final Database db = await initializeTable();
    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getFailedGoalsBySidStr, [sportID]);
      return result.map((e) => TrainingGoalModel.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }

//     10. duedate 가 지난 목표들 가져오는 기능
  Future<List<TrainingGoalModel>> getPastGoalsBySid(int sportID) async {
    final Database db = await initializeTable();
    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getPastGoalsBySidStr, [sportID]);
      return result.map((e) => TrainingGoalModel.fromMap(e)).toList();
    } catch (e) {
      return [];
    }
  }
// **
// 11. 목표 삭제하기

  Future<bool> deleteTrainGoal(int goalID) async {
    int result = 0;
    Database db = await initializeTable();
    try {
      result = await db.rawDelete(_deleteGoalByGoalid, [goalID]);
    } catch (e) {
      return false;
    }
    return result==1;
  }

// 12. 우선순위 바꾸기. (상단 고정하기.)
  Future<bool> updatePriority(int threshold, int newPriority, int id) async {
    Database db = await initializeTable();
    int result = 0;
    try {
      await db.transaction((txn) async {
        // 우선 기존 우선순위 항목들을 뒤로 미루기
        result = await txn.rawUpdate(_updatePriorityTxn1, [threshold]);
        if (result == 1) {
          // 빈 우선순위 자리에 새로운 row 추가하기
          result = await txn.rawUpdate(_updatePriorityTxn2, [newPriority, id]);
        }
      });
    } catch (e) {
      result = 0;
    }
    return result == 1;
  }

// 13. 성공여부를 성공으로 바꾸기
  Future<bool> updateSuccess(int goalID) async {
    final Database db = await initializeTable();
    try {
      await db.rawInsert(_updateSuccessStr, [
        onlyDay(DateTime.now()), goalID
      ]);
    } catch (e) {
      return false;
    }
    return true;
  }

// 14. 성공여부를 실패로 바꾸기
  Future<bool> updateFail(int goalID) async {
    final Database db = await initializeTable();
    try {
      await db.rawInsert(_updateFailStr, [
        onlyDay(DateTime.now()),goalID
      ]);
    } catch (e) {
      return false;
    }
    return true;
  }

  //15. 목표 하나 가져오기.

  Future<TrainingGoalModel?> getOneGoal(int goalID) async{
    final Database db = await initializeTable();
    try{
      List<Map<String, dynamic>> result = await db.rawQuery(_getGoalStr,[goalID]);
      return result.map((e) => TrainingGoalModel.fromMap(e)).toList()[0];
    }catch(e){
      return null;
    }
  }//end getOneGoal



} //class end
