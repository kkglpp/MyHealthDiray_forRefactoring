import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../datasource/sport_table_impl.dart';
import '../../model/sport_model.dart';

final stateForNewSportProvider =
    StateNotifierProvider<SportStateNotifier, SportModel?>((ref) {
  final SportStateNotifier notifier = SportStateNotifier(null);
  notifier.initialStateForAdd();
  return notifier;
});

class SportStateNotifier extends StateNotifier<SportModel?> {
  SportStateNotifier(super.state);

  //새로운 sport를 입력하기 위한 기능들
  initialStateForAdd() {
    state = SportModel(
      sportId: 0,
      sportDel: 0,
      sportName: "",
      sportMetric1: "",
      sportMetric2: "",
      sportDescription: "",
    );
  }

  changeName(String? newName) {
    SportModel temp = state!.copyWith(sportName: newName ?? "");
    state = temp;
  }

  changeMetric1(String? newMetric) {
    SportModel temp = state!.copyWith(sportMetric1: newMetric ?? "");
    state = temp;
  }

  changeMetric2(String? newMetric) {
    SportModel temp = state!.copyWith(sportMetric2: newMetric ?? "");
    state = temp;
  }

  // setDescription(String newDescription) {
  //   SportModel temp = state!.copyWith(metric2: newDescription);
  //   state =temp;
  // }
  /// 여러가지 오류처리를 해야해서 int를 리턴받는다.
  /// 0 : 이름 미기입
  /// 1 : 성공
  /// 2 :db 오류
  Future<int> insertToDatabase() async {
    SportTableImpl db = SportTableImpl();
    if (state!.sportName == "") {
      return 0;
    }
    if (state!.sportMetric1 == "") {
      SportModel temp = state!.copyWith(sportMetric1: " ");
      state = temp;
    }
    if (state!.sportMetric2 == "") {
      SportModel temp = state!.copyWith(sportMetric2: " ");
      state = temp;
    }
    bool result = await db.insertSport(state!);
    if (!result) {
      return 2;
    }
    return 1;
  }
}//end class
