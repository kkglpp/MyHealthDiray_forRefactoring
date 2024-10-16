import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/Archive/healthIndexGoalTableData_impl.dart';


import '../baseModel/healthIndexGoal_model.dart';

final healthIndexGoalListProvider = StateNotifierProvider< IndexGoalListNotifier,List<HealthIndexGoalModel>>((ref){
IndexGoalListNotifier notifier = IndexGoalListNotifier([]);

return notifier;
});


class IndexGoalListNotifier extends StateNotifier<List<HealthIndexGoalModel>> {
  IndexGoalListNotifier(super.state);

  /// db에서 값 새로 불러오기.
  initializeState() async {
    HealthIndexGoalTableDataImpl dbhandler = HealthIndexGoalTableDataImpl();
    List<HealthIndexGoalModel> result = await dbhandler.getGoalList();
    state = List.from(result);
  }

  /// Goal 하나 삭제하는 함수
  deleteGoal(int id) async {
    HealthIndexGoalTableDataImpl handler = HealthIndexGoalTableDataImpl();
    await handler.deleteGoal(id);
    initializeState();
  }

  ///오름차순 내림차순 정리
  sortByDuedateASC() {
    List<HealthIndexGoalModel> tempList = state.toList();
    tempList.sort((a, b) {
      int priorityCompare = b.hg_priority.compareTo(a.hg_priority);
      if (priorityCompare != 0) {
        return priorityCompare; // priority가 다르면 여기서 리턴
      }
      DateTime dateA = DateTime.parse(a.hg_duedate);
      DateTime dateB = DateTime.parse(b.hg_duedate);
      return dateA.compareTo(dateB); // duedate 오름차순 정렬
    });

    state = List.from(tempList); // 정렬된 리스트 반환
  }

  sortByDuedateDESC() {
    List<HealthIndexGoalModel> tempList = state.toList();
    tempList.sort((a, b) {
      int priorityCompare = b.hg_priority.compareTo(a.hg_priority);
      if (priorityCompare != 0) {
        return priorityCompare; // priority가 다르면 여기서 리턴
      }
      DateTime dateA = DateTime.parse(a.hg_duedate);
      DateTime dateB = DateTime.parse(b.hg_duedate);
      return dateB.compareTo(dateA); // duedate 오름차순 정렬
    });

    state = tempList; // 정렬된 리스트 반환
  }
} //end class

