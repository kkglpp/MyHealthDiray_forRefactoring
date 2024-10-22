import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/model/training_goal_model.dart';

import '../../datasource/training_goal_table_data_impl.dart';

final trainingGoalListPageProvider =
    StateNotifierProvider<TrainGoalListNotifier, List<TrainingGoalModel>>(
  (ref) {
    TrainGoalListNotifier notifier = TrainGoalListNotifier([]);
    notifier.initiateState();
    return notifier;
  },
);


class TrainGoalListNotifier extends StateNotifier<List<TrainingGoalModel>> {
  TrainGoalListNotifier(super.state);
  int amount = 10;

  List<TrainingGoalModel> successList =[];
  List<TrainingGoalModel> failList=[];
  List<TrainingGoalModel> progressList=[];

// 상태 새로고침
// 성공 / 실패/ 진행중인 목표 리스트를 각각만들어서 관리한다.
  setState() async {
    TrainingGoalTableDataImpl db = TrainingGoalTableDataImpl();
    successList = await db.getSuccessGoals(amount);
    failList = await db.getFailedGoals(amount);
    progressList = await db.getGoalList(amount);
    // print("list 가져오기?${progressList.length} ");
  }

  initiateState() async{
    await setState();
    showProgressList();
  }

  resetState() {
    amount = 10;
    initiateState();
  }

  moreList() async{
    amount+=10;
    setState();
  }

  showSuccessList(){
    state = successList;
  }
  showFailList(){
    state = failList;
  }
  showProgressList(){
    state = progressList;
  }


// 임박한 순서로 내림차순/오름차순 정리
  sortForASC() {
    List<TrainingGoalModel> tempList = state.toList();
    tempList.sort((a, b) {
      DateTime dateA = DateTime.parse(a.tgDueDate);
      DateTime dateB = DateTime.parse(b.tgDueDate);
      return dateA.compareTo(dateB);
    });
    state = tempList;
  }

  sortForDESC() {
    List<TrainingGoalModel> tempList = state.toList();
    tempList.sort((a, b) {
      DateTime dateA = DateTime.parse(a.tgDueDate);
      DateTime dateB = DateTime.parse(b.tgDueDate);
      return dateB.compareTo(dateA);
    });
    state = tempList;
  }

}//end class
