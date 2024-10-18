import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Archive/sport_sort_table_data_impl.dart';
import '../Archive/sport_table_data_impl.dart';
import '../baseModel/sport_model.dart';


final wholeListStateProvider = StateNotifierProvider<SportListStateNotifier,List<SportModel>>((ref) {
  SportListStateNotifier notifier = SportListStateNotifier([]);
  notifier.setWholeList();
  return notifier;
});



class SportListStateNotifier extends StateNotifier <List<SportModel>>{
  SportListStateNotifier(super.state);

  setWholeList() async {
    SportTableImpl db = SportTableImpl();
    List<SportModel> temp = await db.getSportList();
    state = temp;
  }

  deleteSport(int sportID)async{
    SportTableImpl db = SportTableImpl();
    SortSportTableDataImpl sortedDb = SortSportTableDataImpl();
    bool rs = await db.deleteSport(sportID);
    if (rs == false){
      return false;
    }
    rs = await sortedDb.deleteAllRowFromSportID(sportID);

   if (rs == false){
      return false;
    }
    
    return true;
  }


}