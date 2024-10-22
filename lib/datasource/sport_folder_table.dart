import 'package:sqflite/sqlite_api.dart';

import '../model/sport_folder_model.dart';

abstract class SportFolderTable {
  // 0. db 시작하는 기능
  Future<Database> initializeTable();

  // 1. 폴더 추가 기능
  Future<bool> insertSportFolder(SportFolderModel folder);

  // 2. 폴더 지우는 기능
  Future<bool> deleteSportFolder(int id);

  // 3. 폴더 리스트를 가져오는 기능
  Future<List<SportFolderModel>> getSportFolder();

  // 4. 폴더명 바꾸는 기능
  Future<bool> updateSportFolder(int id, String name);
}