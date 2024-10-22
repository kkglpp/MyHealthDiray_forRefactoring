import 'package:myhealthdiary_app/model/training_goal_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class TrainingGoalTableData {
  // DB 초기화
  Future<Database> initializeTable();

  // 1. goal 목표 추가하는 기능
  Future<bool> insertTrainGoal(TrainingGoalModel goal);

  // 2. 달성중인 목표들 가져오는 기능
  Future<List<TrainingGoalModel>> getGoalList(int amount);

  // 3. 우선순위 설정된 목표들만 가져오는 기능
  Future<List<TrainingGoalModel>> getProPriorityGoals();

  // 4. 성공한 목표들 가져오는 기능
  Future<List<TrainingGoalModel>> getSuccessGoals(int amount);

  // 5. 실패한 목표들 가져오는 기능
  Future<List<TrainingGoalModel>> getFailedGoals(int amount);

  // 6. due date가 지난 목표들 가져오는 기능
  Future<List<TrainingGoalModel>> getPastGoals();

  // 7. 종목 특정 달성중인 목표들 가져오는 기능
  Future<List<TrainingGoalModel>> getProGoalListBySid(int sportID);

  // 8. 종목 특정 성공한 목표들 가져오는 기능
  Future<List<TrainingGoalModel>> getSuccessGoalsBySid(int sportID);

  // 9. 종목 특정 실패한 목표들 가져오는 기능
  Future<List<TrainingGoalModel>> getFailedGoalsBySid(int sportID);

  // 10. due date가 지난 목표들 가져오는 기능
  Future<List<TrainingGoalModel>> getPastGoalsBySid(int sportID);

  // 11. 목표 삭제하기
  Future<bool> deleteTrainGoal(int goalID);

  // 12. 우선순위 바꾸기. (상단 고정하기)
  Future<bool> updatePriority(int threshold, int newPriority, int id);

  // 13. 성공여부를 성공으로 바꾸기
  Future<bool> updateSuccess(int goalID);

  // 14. 성공여부를 실패로 바꾸기
  Future<bool> updateFail(int goalID);

  // 15. 목표 하나 가져오기
  Future<TrainingGoalModel?> getOneGoal(int goalID);
}