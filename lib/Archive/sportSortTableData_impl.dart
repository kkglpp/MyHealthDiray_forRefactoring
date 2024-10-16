/* 종목 분류 폴더와 종목간에서 각 종목이 어떤 폴더에 있는지 다루는 테이블 */

//0. db 시작하는 기능
//1. 다수의 row를 추가하는 기능 : 다수의 sf_id 와 s_id, s_name을 받아서 넣는다.
//2. row를 삭제하는 기능 : sf_id와 s_id를 받아서 둘다 이리하는 row를 지운다.
//3. 폴더명별로 조회하는 기능 : sf_id를 받아와서 해당 폴더에 들어있는 모든 ss_sport_id와 ss_sport_name을 가져온다.


import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../baseModel/sortedSport_model.dart';
import '../common/basicMethod.dart';

class SortSportTableDataImpl {
  final String _createSortSportStr = '''CREATE TABLE sort_sport(
      ss_sf_id INTEGER,
      ss_sport_id INTEGER,
      ss_sport_name TEXT,
      FOREIGN KEY (ss_sf_id) REFERENCES sport_folder (sf_id) ON UPDATE CASCADE ON DELETE CASCADE,
      FOREIGN KEY (ss_sport_id) REFERENCES sport (sport_id) ON UPDATE CASCADE
      UNIQUE(ss_sf_id, ss_sport_id)             
      );''';

  final String _insertRowStr = '''INSERT OR IGNORE INTO sort_sport(
  ss_sf_id,
  ss_sport_id,
  ss_sport_name
  )
  VALUES (?,?,?)
  ''';

  final String _deleteRowStr =
      "DELETE FROM sort_sport WHERE ss_sf_id = ? AND ss_sport_id =?";

  final String _getSortedSportStr = '''
SELECT
  ss_sf_id as sf_id,
  ss_sport_id as sport_id,
  ss_sport_name as sport_name
FROM sort_sport 
WHERE ss_sf_id=?
''';

  final String _deleteRowFromDeletedSport = ''' 
  DELETE FROM sort_sport WHERE ss_sport_id = ?;
  ''';

//0. db 시작하는 기능

  Future<Database> initializeTable() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'HealthLife.db'),
      onCreate: (db, version) async {
        await db.execute(_createSortSportStr);
      },
    );
  }

//1. 다수의 row를 추가하는 기능 : 다수의 sf_id 와 s_id, s_name을 받아서 넣는다.
  Future<bool> insertRow(SortSportModel row) async {
    final Database db = await initializeTable();
    int result = 0;

    try {
      result = await db.rawInsert(_insertRowStr, [modelToList(row.toMap())]);
      print("SportSortTableData -> Insert Rows result $result");
    } catch (e) {
      print("sortTable : $e");
      return false;
    }
          return true;
  }

  Future<bool> insertRows(List<SortSportModel> rowList) async {
    final Database db = await initializeTable();
    int result = 0;
    try {
      for (var row in rowList) {
        result = 0;
        print(row.toMap().toString());
        result = await db.rawInsert(_insertRowStr, modelToList(row.toMap()));
        
      }
    } catch (e) {
      print("tableImpl: $e");
      return false;
    }
      
    return true;
  }

//2. row를 삭제하는 기능 : sf_id와 s_id를 받아서 둘다 이리하는 row를 지운다.
  Future<bool> deleterow(int folderID, int sportID) async {
    final Database db = await initializeTable();
    int result = 0;
    try {
      result = await db.rawDelete(_deleteRowStr, [folderID, sportID]);
    } catch (e) {
      return false;
    }
          return true;
  }

//3. 폴더명별로 조회
  Future<List<SortSportModel>> getListSortedSport(int folderID) async {
    final Database db = await initializeTable();
    try {
      final List<Map<String, dynamic>> result =
          await db.rawQuery(_getSortedSportStr, [folderID]);
        
      return result.map((e) => SortSportModel.fromMap(e)).toList();
    } catch (e) {
              return [];
    }
  }


  //4. SportID가 일치하는 모든 row 삭제하기. 전체종목에서 지울떄 같이 해야한다.
  Future<bool> deleteAllRowFromSportID(int sportID) async{
    final Database db = await initializeTable();
    try{
      await db.rawDelete(_deleteRowFromDeletedSport,[sportID]);

    }catch(e){
      return false;

    }
    return true;
  }//end deletallrowFrom
}


