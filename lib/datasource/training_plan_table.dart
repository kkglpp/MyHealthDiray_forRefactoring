import 'package:myhealthdiary_app/model/training_plan_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class TrainingPlanTableData {
  // 0. DB 여는 기능
  Future<Database> initializeTable();

  // insert
  /// 1. 여러 row를 한번에 입력하는 기능
  Future<bool> insertMultipleTrainingPlans(List<TrainingPlanModel> plans);

  // update
  /// 2. done을 Update하는 기능
  Future<bool> updateDone(int done, int id);

  // Query
  /// 4. 특정 기간의 운동 계획 가져오기 (하루 포함)
  // Future<List<TrainingPlanModelForDailyList>> getDayPlanSummary(String date01, String date02, int limit);

  /// 5. 타이틀과 날짜 가지고 그날 운동 계획 종목들을 가져온다.
  Future<List<PlanListOfPlanSet>> getDaysPlanSportList(String title, String date);

  /// 6. 5에서 가져온 정보에서 각 s_id 들을 통해서 가져올 수 있어야한다.
  Future<List<TrainingPlanModel>> getDaysEachSportPlan(String title, int sportID, String date);

  // DELETE
  /// 7. 한 row를 삭제하는 기능 (trainingPlan ID)
  Future<bool> deleteOnePlan(int id);

  /// 8. 제목과 날짜를 받아서 해당 row 삭제하는 기능
  Future<bool> deleteDayPlan(String title, String date);

  /// 9. 제목과 날짜와 종목을 받아서 삭제하는 기능
  Future<bool> deleteDaySpecificSport(String title, String date, int sportID);

  Future<List<Map<String, dynamic>>> getTrainingListEachDay();

  Future<List<Map<String, dynamic>>> getTitlesPerdayForPeriod();
}