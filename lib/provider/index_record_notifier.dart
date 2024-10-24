import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'health_index_rec_table_data_impl.dart';
import '../../model/health_index_record_model.dart';
import '../../common/const/basic_method.dart';


final indexRecModelProvider= StateNotifierProviderFamily<IndexRecordNotifier, HealthIndexRecordModel?,int>((ref, id){
  IndexRecordNotifier notifier =  IndexRecordNotifier(null);
  notifier.initState(id);
  return notifier;

});

class IndexRecordNotifier extends StateNotifier<HealthIndexRecordModel?> {
  IndexRecordNotifier(super.state);

  HealthIndexRecordModel sampleModel = HealthIndexRecordModel(
  hrId: 0,
  hrHeight: 170,
  hrWeight: 70,
  hrFat: null,
  hrMuscle: null,
  hrImg: null,
  hrInsertDate: onlyDay(DateTime.now()),
);

  initState(int id)async{
    HealthIndexRecTableDataImpl db = HealthIndexRecTableDataImpl();
    HealthIndexRecordModel? model;
    model = await db.getOneRecord(id);
    if (model == null) {
      setNullState();
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
    bool result = await db.deleteHIRec(state!.hrId!);
    return result;
  }



}//end class
