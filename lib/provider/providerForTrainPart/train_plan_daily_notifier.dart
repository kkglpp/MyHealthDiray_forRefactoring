import 'package:myhealthdiary_app/model/training_plan_model.dart';
import 'package:myhealthdiary_app/provider/constProvider/collection_of_basic_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../datasource/training_plan_table_data_impl.dart';
import '../../common/const/basic_method.dart';

part 'train_plan_daily_notifier.g.dart';

@riverpod
class TrainPlanDailyNotifier extends _$TrainPlanDailyNotifier {
  //Field
  //상태를 변경할때 기존 상태를 저장하기 위한 변수
  //임시로 만들지 않은 것은, 혹시 또 필요한 가능성이 스쳐지나갔어서. 기억해내라 제발..
  List<PlanListOfPlanSet> _currentState = [];
  //insert 상태일떄 Title을 담을 변수
  late String title;
  //insert 상태일때 default Date.
  // String trainDate = onlyDay(DateTime.now().add(const Duration(days: 7)));
  late String trainDate;
  //Method
  ///최초 시작하는 Build 함수.
  @override
  Future<List<PlanListOfPlanSet>> build() async {
    List<PlanListOfPlanSet> temp = await getState();
    return temp;
  }

  /// 기존에 저장된 plan List를 타이틀과 운동 예정일을 가지고 시작한다.
  Future<List<PlanListOfPlanSet>> getState() async {
    TrainingPlanTableDataImpl db = TrainingPlanTableDataImpl();
    title = ref.read(titleProvider.notifier).state;
    trainDate = onlyDay(ref.read(selectedDayProvider.notifier).state);
    List<PlanListOfPlanSet> temp =
        await db.getDaysPlanSportList(title, trainDate);
    _currentState = List.from(temp);
    return temp;
  }

  refreshState() async {
    List<PlanListOfPlanSet> temp = await getState();
    state = AsyncData(temp);
  }

  /// 새로운 plan을 만들떄 Title을 셋팅하는 함수
  setTitle(String newTitle) {
    title = newTitle; // 이름 새로 바꾸고
  }

  ///계획은 운동단위로 보여진다. 이 운동단위로 삭제할때.
  deleteList(int index) async {
    state = const AsyncLoading(); //state를 로딩으로 바꾸고.
    // db에서 삭제하고
    TrainingPlanTableDataImpl db = TrainingPlanTableDataImpl();
    await db.deleteDaySpecificSport(
      _currentState[index].tpTitle,
      _currentState[index].tpTrainDate,
      _currentState[index].tpSId,
    );
    //상태 최신화
    refreshState();
  }
}
