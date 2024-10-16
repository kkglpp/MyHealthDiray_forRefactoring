import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MakeDBImpl {
/* Entity 테이블 만드는 구문 정리 */

  //운동 종목 테이블 만드는 구문
  final String _createSport = '''CREATE TABLE sport(
      sport_id INTEGER PRIMARY KEY AUTOINCREMENT,
      sport_name TEXT,
      sport_metric1 TEXT,
      sport_metric2 TEXT,
      sport_description TEXT,
      sport_del INTEGER
      );''';
  //운동종목들을 사용자 마음대로 분류하기 위해 분류 폴더명을 넣는 테이블
  final String _createSportFolder = '''CREATE TABLE sport_folder(
      sf_id INTEGER PRIMARY KEY AUTOINCREMENT,
      sf_name TEXT
      );''';

/* Health Index 를 참조하는 relation 테이블 만드는 구문 정리 */

  //건강지표 달성 목표를 저장하기 위한 테이블
  final String _createHIgoal = '''CREATE TABLE hi_goal(
      hg_id INTEGER PRIMARY KEY AUTOINCREMENT,
      hg_height real,
      hg_weight real,
      hg_fat real,
      hg_muscle  real,
      hg_img blob,
      hg_duedate TEXT,
      hg_insertdate TEXT,
      hg_success INTEGER,
      hg_successdate TEXT,
      hg_priority INTEGER
      );''';
  //건강지표 기록을 저장하기 위한 릴레이션 테이블
  final String _createHIRec = '''CREATE TABLE hi_rec(
      hr_id INTEGER PRIMARY KEY AUTOINCREMENT,
      hr_height real,
      hr_weight real,
      hr_fat real,
      hr_muscle  real,
      hr_img blob,
      hr_insertdate TEXT      
      );''';
/* 운동 종목을 참조하는 relation 테이블을 만드는 구문 정리 */
  //위에서 만든 분류폴더명 테이블에 운동을 추가 및 수정 삭제 하기 위한 릴레이션 테이블
  final String _createSortSport = '''CREATE TABLE sort_sport(
      ss_sf_id INTEGER,
      ss_sport_id INTEGER,
      ss_sport_name TEXT,
      FOREIGN KEY (ss_sf_id) REFERENCES sport_folder (sf_id) ON UPDATE CASCADE ON DELETE CASCADE,
      FOREIGN KEY (ss_sport_id) REFERENCES sport (sport_id) ON UPDATE CASCADE
      UNIQUE(ss_sf_id, ss_sport_id)                 
      );''';
  //운동 수행 능력 목표를 저장하는 테이블
  final String _createTraingGoal = '''CREATE TABLE training_goal(
      tg_id INTEGER PRIMARY KEY AUTOINCREMENT,
      tg_s_id INTEGER,
      tg_goal1 real,
      tg_goal2 real,
      tg_duedate TEXT,
      tg_insertdate TEXT,
      tg_success INTEGER,
      tg_successdate TEXT,
      tg_priority INTEGER,
      FOREIGN KEY (tg_s_id) REFERENCES sport (sport_id) ON UPDATE CASCADE 
      );''';
  //운동 일정 계획을 저장하는 테이블
  final String _createTraingPlan = '''CREATE TABLE training_plan(
      tp_id INTEGER PRIMARY KEY AUTOINCREMENT,
      tp_title TEXT,
      tp_s_id INTEGER,
      tp_set INTEGER,
      tp_rec1 real,
      tp_rec2 real,
      tp_traindate TEXT,
      tp_done int,
      FOREIGN KEY (tp_s_id) REFERENCES sport (sport_id) ON UPDATE CASCADE 
      );''';
  //운동 수행 기록을 저장하는 테이블
  final String _createTraingRec = '''CREATE TABLE training_rec(
      tr_id INTEGER PRIMARY KEY AUTOINCREMENT,
      tr_title TEXT,
      tr_s_id INTEGER,
      tr_set INTEGER,
      tr_rec1 real,
      tr_rec2 real,
      tr_traindate TEXT,
      FOREIGN KEY (tr_s_id) REFERENCES sport (sport_id) ON UPDATE CASCADE 
      );''';

/* 그외 릴레이션 테이블을 만드는 구문 */
  //눈바디를 저장하기 위한 테이블
  final String _createBodyRec = '''CREATE TABLE body_rec(
      br_id INTEGER PRIMARY KEY AUTOINCREMENT,
      br_img blob,
      br_message TEXT,
      br_insertdate TEXT
      );''';
//모든 table을 만들기 위한 함수
  Future<bool> initializeAllTables() async {
    List createStrList = [
      _createSport,
      _createSportFolder,
      _createHIgoal,
      _createHIRec,
      _createSortSport,
      _createTraingGoal,
      _createTraingPlan,
      _createTraingRec,
      _createBodyRec
    ];
    String path = await getDatabasesPath();
    try {
      Database db = await openDatabase(
        join(path, 'HealthLife.db'),
        onCreate: (db, version) async {
          for (String str in createStrList) {
            await db.execute(str);
          }
        },
        version: 1,
      );
    } catch (e) {
      return false;
    }
    return true;
  } //class initializeAllTables



} //Class end
