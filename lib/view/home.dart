import 'package:flutter/material.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/widget/layOut/base_layout.dart';
import 'package:myhealthdiary_app/view/IndexGoalPart/index_goal_list_view.dart';
import 'package:myhealthdiary_app/view/IndexRecPart/index_rec_list_view.dart';
import '../common/widget/widget_custom_text_box.dart';
import 'btn_for_home.dart';

// import 'package:myhealthdiary_app/common/widget/baseLayout.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // return BaseLayout(body: body, child: child);
    return BaseLayout(
      barTitle: "Better Than YesterDay",
      leadbtn: const SizedBox(),
      body: LayoutBuilder(builder: (context, constraints) {
        double width = constraints.maxWidth - 20;
        double height = constraints.maxHeight;
        double healthIndexGridWidth = width / 3.5;
        double trainGridWidth = width / 2.2;
        //높이 계산 (총 )
        double labelHeight = height * 0.06; //2개 들어감
        double healthIndexGridHeight = height * 0.16; //1개들어감
        double trainGridHeight = height * 0.28; //2개 들어감   78
        double pad = height * 0.01; //양쪽 끝 포함 6개 들어감

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: pad,
              ),
              SizedBox(
                width: width,
                height: height * 0.06,
                child: WidgetCustomTextBox(
                  verAlign: 2,
                  fontAlign: 0,
                  width: width,
                  height: labelHeight,
                  msg: "   ➤  건강 지표 관리",
                  fontSize: fontSize(context, 10),
                ),
              ),
              SizedBox(
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
                      navi: IndexRecListView.routeNameForIndexRecList,
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
              SizedBox(
                width: width,
                height: height * 0.06,
                child: WidgetCustomTextBox(
                  verAlign: 2,
                  fontAlign: 0,
                  width: width,
                  height: labelHeight,
                  msg: "   ➤  운동 일정 관리",
                  fontSize: fontSize(context,6 ),
                ),
              ),
              SizedBox(
                width: width,
                height: height * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BtnForHome(
                      msg: "운동 목표 설정",
                      content: Container(
                        color: Colors.black,
                        width: trainGridWidth,
                        height: trainGridHeight * 0.7,
                        child: Image.asset(
                          "images/trainGoal.png",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      navi: "_",
                      width: trainGridWidth,
                      height: trainGridHeight,
                    ),
                    BtnForHome(
                      msg: "운동 계획",
                      content: Container(
                        color: Colors.black,
                        width: trainGridWidth,
                        height: trainGridHeight * 0.7,
                        child: Image.asset(
                          "images/Plan.png",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      navi: "_",
                      width: trainGridWidth,
                      height: trainGridHeight,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: pad / 10,
              ),
              SizedBox(
                width: width,
                height: height * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BtnForHome(
                      msg: "운동 하러 가기",
                      content: Container(
                        color: Colors.black,
                        width: trainGridWidth,
                        height: trainGridHeight * 0.7,
                        child: Image.asset(
                          "images/dumbel.jpg",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      navi: "_",
                      width: trainGridWidth,
                      height: trainGridHeight,
                    ),
                    BtnForHome(
                      msg: "운동 일지",
                      content: Container(
                        color: Colors.black,
                        width: trainGridWidth,
                        height: trainGridHeight * 0.7,
                        child: Image.asset(
                          "images/Train.jpg",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      navi: "_",
                      width: trainGridWidth,
                      height: trainGridHeight,
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
