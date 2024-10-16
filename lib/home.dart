import 'package:flutter/material.dart';
import 'package:myhealthdiary_app/btnForHome.dart';
import 'package:myhealthdiary_app/common/basicMethod.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';
import 'package:myhealthdiary_app/common/widget/BaseLayout.dart';
import 'package:myhealthdiary_app/common/widget/WidgetCustomTextBox.dart';
import 'package:myhealthdiary_app/common/widget/WidgetDoubleBtn.dart';
import 'package:myhealthdiary_app/view/IndexGoalPart/IndexGoalListView.dart';

// import 'package:myhealthdiary_app/common/widget/baseLayout.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // return BaseLayout(body: body, child: child);
    return BaseLayout(
      barTitle: "Better Than YesterDay",
      leadbtn: SizedBox(),
      body: LayoutBuilder(builder: (context, constraints) {
        double width = constraints.maxWidth - 20;
        double height = constraints.maxHeight;
        double healthIndexGridWidth = width / 3.5;
        double TrainGridWidth = width / 2.2;
        //높이 계산 (총 )
        double labelHeight = height * 0.06; //2개 들어감
        double healthIndexGridHeight = height * 0.16; //1개들어감
        double TrainGridHeight = height * 0.28; //2개 들어감   78
        double pad = height * 0.01; //양쪽 끝 포함 6개 들어감

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: pad,
              ),
              Container(
                width: width,
                height: height * 0.06,
                child: WidgetCustomTextBox(
                  verAlign: 2,
                  fontAlign: 0,
                  width: width,
                  height: labelHeight,
                  msg: "   ➤  건강 지표 관리",
                  fontSize: CalcfontSize(6, width, height * 0.06),
                ),
              ),
              Container(
                width: width,
                height: height * 0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BtnForHome(
                      msg: "목표 설정",
                      content: Image.asset("images/dreamingBody.png"),
                      navi: IndexGoalListView.routeName,
                      width: healthIndexGridWidth,
                      height: healthIndexGridHeight,
                    ),
                    BtnForHome(
                      msg: "현재 상태 기록하기",
                      content: Image.asset(
                        "images/backPicture.jpg",
                        fit: BoxFit.fitHeight,
                      ),
                      navi: "_",
                      width: healthIndexGridWidth,
                      height: healthIndexGridHeight,
                    ),
                    BtnForHome(
                      msg: "변화 과정",
                      content: Image.asset(
                        "images/recBody.png",
                        fit: BoxFit.fitHeight,
                      ),
                      navi: "_",
                      width: healthIndexGridWidth,
                      height: healthIndexGridHeight,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width - 20,
                height: pad,
                child: const Divider(
                  color: Colors.black,
                ),
              ),
              Container(
                width: width,
                height: height * 0.06,
                child: WidgetCustomTextBox(
                  verAlign: 2,
                  fontAlign: 0,
                  width: width,
                  height: labelHeight,
                  msg: "   ➤  운동 일정 관리",
                  fontSize: CalcfontSize(6, width, height * 0.06),
                ),
              ),
              Container(
                width: width,
                height: height * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BtnForHome(
                      msg: "운동 목표 설정",
                      content: Container(
                        color: Colors.black,
                        width: TrainGridWidth,
                        height: TrainGridHeight * 0.7,
                        child: Image.asset(
                          "images/trainGoal.png",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      navi: "_",
                      width: TrainGridWidth,
                      height: TrainGridHeight,
                    ),
                    BtnForHome(
                      msg: "운동 계획",
                      content: Container(
                        color: Colors.black,
                        width: TrainGridWidth,
                        height: TrainGridHeight * 0.7,
                        child: Image.asset(
                          "images/Plan.png",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      navi: "_",
                      width: TrainGridWidth,
                      height: TrainGridHeight,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: pad / 10,
              ),
              Container(
                width: width,
                height: height * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BtnForHome(
                      msg: "운동 하러 가기",
                      content: Container(
                        color: Colors.black,
                        width: TrainGridWidth,
                        height: TrainGridHeight * 0.7,
                        child: Image.asset(
                          "images/dumbel.jpg",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      navi: "_",
                      width: TrainGridWidth,
                      height: TrainGridHeight,
                    ),
                    BtnForHome(
                      msg: "운동 일지",
                      content: Container(
                        color: Colors.black,
                        width: TrainGridWidth,
                        height: TrainGridHeight * 0.7,
                        child: Image.asset(
                          "images/Train.jpg",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      navi: "_",
                      width: TrainGridWidth,
                      height: TrainGridHeight,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
