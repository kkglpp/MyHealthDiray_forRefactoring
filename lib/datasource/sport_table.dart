import 'package:myhealthdiary_app/model/sport_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class SportTable {
  // 0. db를 여는 함수.
  Future<Database> initializeTable();

  // 1. 종목 추가하기
  Future<bool> insertSport(SportModel sport);

  // 2. 종목 리스트 가져오기
  Future<List<SportModel>> getSportList();

  // 2.1 종목을 map으로 가져오기
  Future<Map<int, String>> getSportMap();

  // 2.2 Metric1 가져오기
  Future<Map<int, String>> getMetric1Map();

  // 2.3 Metric2 가져오기
  Future<Map<int, String>> getMetric2Map();

  // 3. 종목 삭제하기
  Future<bool> deleteSport(int id);

  // 4. 한 종목의 정보 가져오기
  Future<SportModel?> getSport(int id);

  // 5. 종목 설명 수정하기. (Description)
  Future<bool> updateSport(String description, int id);
}