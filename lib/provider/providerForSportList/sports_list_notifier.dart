import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../datasource/sport_sort_table_impl.dart';
import '../../datasource/sport_table_impl.dart';
import '../../model/sport_model.dart';

final wholeListStateProvider =
    StateNotifierProvider<SportListStateNotifier, List<SportModel>>((ref) {
  SportListStateNotifier notifier = SportListStateNotifier([]);
  notifier.setWholeList();
  return notifier;
});

class SportListStateNotifier extends StateNotifier<List<SportModel>> {
  SportListStateNotifier(super.state);

  setWholeList() async {
    SportTableImpl db = SportTableImpl();
    List<SportModel> temp = await db.getSportList();
    state = temp;
  }

  deleteSport(int sportID) async {
    SportTableImpl db = SportTableImpl();
    SortSportTableImpl db2 = SortSportTableImpl();
    bool rs = await db.deleteSport(sportID);
    if (rs == false) {
      return false;
    }
    rs = await db2.deleteAllRowFromSportID(sportID);

    if (rs == false) {
      return false;
    }

    return true;
  }
}
