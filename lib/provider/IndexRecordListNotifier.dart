import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/baseModel/healthIndexRecord_model.dart';

import '../Archive/healthIndexRecTableData_impl.dart';

final IndexRecordsStateProvider = StateNotifierProvider<IndexRecordsListNotifier,List<HealthIndexRecordModel>  >((ref) {
  IndexRecordsListNotifier notifier = IndexRecordsListNotifier([]);
  return notifier;
});

class IndexRecordsListNotifier
    extends StateNotifier<List<HealthIndexRecordModel>> {
  IndexRecordsListNotifier(super.state);
  int amount = 10;

  ///state를 새로고침 하는 함수.
  initializeState() async {
    HealthIndexRecTableDataImpl db = HealthIndexRecTableDataImpl();
    List<HealthIndexRecordModel> temp = await db.getRecords(amount);
    state = List.from(temp);
  }


  /// 10개 더 가져오기
  moreList() async {
    amount += 10;
    await initializeState();
  }
  /// 다시 10개만 보기
  resetLsit() async{
    amount =10;
    await initializeState();
  }

  /// dissmiss해서 하나 지우는 함수
  deleteRec(int id) async {
    HealthIndexRecTableDataImpl db = HealthIndexRecTableDataImpl();
    await db.deleteHIRec(id);
    initializeState();
  }
    ///정렬1 Desc
    sortByInsertdateDESC() {
    List<HealthIndexRecordModel> tempList = state.toList();
    tempList.sort((a, b) {
      int aID = a.hr_id!;
      int bID = b.hr_id!;
      return bID.compareTo(aID); // 
    });
    state=tempList;
  }
  ///정렬1 ASC
  sortByInsertdateASC() {
    List<HealthIndexRecordModel> tempList = state.toList();
    tempList.sort((a, b) {
      int aID = a.hr_id!;
      int bID = b.hr_id!;
      return aID.compareTo(bID); // 
    });
    state=tempList;
  }


}//endClass
