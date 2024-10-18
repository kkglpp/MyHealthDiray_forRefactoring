import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/view/SportListPart/cell_sport_list.dart';
import '../../baseModel/sport_model.dart';

class ColumnAllSportsList extends ConsumerWidget {
  final List<SportModel> list;
  final double width;
  final double height;
  final double cellHeight;
  final String opt;
  const ColumnAllSportsList({
    super.key,
    required this.list,
    required this.width,
    required this.height,
    required this.cellHeight,
    required this.opt,
  });
// 화면 최 좌측에서, 전체 목록을 보여주는 Column이다.
//여긴 특별한 거 없이 그냥 List를 받아서 보여준다. 상태관리 하는 부분도 딱히 필요없다. 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: width,
      height: height,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: SizedBox(
              height: 5,
              width: width,
              child: const Divider(
                thickness: 1,
              ),
            ),
          );
        },
        itemCount: list.length,
        itemBuilder: (context, index) {
          SportModel sport = list[index];
          return CellSportList(
            sportId: sport.sportId!,
            sportName: sport.sportName,
            width: width,
            eachheight: cellHeight,
            opt: opt,
            folderID: 0,
          );
        },
      ),
    );
  }
}
