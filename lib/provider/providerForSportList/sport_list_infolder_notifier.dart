import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../datasource/sport_sort_table_impl.dart';
import '../../datasource/sport_table_impl.dart';
import '../../model/sorted_sport_model.dart';
import '../../model/sport_model.dart';



final sportListInFolderStateProvider = StateNotifierProviderFamily<SportListInFolderNotifier,List<SortSportModel>,int>((ref, folderID) {
  SportListInFolderNotifier notifier = SportListInFolderNotifier([]);
  notifier.folderId = folderID;
  notifier.getSportInFolder();
  return notifier;
});

// 각 폴더에 추가하고 제거할떄, 지정 폴더에 없는 List를 관리하기 위함.
final wholeListForAddInFolder = StateNotifierProvider<SportListInFolderNotifier,List<SortSportModel>>((ref){

  SportListInFolderNotifier notifier = SportListInFolderNotifier([]);
  // 전체 sportsList를 가져오자. SortedSportModel 형태로 가져오고 folderID를 0으로 통일해서 가져오자.
  notifier.getAllSportsFormed();

return notifier;
});

final tempStateProviderForEditFolder = StateNotifierProviderFamily<SportListInFolderNotifier,List<SortSportModel>,int>((ref, folderID) {
  SportListInFolderNotifier notifier = SportListInFolderNotifier([]);
  notifier.folderId = folderID;
  notifier.getSportInFolder();
  return notifier;
});

class SportListInFolderNotifier extends StateNotifier <List<SortSportModel>>{
  SportListInFolderNotifier(super.state);
  int folderId =0;

  getSportInFolder()async{
    SortSportTableImpl db = SortSportTableImpl();
    List<SortSportModel> temp = await db.getListSortedSport(folderId);
    state = temp;
  }

  // 전체 스포츠 리스트를 SortSportModel 형태로 가져온것.
  getAllSportsFormed()async{
    SportTableImpl db = SportTableImpl();
    List<SportModel> result = await db.getSportList();
    List<SortSportModel> temp =[] ;
    for(SportModel model in result){
      temp.add(SortSportModel(sfId: 0, sportId:model.sportId!, sportName: model.sportName));
    }
    state = temp;
  }

  //tempStateProvider 에다가 스포츠 모델을 추가하는 함수
  addSportInState(SortSportModel model)async{
    List<SortSportModel> tempList = List.from(state);
    addWithoutDuplicate(tempList,model.copyWith(sfId: folderId) );
    state = tempList;
  }

  //tempStateProvider 에서 스포츠 모델을 제거하는 함수.
addWithoutDuplicate(List<SortSportModel> list, SortSportModel newItem) {
  if (!list.contains(newItem)) {
    list.add(newItem);
  }
}
//tempStateProvier 를 초기화 시키는 함수
resetTempState(){
  state = [];
}

removeSportFromTempFolder(SortSportModel model) async {
    List<SortSportModel> tempList = List.from(state);
    tempList.removeWhere((exist) => exist.sportId == model.sportId);
    state = tempList;
}

insertListIntoTable()async{
  SortSportTableImpl db = SortSportTableImpl();
  bool rs = await db.insertRows(state);
  return rs;
}


} //end class