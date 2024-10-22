import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../datasource/sport_folder_table_data_impl.dart';
import '../../model/sport_folder_model.dart';


final folderListProvider =
    StateNotifierProvider<SportFolderListNotifier, List<SportFolderModel>>((ref) {
  SportFolderListNotifier notifier = SportFolderListNotifier([]);
  notifier.setState();

  return notifier;
});




class SportFolderListNotifier extends StateNotifier<List<SportFolderModel>> {
  SportFolderListNotifier(super.state);


  setState()async{
    SportFolderTableDataImpl db = SportFolderTableDataImpl();
    List <SportFolderModel> temp = await db.getSportFolder();
    state = temp;
  }


}
