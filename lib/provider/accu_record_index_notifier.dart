import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:myhealthdiary_app/provider/health_index_rec_table_data_impl.dart';


// 누적된 이미지 기록을 보여주기 위한 provider
final accuImageNotifierProvider =
    StateNotifierProvider<AccuRecordsIndexNotifier, List<dynamic>>(
  (ref) {
    AccuRecordsIndexNotifier notifier = AccuRecordsIndexNotifier([],'img');
    notifier.initializeState();
    return notifier;
  },
);
// 누적된 신장 기록을 보여주기 위한 provider
final accuHeightNotifierProvider =
    StateNotifierProvider<AccuRecordsIndexNotifier, List<dynamic>>(
  (ref) {
    final notifier = AccuRecordsIndexNotifier([],'height');
    notifier.initializeState();
    return notifier;
  },
);
// 누적된 몸무게 기록을 보여주기 위한 provider
final accuWeightNotifierProvider =
    StateNotifierProvider<AccuRecordsIndexNotifier, List<dynamic>>(
  (ref) {
    final notifier = AccuRecordsIndexNotifier([],'weight');
    notifier.initializeState();
    return notifier;
  },
);
// 누적된 체지방율 기록을 보여주기 위한 provider
final accuFatNotifierProvider =
    StateNotifierProvider<AccuRecordsIndexNotifier, List<dynamic>>(
  (ref) {
    final notifier = AccuRecordsIndexNotifier([],'fat');
    notifier.initializeState();
    return notifier;
  },
);
// 누적된 근육량 기록을 보여주기 위한 provider
final accuMuscleNotifierProvider =
    StateNotifierProvider<AccuRecordsIndexNotifier, List<dynamic>>(
  (ref) {
    final notifier = AccuRecordsIndexNotifier([],'muscle');
    notifier.initializeState();
    return notifier;
  },
);

final accuInsertDateNotifierProvider =
    StateNotifierProvider<AccuRecordsIndexNotifier, List<dynamic>>(
  (ref) {
    final notifier = AccuRecordsIndexNotifier([],'insertdate');
    notifier.initializeState();
    return notifier;
  },
);


/// 그래프 그리기 위해 누적기록을 List 형태로 가져오는 것.
/// dynamic 인 이유는 img / String 도 있어서.
class AccuRecordsIndexNotifier extends StateNotifier <List<dynamic>>{
  final String type;
  AccuRecordsIndexNotifier(super.state, this.type);

int recNumber = 10;

  initializeState() async {
    recNumber = 10;
    List<dynamic> result = await getDataList();
    state = result;
  }

  showMoreRec() async {
    recNumber += 10;
    state = await getDataList();
  }

  refreshState() async {
    List<dynamic> result = await getDataList();
    state = result;
  }

  Future getDataList() async {
    HealthIndexRecTableDataImpl db = HealthIndexRecTableDataImpl();
    List<dynamic> result;
    if (type == "img") {
      final imgDataList = await db.getOneIndexRecords(type, recNumber);
      result = imgDataList.map((e) => Image.memory(e)).toList();
    } else {
      result = await db.getOneIndexRecords(type, recNumber);
    }
    return result;
  }

}//end class