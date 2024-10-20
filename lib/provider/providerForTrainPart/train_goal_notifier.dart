import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/baseModel/training_goal_model.dart';
import 'package:myhealthdiary_app/provider/providerForShared/collection_of_basic_state_provider.dart';

import '../../Archive/training_goal_table_data_impl.dart';
import '../../common/const/basic_method.dart';

//ID값이 0 이면 insert를 위한것.

//SportID는 항상있다.
//tg ID 가 0 이면 새로운 목록 만들기이다.
final addTrainGoalProvier =
    StateNotifierProvider<TrainGoalNotifier, TrainingGoalModel>((ref) {
  TrainingGoalModel sampleModel = TrainingGoalModel(
    tgId: 0,
    tgSId: 0,
    tgGoal1: 0,
    tgGoal2: 0,
    tgDueDate: onlyDay(DateTime.now().add(const Duration(days: 30))),
    tgInsertDate: onlyDay(DateTime.now()),
    tgSuccess: 0,
    tgSuccessDate: onlyDay(DateTime.now()),
    tgPriority: 0,
  );
  int sportID = ref.watch(showSportIdProvider);
  TrainGoalNotifier notifier = TrainGoalNotifier(sampleModel);
  notifier.sportID = sportID;
  notifier.initiateState();
  return notifier;
});

final trainGoalProvider =
    StateNotifierProviderFamily<TrainGoalNotifier, TrainingGoalModel, int >((ref, goalID) {
  TrainingGoalModel sampleModel = TrainingGoalModel(
    tgId: goalID,
    tgSId: 0,
    tgGoal1: 0,
    tgGoal2: 0,
    tgDueDate: onlyDay(DateTime.now().add(const Duration(days: 30))),
    tgInsertDate: onlyDay(DateTime.now()),
    tgSuccess: 0,
    tgSuccessDate: onlyDay(DateTime.now()),
    tgPriority: 0,
  );
  TrainGoalNotifier notifier = TrainGoalNotifier(sampleModel);
  notifier.initiateState();
  return notifier;
});

// 운동 목표 1개의 상태를 관리하는 Notifier
//
class TrainGoalNotifier extends StateNotifier<TrainingGoalModel> {
  TrainGoalNotifier(super.state);
  int sportID = 0;

  //insertTrainingGoalProvider를 초기화 할때 써야하는 smapleModel 이다.
  TrainingGoalModel sampleModel = TrainingGoalModel(
    tgId: 0,
    tgSId: 0,
    tgGoal1: 0,
    tgGoal2: 0,
    tgDueDate: onlyDay(DateTime.now().add(const Duration(days: 30))),
    tgInsertDate: onlyDay(DateTime.now()),
    tgSuccess: 0,
    tgSuccessDate: onlyDay(DateTime.now()),
    tgPriority: 0,
  );

  initiateState() async {
    //state 가 null 이거나 id 가 0 이면 샘플모델을 넣는다. (isnert 에서사용)
    if (state.tgId == 0) {
      state = sampleModel.copyWith(tgSId: sportID);
      return;
    }
    //detail 들어가고 나갈떄 사용
    TrainingGoalTableDataImpl db = TrainingGoalTableDataImpl();
    TrainingGoalModel? temp = await db.getOneGoal(state.tgId!);
    state = temp ?? sampleModel;
  }

  changeDueDate(DateTime newDate) {
    state = state.copyWith(tgDueDate: onlyDay(newDate));
  }

  changeGoal1(double newGoal) {
    state = state.copyWith(tgGoal1: newGoal);
  }

  changeGoal2(double newGoal) {
    state = state.copyWith(tgGoal2: newGoal);
  }

  Future<bool> saveGoal() async {
    TrainingGoalTableDataImpl db = TrainingGoalTableDataImpl();
    // print(modelToList(state.toMap()).sublist(1));
    bool rs = await db.insertTrainGoal(state);
    return rs;
  }

  Future<bool> deleteGoal() async {
    TrainingGoalTableDataImpl db = TrainingGoalTableDataImpl();
    bool rs = await db.deleteTrainGoal(state.tgId!);
    return rs;
  }

  Future<bool> updateSuccess() async {
    TrainingGoalTableDataImpl db = TrainingGoalTableDataImpl();
    bool rs = await db.updateSuccess(state.tgId!);
    return rs;
  }

  Future<bool> updateFail() async {
    TrainingGoalTableDataImpl db = TrainingGoalTableDataImpl();
    bool rs = await db.updateFail(state.tgId!);
    return rs;
  }
}
