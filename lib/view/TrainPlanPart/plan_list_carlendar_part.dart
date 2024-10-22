import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/provider/providerForTrainPart/train_plan_list_notifier.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../provider/constProvider/collection_of_basic_state_provider.dart';

class PlanListCarlendarPart extends ConsumerWidget {
  final double maxWidth;
  final double maxHeight;
  const PlanListCarlendarPart({super.key, required this.maxWidth, required this.maxHeight});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectDayState = ref.watch(selectedDayProvider);
    final focusDayState = ref.watch(focusedDayProvider);
    final planDate = ref.watch(trainPlanListProvider);
    // TableCarlendar를 통해서 달력에다가 계획을 표시하는 파트이다.
    // 코드 번잡해질까봐 분리하였다.
    return Container(
      // color: Colors.green[100],
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      width: maxWidth,
      height: maxHeight,
      child: TableCalendar(
        eventLoader: (day) {
          final normalizedDay = DateTime(day.year, day.month, day.day);
          return planDate[normalizedDay] ?? []; // normalize로 비교
        },
        headerStyle: const HeaderStyle(
          titleCentered: true,
          formatButtonVisible: false, // "2주" 버튼 숨기기
        ),

        calendarStyle: const CalendarStyle(
          weekendTextStyle: TextStyle(color: Colors.blue),
          markerSize: 5,
          markersMaxCount: 5,
          markerDecoration: BoxDecoration(
            color: Colors.purple,
            shape: BoxShape.circle,
            // 일정 표시 마커 스타일 (원형)
          ),
        ),

        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            switch (day.weekday) {
              case 7:
                return const Center(
                  child: Text("Sun", style: TextStyle(color: Colors.red)),
                );
              case 6:
                return const Center(
                  child: Text("Sat", style: TextStyle(color: Colors.blue)),
                );
            }
            return null;
          },
          defaultBuilder: (context, day, focusedDay) {
            // 모든 일요일 날짜에만 붉은색 텍스트 적용
            if (day.weekday == DateTime.sunday) {
              return Center(
                child: Text(
                  '${day.day}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            // 기본 날짜는 그냥 null 반환 (기본 스타일 적용)
            return null;
          },
        ),
        // 그냥 날짜를 하나로 관리하면, 오늘 날짜에 색칠되어있는 것을 없앨 수 있다.
        // focusedDay: selectDayState,
        // 이렇게 나눠서 관리하면, 다른 날짜를 클릭하더라도, 오늘 날짜에도 옅은 포커스가 유지된다.
        focusedDay: focusDayState,
        firstDay: DateTime(2021),
        lastDay: DateTime.now().add(const Duration(days: 3650)),
        selectedDayPredicate: (day) {
          //내가 지금 고른 날짜를 관리하는 변수 (selectDayState)가  내가 고른 날짜랑 일치하면 focus 한다.
          //그러면 내가고른 날짜가 갑자기변경되면?
          return isSameDay(selectDayState, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          ref.read(selectedDayProvider.notifier).state = selectedDay;
          ref.read(focusedDayProvider.notifier).state = focusedDay;
        },

        /* ********************** 여기부터가 일정 설정 값 ***************************** */
      ),
    );
  }
}
