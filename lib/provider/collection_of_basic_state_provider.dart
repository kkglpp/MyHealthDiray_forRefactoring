import 'package:flutter_riverpod/flutter_riverpod.dart';

///화면에 보여주고 싶은 HealthIndexGoal ID를 관리한다.
///반드시 초기화를 잊지 않아야 한다.(state = 0)
final showHealthIndexGoalIDProvider = StateProvider<int>((ref) => 0);

///화면에 보여주고 싶은 HealthIdexRecord ID 를 관리한다.
///반드시 초기화 할 것.
final showHealthIndexRecordIDProvider = StateProvider<int>((ref) => 0);

//화면에 보여주고 싶은 TrainGoalID 를 관리한다.
final showTraingGoalIDProvider = StateProvider<int>((ref) => 0);

//화면에 보여주고 싶은 SportID를 관리한다.
final showSportIdProvider = StateProvider<int>((ref) => 0);

final insertDoubleValueProvider =
    StateProviderFamily<double, double>((ref, initial) => initial);
