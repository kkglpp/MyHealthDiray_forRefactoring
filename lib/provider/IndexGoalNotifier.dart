import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/Archive/healthIndexGoalTableData_impl.dart';
import 'package:myhealthdiary_app/baseModel/healthIndexGoal_model.dart';
import 'package:myhealthdiary_app/common/basicMethod.dart';

final InsertIndexGoalModelProvider =
    StateNotifierProvider<IndexGoalNotifier, HealthIndexGoalModel?>((ref) {
  IndexGoalNotifier notifier = IndexGoalNotifier(null);
  notifier.initForInsertModel();
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
      print(e);
      return false;
    }

  }

}//end class