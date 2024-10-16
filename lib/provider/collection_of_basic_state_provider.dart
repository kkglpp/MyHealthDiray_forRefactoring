import 'package:flutter_riverpod/flutter_riverpod.dart';

///화면에 보여주고 싶은 HealthIndexGoal ID를 관리한다.
///반드시 초기화를 잊지 않아야 한다.(state = 0)
final showingHealthIndexGoalIDProvider = StateProvider<int>((ref) => 0);

///화면에 보여주고 싶은 HealthIdexRecord ID 를 관리한다.
///반드시 초기화 할 것.
final showingHealthIndexRecordIDProvider = StateProvider<int>((ref) => 0);

//화면에 보여주고 싶은 SportID를 관리한다.
final showingSportIdProvider = StateProvider<int>((ref) => 0);

final insertDoubleValueProvider =
    StateProviderFamily<double, double>((ref, initial) => initial);
