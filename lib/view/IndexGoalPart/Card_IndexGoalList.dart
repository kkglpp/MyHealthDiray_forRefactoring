import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/baseModel/healthIndexGoal_model.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';
import 'package:myhealthdiary_app/common/widget/WidgetCustomTextBox.dart';
import 'package:myhealthdiary_app/provider/CollectionOfBasicStateProvider.dart';
import 'package:myhealthdiary_app/provider/IndexGoalListNotifier.dart';
import 'package:myhealthdiary_app/provider/IndexGoalNotifier.dart';
import 'package:myhealthdiary_app/view/IndexGoalPart/IndexGoalDetailView.dart';

class CardIndexGoalList extends ConsumerWidget {
  final HealthIndexGoalModel model;


  const CardIndexGoalList({required this.model});

  /*
  IndexGoalListView에서  각 목표들을 보여주는 카드 위젯이다.
  수행할 기능은 2가지이다.
  터치하면 detailview로 보내기. (보여주고 싶은 목표의 아이디를 담당 provider에게 보낸다.)
  밀어서 삭제하기 기능.
  
  */

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async{
// 페이지를 이동하기 전에 모델 아이디를 provider에 보낸다.
// showingHealthIndexGoalIDProvider : 화면에 보여주고 싶은 HealthIndexGoalID 관리하는 프로바이더.
        ref.read(showingHealthIndexGoalIDProvider.notifier).state = await model.hg_id!;
        context.goNamed(IndexGoalDetailView.RouteNameForIndexGoalDetail);
      },
      child: Dismissible(
        direction: DismissDirection.startToEnd,
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete_forever, size: 50),
        ),
        key: ValueKey(model.hg_id),
        onDismissed: (direction) {
          //밀어서 삭제하는 함수. 프로바이더에 있는 deleteGoal을 실행한다.
          ref
              .read(healthIndexGoalListProvider.notifier)
              .deleteGoal(model.hg_id!);
          ref.read(healthIndexGoalListProvider.notifier).initializeState();
        },
        child: LayoutBuilder(builder: (context, constraints) {
          double maxHeight = constraints.maxHeight;
          double maxWidth = constraints.maxWidth;
          double lineHeight = maxHeight*0.14;
          double fontSize = ((maxWidth/80) * 2.5).clamp(10, 30);
          double imgSize = (maxWidth *0.4).clamp(maxHeight,maxHeight);
          return Container(
            width: maxWidth,
            height: maxHeight,
            color: model.hg_success == 1
                ? constSuccessColor
                : model.hg_success == 0
                    ? constNeutralColor
                    : constFailColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: imgSize,
                  height: maxHeight,
                  color: Colors.black,
                  child: model.hg_img != null
// 추후에 갤러리에서 해당 이름을 가진 사진을 가져 오는 것으로 바꿔야함.
                      ? Image.asset(model.hg_img!)
                      : const Center(
                          child: WidgetCustomTextBox(
                            verAlign: 1,
                            fontColor: Colors.white,
                            msg: "No\nImage",
                            bold: true,
                            fontSize: 20,
                          ),
                        ),
                ),
//기타 목표 수치들을 보여주는 부분. 여백 생각해서 0.05는 비운다.
                SizedBox(
                  width: maxWidth*0.5,
                  height: maxHeight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      WidgetCustomTextBox(
                          height: lineHeight,
                          msg: "몸무게 : ${model.hg_weight.toString()} kg",
                          fontSize: fontSize,
                          fontAlign: 2),
                      WidgetCustomTextBox(
                          height: lineHeight,
                          msg: "골격근량 : ${model.hg_muscle ?? '-'} kg",
                          fontSize: fontSize,
                          fontAlign: 2),
                      WidgetCustomTextBox(
                          height: lineHeight,
                          msg: "체지방율 : ${model.hg_fat ?? '-'} %",
                          fontSize: fontSize,
                          fontAlign: 2),
                      WidgetCustomTextBox(
                          height: lineHeight,
                          msg: "기한 : ${model.hg_duedate}",
                          fontSize: fontSize,
                          fontAlign: 2),
                    ],
                  ),
                ),
                const Spacer()
              ],
            ),
          );
        }),
      ),
    );
  }
} //end _GoalListCard class