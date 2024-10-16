import 'package:flutter_riverpod/flutter_riverpod.dart';

///화면에 보여주고 싶은 HealthIndexGoal ID를 관리한다.
///반드시 초기화를 잊지 않아야 한다.(state = 0)
final showingHealthIndexGoalID = StateProvider<int>((ref) => 0);

