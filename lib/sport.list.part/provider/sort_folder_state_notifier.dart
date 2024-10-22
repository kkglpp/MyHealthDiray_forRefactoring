import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../datasource/sport_folder_table_data_impl.dart';
import '../../model/sport_folder_model.dart';



final sortFolderStateProvider = StateNotifierProvider <SortFolderStateNotifier,SportFolderModel>((ref) {
  SportFolderModel sampleModel = SportFolderModel(sfName: "폴더명", sfId: 0);
  SortFolderStateNotifier notifier = SortFolderStateNotifier(sampleModel);
  return notifier;
});

final folderStateForDeleteProvider = StateNotifierProviderFamily <SortFolderStateNotifier,SportFolderModel,int>((ref,id) {
  SportFolderModel sampleModel = SportFolderModel(sfName: "폴더명", sfId: id);
  SortFolderStateNotifier notifier = SortFolderStateNotifier(sampleModel);
  return notifier;
});


class SortFolderStateNotifier extends StateNotifier<SportFolderModel>{
  SortFolderStateNotifier(super.state);
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