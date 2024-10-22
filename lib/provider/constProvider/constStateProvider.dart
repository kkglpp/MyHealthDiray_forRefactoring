import 'package:flutter_riverpod/flutter_riverpod.dart';

///화면에 보여주고 싶은 HealthIndexGoal ID를 관리한다.
final showHealthIndexGoalIDProvider = StateProvider((ref) => 0);

///화면에 보여주고 싶은 HealthIdexRecord ID 를 관리한다.
final showHealthIndexRecordIDProvider = StateProvider<int>((ref) => 0);

//화면에 보여주고 싶은 TrainGoalID 를 관리한다.
final showTraingGoalIDProvider = StateProvider<int>((ref) => 0);

//화면에 보여주고 싶은 SportID를 관리한다.
final showSportIdProvider = StateProvider<int>((ref) => 0);

final insertDoubleValueProvider =
    StateProviderFamily<double, double>((ref, initial) => initial);

final titleProvider = StateProvider((ref) => "");
//flutter run
// 고른 날짜를 관리하기 위한 provider
final selectedDayProvider = StateProvider<DateTime>((ref) => DateTime.now());
//focusing된 날짜를 관리하기 위한 provider
final focusedDayProvider = StateProvider<DateTime>((ref) => DateTime.now());

//운동 수행 파트에서 Timer를 컨트롤 하기위한 Provider.
final doublForTimerProvider = StateProvider<double>((ref) => 30);
final doublForTimerProviderMax = StateProvider<double>((ref) => 30);

//각 trainingRow를 관리하는 bool 값 provider
//false 면 미수행.
final boolForTrainingCard =
    AutoDisposeStateProviderFamily<bool, int>((ref, setID) => false);
