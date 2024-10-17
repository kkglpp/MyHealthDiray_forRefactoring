import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/Archive/healthIndexRecTableData_impl.dart';
import 'package:myhealthdiary_app/baseModel/healthIndexRecord_model.dart';
import 'package:myhealthdiary_app/common/basicMethod.dart';


final IndexRecModelProvider= StateNotifierProviderFamily<IndexRecordNotifier, HealthIndexRecordModel?,int>((ref, id){
  IndexRecordNotifier notifier =  IndexRecordNotifier(null);
  notifier.initState(id);
  return notifier;

});

class IndexRecordNotifier extends StateNotifier<HealthIndexRecordModel?> {
  IndexRecordNotifier(super.state);

  HealthIndexRecordModel sampleModel = HealthIndexRecordModel(
    hr_id: 0,
    hr_height: 170,
    hr_weight: 70,
    hr_fat: null,
    hr_muscle: null,
    hr_img: null,
    hr_insertdate: onlyDay(DateTime.now()),
  );

  initState(int id)async{
    HealthIndexRecTableDataImpl db = HealthIndexRecTableDataImpl();
    HealthIndexRecordModel? model;
    model = await db.getOneRecord(id);
    print(model ==null);
    if (model == null) {
      setNullState();
      print(state.toString());
      return ;
    }
    state = model.copyWith();
  }

  setNullState(){
    state = sampleModel.copyWith();
  }

  changedHeight(double newValue) {

    state = state!.copyWith(height: newValue);
  }

  changedWeight(double newValue) {
    state = state!.copyWith(weight: newValue);
  }

  changedFat(double newValue) {
    state = state!.copyWith(fat: newValue);
  }

  changedMuscle(double newValue) {
    state = state!.copyWith(muscle: newValue);
  }

  changedInsertdate(String newValue) {
    state = state!.copyWith(insertdate: newValue);
  }
  insertNewRec()async {
    HealthIndexRecTableDataImpl db = HealthIndexRecTableDataImpl();
    bool result = await db.insertHIRec(state!);
    return result;
  }

  deleteRec()async{
    HealthIndexRecTableDataImpl db = HealthIndexRecTableDataImpl();
    bool result = await db.deleteHIRec(state!.hr_id!);
    return result;
  }



}//end class
