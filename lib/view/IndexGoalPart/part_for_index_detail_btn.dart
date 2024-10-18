import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/provider/index_goal_notifier.dart';
import '../../baseModel/health_index_goal_model.dart';
import '../../common/widget/widget_custom_text_box.dart';
import '../../common/const/base_alert.dart';
import '../../provider/undex_goal_list_notifier.dart';

class PartForIndexDetailBtn extends ConsumerWidget {
  final HealthIndexGoalModel goal;
  final double width;
  final double height;
  final double fsize;
  const PartForIndexDetailBtn({
    super.key,
    required this.goal,
    required this.width,
    required this.height,
    required this.fsize,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double halfWidth = (width / 2) - 10;
    double height_01 = height * 0.7;
    double height_02 = height * 0.2;
    double iconSize = width * 0.2;
    return goal.hgSuccess != 0
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: halfWidth,
                height: height,
                child: goal.hgSuccess == 1
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: halfWidth,
                            height: height_01,
                            child: Icon(
                              Icons.thumb_up,
                              size: iconSize,
                              color: Colors.blue,
                            ),
                          ),
                          WidgetCustomTextBox(
                            width: halfWidth,
                            height: height_02,
                            msg: '목표 달성',
                            fontSize: fsize,
                            fontColor: Colors.blue,
                          )
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: halfWidth,
                            height: height_01,
                            child: Icon(
                              Icons.thumb_down,
                              size: iconSize,
                              color: Colors.red,
                            ),
                          ),
                          WidgetCustomTextBox(
                            width: halfWidth,
                            height: height_02,
                            msg: '미달성',
                            fontSize: fsize,
                            fontColor: Colors.red,
                          )
                        ],
                      ),
              ),
              SizedBox(
                child: Center(
                  child: WidgetCustomTextBox(
                      width: halfWidth,
                      height: height,
                      verAlign: 1,
                      msg: goal.hgSuccess == 1
                          ? '목표 달성일 \n ${goal.hgSuccessdate!}'
                          : '미달성 기록일 \n ${goal.hgSuccessdate!}',
                      fontSize: fsize),
                ),
              )
            ],
          )

/*
아직 입력 안한 목표에서 나오는 부분
해당 목표를 달성햇는지 안했는지를 입력해야한다.
입력한 goal 에서 id를 뽑아 provider의 함수를 실행한다.

 */



        : Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () async{
// 정말인지 성공 여부를 확인하고
            bool rs = await baseAlertForConfirm(context, "목표를 달성에 실패하셨나요??");
// 확인 받았을 경우에만 업데이트 실행            
            if(rs){
              await ref.read(indexGoalModelProvider(goal.hgId!).notifier).updateSuccess(false);
//해당 목표의 상태 및 돌아가 페이지(GoalList)의 상태를 새로고침한다.
              ref.read(indexGoalModelProvider(goal.hgId!).notifier).initForDetail(goal.hgId!);
              ref.read(healthIndexGoalListProvider.notifier).initializeState();
//리스트 화면으로 돌아간다.              
              // ignore: use_build_context_synchronously
              context.pop();

            }

          },
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              fixedSize: Size(halfWidth, height)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: halfWidth,
                  height: height_01,
                  child: Icon(
                    Icons.close,
                    color: Colors.red,
                    size: iconSize,
                  )),
              WidgetCustomTextBox(
                width: halfWidth,
                height: height_02,
                msg: "달성 실패",
                fontSize: fsize,
                fontColor: Colors.red,
              ),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () async {
//달성 여부 확인 받고            
            bool rs = await baseAlertForConfirm(context, "목표를 달성 하셨나요?");
// 확인 받았을 경우에만 업데이트 실행            
            if(rs){
              await ref.read(indexGoalModelProvider(goal.hgId!).notifier).updateSuccess(true);
//해당 목표의 상태 및 돌아가 페이지(GoalList)의 상태를 새로고침한다.
              ref.read(indexGoalModelProvider(goal.hgId!).notifier).initForDetail(goal.hgId!);
              ref.read(healthIndexGoalListProvider.notifier).initializeState();
//리스트 화면으로 돌아간다.              
              // ignore: use_build_context_synchronously
              context.pop();

            }
          },
          style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              fixedSize: Size(halfWidth, height)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                // color: Colors.red,
                  width: halfWidth,
                  height: height_01,
                  child: Icon(
                    Icons.thumb_up,
                    color: Colors.blue,
                    size: iconSize,
                  )),
              WidgetCustomTextBox(
                width: halfWidth,
                height: height_02,
                msg: "목표 달성",
                fontSize: fsize,
                fontColor: Colors.blue,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
