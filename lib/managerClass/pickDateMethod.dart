import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';


Future<DateTime> pickDateUsingDialog(BuildContext context, String? date) async {
  var _dates;
  if (date == null) {
    _dates = [DateTime.now().add(const Duration(days: 120))];
  } else {
    _dates = [DateTime.parse(date)];
  }
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;
  List<DateTime?>? results = await showCalendarDatePicker2Dialog(
    context: context,
    config: CalendarDatePicker2WithActionButtonsConfig(),
    dialogSize: Size(width*0.9, height*0.6),
    value: _dates,
    borderRadius: BorderRadius.circular(15),
  );
  // results가 null이거나 비어 있을 경우 DateTime.now()를 반환
  if (results == null || results.isEmpty) {
    return _dates[0];
  }
  return results[0]!;
}