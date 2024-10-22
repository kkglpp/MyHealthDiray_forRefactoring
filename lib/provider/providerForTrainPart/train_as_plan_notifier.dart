import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../datasource/training_plan_table_impl.dart';

part 'train_as_plan_notifier.g.dart';

@riverpod
class TrainAsPlanNotifier extends _$TrainAsPlanNotifier {
  @override
  Future<List<Map<String, dynamic>>> build() async {
    return await getList();
  } //end Build함수

  setState() async {
    // List<Map<String,dynamic>> temp = (state as AsyncData).value;
    //state 상태 바꿔주고
    state = const AsyncLoading();
    //db 새로 읽어오고
    List<Map<String, dynamic>> temp = await getList();
    // 상태 최신화.
    state = AsyncData(temp);
  }

  //어제 , 오늘 , 내일 3일치 기록을 가져온다.
  Future<List<Map<String, dynamic>>> getList() async {
    TrainingPlanTableDataImpl db = TrainingPlanTableDataImpl();
    return await db.getTitlesPerdayForPeriod();
  }

  // List<Map<DateTime ,title>>
  // Map<DateTime, List<String>> mapListToMap(List<Map<String, dynamic>> list) {
  //   Map<DateTime, List<String>> result = {};
  //   for (var plan in list) {
  //     DateTime date = DateTime.parse(plan['tpTrainDate']);
  //     String title = plan['tpTitle'];
  //     if (result.containsKey(date)) {
  //       result[date]!.add(title);
  //     } else {
  //       result[date] = [title];
  //     }
  //   }
  //   return result;
  // }
}//end Class