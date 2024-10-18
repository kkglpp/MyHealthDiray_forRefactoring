import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Archive/sport_table_data_impl.dart';
import '../../baseModel/mapped_sport_model.dart';


//스포츠 아이디를 입력받
final sportInfoProvider =
    StateNotifierProviderFamily<SportMapStateNotifer, MappedSportModel, int>(
        (ref, sportID) {
  SportMapStateNotifer notifier = SportMapStateNotifer(
      MappedSportModel(sportName: "", metric1: "", metric2: ""),sportID);
  notifier.initState();
  return notifier;
});

// Map 으로 해도되지만 goal.xxx 이렇게 쓸 수 있도록.
// 스포츠 아이디당 하나가 만들어지니까, 딱히 무거워지지는 않지 않지 않지     않을까?
//                                         안무겁 무겁 안무겁    여기는 마무리라 부정의미 없음.
class SportMapStateNotifer extends StateNotifier< MappedSportModel> {
  final int sportID;
  SportMapStateNotifer(super.state, this.sportID);


  initState() async {
    SportTableImpl db = SportTableImpl();
    String sportName = await db.getSportName(sportID);
    String metric1 = await db.getSportMetric1(sportID);
    String metric2 = await db.getSportMetric2(sportID);
    state = MappedSportModel(
      sportName: sportName,
      metric1: metric1,
      metric2: metric2,
    );
  }

}