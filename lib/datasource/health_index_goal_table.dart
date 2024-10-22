import 'package:myhealthdiary_app/model/health_index_goal_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class HealthIndexGoalData {
  // 0. db를 여는 함수.
  Future<Database> initializeTable();

  // 1. healthIndex goal 리스트를 가져오는 함수
  Future<List<HealthIndexGoalModel>> getGoalList();

  // 2. healthIndex goal 1개를 가져오는 함수
  Future<HealthIndexGoalModel?> getGoal(int id);

  // 3. healthIndex goal을 새로 입력하는 함수
  Future<bool> insertGoal(HealthIndexGoalModel goal);

  // 4. healthIndex goal을 UPDATE 하는 함수
  //   - duedate 변경
  //   - 우선순위 변경
  //   - success 여부 변경 + successdate 입력

  // 4.1 duedate 변경함수
  Future<bool> updateDuedate(int id, String newDate); // duedate 변경함수 끝

  // 4.2 우선목표 변경 함수
  Future<bool> updatePriority(int id);

  // 4.3 success 여부 및 successdate 변경 함수
  Future<bool> goalSuccess(int id, String date);

  // 4.4 실패 처리 함수
  Future<bool> failSuccess(int id, String date);

  // 5. healthIndex goal을 삭제하는 함수.
  Future<bool> deleteGoal(int id);
}