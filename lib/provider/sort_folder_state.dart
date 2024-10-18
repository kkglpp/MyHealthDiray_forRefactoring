import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Archive/sport_folder_table_data_impl.dart';
import '../baseModel/sport_folder_model.dart';



final sortFolderStateProvider = StateNotifierProvider <SortFolderNotifier,SportFolderModel>((ref) {
  SportFolderModel sampleModel = SportFolderModel(sfName: "폴더명", sfId: 0);
  SortFolderNotifier notifier = SortFolderNotifier(sampleModel);
  return notifier;
});

final folderStateForDeleteProvider = StateNotifierProviderFamily <SortFolderNotifier,SportFolderModel,int>((ref,id) {
  SportFolderModel sampleModel = SportFolderModel(sfName: "폴더명", sfId: id);
  SortFolderNotifier notifier = SortFolderNotifier(sampleModel);
  return notifier;
});


class SortFolderNotifier extends StateNotifier<SportFolderModel>{
  SortFolderNotifier(super.state);
  SportFolderModel sampleModel = SportFolderModel(sfName: "폴더명", sfId: 0);

  setSampleModel(){
    state = sampleModel;
  }

  changeFolderName(String newName){
    if(newName.trim() == ""){
      state = state.copyWith(sfName: "폴더명");
      return;
    }
    state = state.copyWith(sfName: newName);
  }

  saveFolder()async{
    SportFolderTableDataImpl db = SportFolderTableDataImpl();
    bool rs = await db.insertSportFolder(state);
    return rs;
  }

    Future<bool> deleteFolder()async{
    SportFolderTableDataImpl db = SportFolderTableDataImpl();
    bool rs = await db.deleteSportFolder(state.sfId!);
    return rs;
  }

}