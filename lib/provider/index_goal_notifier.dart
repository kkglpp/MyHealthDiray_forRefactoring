import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Archive/health_index_goal_table_data_impl.dart';
import '../baseModel/health_Index_goal_model.dart';
import '../common/basic_method.dart';

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
    hg_id: 0,
    hg_height: 170,
    hg_weight: 70,
    hg_fat: 30,
    hg_muscle: 40,
    hg_img: null,
    hg_duedate: onlyDay(DateTime.now()),
    hg_success: 0,
    hg_successdate: onlyDay(DateTime.now()),
    hg_priority: 0,
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
    state = state!.copyWith(hg_height: newValue);
  }

  changedWeight(double newValue) {
    state = state!.copyWith(hg_weight: newValue);
  }

  changedFat(double newValue) {
    state = state!.copyWith(hg_fat: newValue);
  }

  changedMuscle(double newValue) {
    state = state!.copyWith(hg_muscle: newValue);
  }

  changedDuedate(String newValue) {
    state = state!.copyWith(hg_duedate: newValue);
  }

  Future<bool> insertHealthGoal() async {
    print(state!.toMap().toString());
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
      result = await db.goalSuccess(state!.hg_id!, onlyDay(DateTime.now()));
    } else {
      result = await db.failSuccess(state!.hg_id!, onlyDay(DateTime.now()));
    }
    return result;
  }

}//end class