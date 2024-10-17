import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/widget/BaseLayout.dart';
import 'package:myhealthdiary_app/common/widget/WidgetCustomTextBox.dart';
import 'package:myhealthdiary_app/provider/CollectionOfBasicStateProvider.dart';

class IndexGoalDetailView extends ConsumerWidget {
  static String RouteNameForIndexGoalDetail = "RouteNameForIndexGoalDetail";
  const IndexGoalDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseLayout(
      barTitle: "goalID  ${ref.read(showingHealthIndexGoalIDProvider.notifier).state.toString()}",
      appbarOption: false,
      body: LayoutBuilder(
        builder: (context,constraints) {
          double maxWidth = constraints.maxWidth;
          double maxHeight = constraints.maxHeight;

          //구성요소 높이 설정
          ///목표 달성일 입력 박스
          double duedateBoxHeight = maxHeight*0.08;
          ///사진이랑 기타 요소 들어가는 박스
          double mainBoxHeight = boxheightSize(maxHeight *0.47);
          ///버튼 들어가는 박스
          double btnBoxHeight = boxheightSize(maxHeight*0.25);
          ///배너들어갈 부분
          double bannerBox =boxheightSize( maxHeight*0.1);
          ///최하단 버튼 들어갈 부분
          double doubleBtnBox = boxheightSize(maxHeight*0.5);

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: maxWidth,
                  height: duedateBoxHeight,
                  child: WidgetCustomTextBox(
                    verAlign: 1,
                    fontAlign: 1,
                    msg: " ${}",
                    fontSize: fontSize(context, 1) ),
                )
              ],
            ),
          );
        }
      ));
  }
}