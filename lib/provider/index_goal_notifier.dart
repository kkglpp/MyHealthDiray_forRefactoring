import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Archive/health_index_goal_table_data_impl.dart';
import '../baseModel/health_index_goal_model.dart';
import '../common/const/basic_method.dart';

final insertIndexGoalModelProvider =
    StateNotifierProvider<IndexGoalNotifier, HealthIndexGoalModel?>((ref) {
  IndexGoalNotifier notifier = IndexGoalNotifier(null);
  notifier.initForInsertModel();
  return notifier;
});

final indexGoalModelProvider = StateNotifierProviderFamily<IndexGoalNotifier, HealthIndexGoalModel?,int>((ref,id){
  IndexGoalNotifier notifier = IndexGoalNotifier(null);
  // print("model id : $id");
  notifier.initForDetail(id);
  return notifier;

});

// HealthIndex insertView 와 detailView에서 모두 사용하는 notifier 이다.

class IndexGoalNotifier extends StateNotifier<HealthIndexGoalModel?> {
  IndexGoalNotifier(super.state);
  // 상태를 기록해둘 초기 값이다.
  HealthIndexGoalModel sampleModel = HealthIndexGoalModel(
    hgId: 0,
    hgHeight: 170,
    hgWeight: 70,
    hgFat: 30,
    hgMuscle: 40,
    hgImg: null,
    hgDuedate: onlyDay(DateTime.now()),
    hgSuccess: 0,
    hgSuccessdate: onlyDay(DateTime.now()),
    hgPriority: 0,
  );

    initForDetail(int id)async{
    HealthIndexGoalTableDataImpl db = HealthIndexGoalTableDataImpl();
    
    HealthIndexGoalModel? temp = await db.getGoal(id);
    if(temp==null){
      state= sampleModel.copyWith();
    }
    state = temp;
  }


//InsertView 를 위해서 사용하는 Method 파트.
//초기값을 sampleModel로 설정하는 메소드이다.
  initForInsertModel(){
    state = sampleModel.copyWith();
  }
//각 값들을 변경하는 메소드 들이다.
  changedHeight(double newValue) {
    state = state!.copyWith(hgHeight: newValue);
  }

  changedWeight(double newValue) {
    state = state!.copyWith(hgWeight: newValue);
  }

  changedFat(double newValue) {
    state = state!.copyWith(hgFat: newValue);
  }

  changedMuscle(double newValue) {
    state = state!.copyWith(hgMuscle: newValue);
  }

  changedDuedate(String newValue) {
    state = state!.copyWith(hgDuedate: newValue);
  }

  Future<bool> insertHealthGoal() async {
    // print(state!.toMap().toString());
    // return false;
    HealthIndexGoalTableDataImpl db = HealthIndexGoalTableDataImpl();
    try{
    bool result = await db.insertGoal(state!);
    return result;
    }catch(e){
      // print(e);
      return false;
    }
  }
 Future<bool> updateSuccess(bool success) async {
    HealthIndexGoalTableDataImpl db = HealthIndexGoalTableDataImpl();
    bool result = false;
    if (success) {
      result = await db.goalSuccess(state!.hgId!, onlyDay(DateTime.now()));
    } else {
      result = await db.failSuccess(state!.hgId!, onlyDay(DateTime.now()));
    }
    return result;
  }

}//end class