import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/datasource/health_index_goal_table.dart';

import '../datasource/health_index_goal_table_impl.dart';
import '../../model/health_index_goal_model.dart';


final healthIndexGoalListProvider = StateNotifierProvider< IndexGoalListNotifier,List<HealthIndexGoalModel>>((ref){
IndexGoalListNotifier notifier = IndexGoalListNotifier([]);
notifier.initializeState();
return notifier;
});


class IndexGoalListNotifier extends StateNotifier<List<HealthIndexGoalModel>> {
  IndexGoalListNotifier(super.state);

  /// db에서 값 새로 불러오기.
  initializeState() async {
    HealthIndexGoalData dbhandler = HealthIndexGoalTableImpl();
    List<HealthIndexGoalModel> result = await dbhandler.getGoalList();
    state = List.from(result);
  }

  /// Goal 하나 삭제하는 함수
  deleteGoal(int id) async {
    HealthIndexGoalData handler = HealthIndexGoalTableImpl();
    await handler.deleteGoal(id);
    initializeState();
  }

  ///오름차순 내림차순 정리
  sortByDuedateASC() {
    List<HealthIndexGoalModel> tempList = state.toList();
    tempList.sort((a, b) {
      int priorityCompare = b.hgPriority.compareTo(a.hgPriority);
      if (priorityCompare != 0) {
        return priorityCompare; // priority가 다르면 여기서 리턴
      }
      DateTime dateA = DateTime.parse(a.hgDuedate);
      DateTime dateB = DateTime.parse(b.hgDuedate);
      return dateA.compareTo(dateB); // duedate 오름차순 정렬
    });

    state = List.from(tempList); // 정렬된 리스트 반환
  }

  sortByDuedateDESC() {
    List<HealthIndexGoalModel> tempList = state.toList();
    tempList.sort((a, b) {
      int priorityCompare = b.hgPriority.compareTo(a.hgPriority);
      if (priorityCompare != 0) {
        return priorityCompare; // priority가 다르면 여기서 리턴
      }
      DateTime dateA = DateTime.parse(a.hgDuedate);
      DateTime dateB = DateTime.parse(b.hgDuedate);
      return dateB.compareTo(dateA); // duedate 오름차순 정렬
    });

    state = tempList; // 정렬된 리스트 반환
  }
} //end class

