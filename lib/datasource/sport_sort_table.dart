import 'package:myhealthdiary_app/model/sorted_sport_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class SportSortTable {
  // 0. db 시작하는 기능
  Future<Database> initializeTable();

  // 1. 다수의 row를 추가하는 기능 : 다수의 sf_id와 s_id, s_name을 받아서 넣는다.
  Future<bool> insertRow(SortSportModel row);
  
  Future<bool> insertRows(List<SortSportModel> rowList);

  // 2. row를 삭제하는 기능 : sf_id와 s_id를 받아서 둘 다 일치하는 row를 지운다.
  Future<bool> deleteRow(int folderID, int sportID);

  // 3. 폴더명별로 조회
  Future<List<SortSportModel>> getListSortedSport(int folderID);

  // 4. SportID가 일치하는 모든 row 삭제하기. 전체 종목에서 지울 때 같이 해야한다.
  Future<bool> deleteAllRowFromSportID(int sportID);
}