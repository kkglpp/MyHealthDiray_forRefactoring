import 'package:myhealthdiary_app/provider/providerForShared/collection_of_basic_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../Archive/training_plan_table_data_impl.dart';
import '../../baseModel/training_plan_model.dart';
import '../../common/const/basic_method.dart';

part 'train_plan_add_new_sport_notifier.g.dart';

@riverpod
class TrainPlanAddNewSportNotifier extends _$TrainPlanAddNewSportNotifier {
  //Field
  int sportID = 0;
  String title = "";
  int setNum = 0; //새로 추가할 세트가 temp 내에서 몇번째인지 (temp.length+1 해도 되긴함)
  String trainDate = onlyDay(DateTime.now());
  //기존에 갖고 있는 운동 리스트
  List<TrainingPlanModel> preTemp = [];
  //새로 추가할 운동들을 갖고 있는 리스트
  List<TrainingPlanModel> temp = [];

/*
기존에 갖고있는 운동 리스트와 
새로 추가할 운동들을 갖고있는 리스트를 별개로 관리한다.
- 버튼을 통해 set 수를 조절하기 때문에, 기존에 등록한 셋트를 삭제하기로 넘어가면 삭제 기능을 실행해야한다.
- 나중에 구현할거다.
*/

//Method
  @override
  Future<List<TrainingPlanModel>> build() async {
    //SportID를 셋팅한다.
    sportID = ref.read(showSportIdProvider.notifier).state;
    //title을 셋팅한다.
    title = ref.read(titleProvider.notifier).state;
    //날짜를 셋팅한다.
    trainDate = onlyDay(ref.read(selectedDayProvider.notifier).state);
    //db에서 기존 리스트를 불러오고 이 것을 preTemp에 넣어둔다.
    preTemp = await getPreviousList();
    //최초 빌드니까 그대로 리턴해준다.
    return preTemp;
  }

  /// db에서 기존 저장된 계획을 불러와 반환하는 함수.
  Future<List<TrainingPlanModel>> getPreviousList() async {
    TrainingPlanTableDataImpl db = TrainingPlanTableDataImpl();
    return List.from(await db.getDaysEachSportPlan(title, sportID, trainDate));
  }

  /// 처음 상태로 되돌리는 함수
  /// 저장안하고 나갈때 사용
  void resetState() async {
    temp = [];
    preTemp = await getPreviousList();
    setState();
  }

  /// 기존 저장된 계획 리스트와  새로 입력한 계획 리스트를 합쳐서 state를 변경하는 함수.
  void setState() async {
    List<TrainingPlanModel> tempState = List.from(preTemp)..addAll(temp);
    state = AsyncData(List.from(tempState));
  }

  ///운동세트 추가해서 temp 리스트에 추가하는 함수.
  addEmptyModel() {
    int preTempLen = preTemp.length;
    setNum += 1;
    temp.add(
      TrainingPlanModel(
        tpId: null,
        tpTitle: title,
        tpSId: sportID,
        tpSet: preTempLen + setNum,
        tpRec1: 0,
        tpRec2: 0,
        tpTrainDate: trainDate,
        tpDone: 0,
      ),
    );
    setState();
  }

  ///운동세트를 빼는 함수. 마지막 셋트를 뺸다.
  /// temp가 비어있지 않은 상태에서만.
  subModel() {
    if (temp.isNotEmpty) {
      setNum -= 1;
      temp.removeLast();
      setState();
    }
  }

// // index 계산 예시 : 입력값은 화면 indxe.  구성 :  [ 0,1,2,3 ]   [ 0,1 ]  화면 index = 5/ 실제 index = 1  / 길이=4
  setRec1Value(int index, double value) {
    int realIndex = index - (preTemp.length);
    temp[realIndex] = temp[realIndex].copyWith(tpRec1: value);
    setState();
  }

  setRec2Value(int index, double value) {
    int realIndex = index - (preTemp.length);
    temp[realIndex] = temp[realIndex].copyWith(tpRec2: value);
    setState();
  }

  /// 저장하는 함수
  Future<bool> savePlanList() async {
    bool rs = false;
    if (temp.isEmpty) {
      return rs;
    }
    TrainingPlanTableDataImpl db = TrainingPlanTableDataImpl();
    try {
      rs = await db.insertMultipleTrainingPlans(temp);
    } catch (e) {
      return false;
    }
    return rs;
  }

  //done 으로 바꾸기.
  // Future<bool> donePlanRow(int planId) async {
  //   TrainingPlanTableDataImpl db = TrainingPlanTableDataImpl();
  //   bool rs = await db.updateDone(1, planId);
  //   print(rs);
  //   if(!rs){return false;}
  //   initState();
  //   return rs;
  // }
} //end class
