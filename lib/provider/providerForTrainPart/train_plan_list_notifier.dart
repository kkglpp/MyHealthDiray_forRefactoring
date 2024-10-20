//달력에 계획들을 보여주기 위한 Provider
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Archive/training_plan_table_data_impl.dart';

final trainPlanListProvider =
    StateNotifierProvider<TrainPlanListNotifier, Map<DateTime, List<String>>>((ref) {
  TrainPlanListNotifier notifier = TrainPlanListNotifier({});
  notifier.initState();
  return notifier;
});


class TrainPlanListNotifier extends StateNotifier<Map<DateTime, List<String>>> {
  TrainPlanListNotifier(super.state);

  initState() async {
    TrainingPlanTableDataImpl db = TrainingPlanTableDataImpl();
    List<Map<String, dynamic>> rs = await db.getTrainingListEachDay();
    state = Map.from(mapListToMap(rs));
  }

  Map<DateTime, List<String>> mapListToMap(List<Map<String, dynamic>> list) {
    Map<DateTime, List<String>> result = {};
    for (var plan in list) {
      DateTime date = DateTime.parse(plan['tp_traindate']);
      String title = plan['tp_title'];
      if (result.containsKey(date)) {
        result[date]!.add(title);
      } else {
        result[date] = [title];
      }
    }
    return result;
  }
}
