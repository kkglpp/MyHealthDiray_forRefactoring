// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/widget/widget_banner_for_ad.dart';
import 'package:myhealthdiary_app/common/widget/widget_double_btn.dart';
import '../../common/basic_method.dart';
import '../../common/widget/base_layout.dart';
import '../../common/widget/widget_custom_text_box.dart';
import '../../provider/collection_of_basic_state_provider.dart';
import '../../provider/index_record_notifier.dart';
import 'card_index_rec_insert_view.dart';

class IndexRecInsertView extends ConsumerWidget {
  static String routeForIndexRecInsertView = "routeForIndexRecInsertView";
  static String routeForIndexRecDetailView = "routeForIndexRecDetailView";
  const IndexRecInsertView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //건강 지표를 기록하는 페이지.(Index Rec)
    // 상태관리 Notifier  :  IndexRecordNotifier
    // provider : 신규 입력 : IndexRecModelProvider
    // provider : 상세 보기 : IndexRecModelProvider
    // 이 화면에서 보여주고 싶은 record 의 id를 가져온다. insert의 경우 0으로 셋팅한다.
    final recordId = ref.watch(showingHealthIndexRecordIDProvider);
    final record = ref.watch(indexRecModelProvider(recordId));

    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth - 20;
        double maxHeight = constraints.maxHeight;
//이미지 넣는 자리
        double imgHeight = maxHeight * 0.3;
//수치들을 입력받는 파트
        double boxHeight = maxHeight * 0.22;
//수치를 각각 입력 받는 sizedbox 높이
        double smallboxHeight = boxHeight * 0.3;
        // double leftWidth = (maxWidth * 0.5) * 0.35 - 1;
        // double midWidth = (maxWidth * 0.5) * 0.4 - 1;
        // double rightWidth = (maxWidth * 0.5) * 0.25 - 4;
//광고 배너
        double bannerHeight = maxHeight * 0.1; // 62
//그래프 들어가는 곳
        double descriptHeight = maxHeight * 0.28; // 90
        //버튼 두개 들어가는 곳
        double btnHeight = maxHeight * 0.07;
        return record == null
            ? Center(
                child: SizedBox(
                    width: maxWidth / 10,
                    height: maxWidth / 10,
                    child: const CircularProgressIndicator()),
              )
            : BaseLayout(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: maxWidth,
                        height: imgHeight,
                        color: Colors.black,
                        child: WidgetCustomTextBox(
                          fontColor: Colors.white,
                          msg: "No Image \n Click to insert Picture",
                          fontSize: fontSize(context, 10),
                        ),
                      ),
// 여기는 각 지수들을 입력하는 박스가 들어가는 곳.
                      SizedBox(
                        width: maxWidth,
                        height: boxHeight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: maxWidth * 0.47,
                              height: boxHeight,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: maxWidth / 2,
                                    height: smallboxHeight,
                                    child: CardIndexRecInsertView(
                                      indexName: "신 장",
                                      value: record.hrHeight,
                                      metric: "cm",
                                      min: 70,
                                      max: 250,
                                      changeVal: (value) {
                                        ref
                                            .read(
                                                indexRecModelProvider(recordId)
                                                    .notifier)
                                            .changedHeight(value);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: maxWidth / 2,
                                    height: smallboxHeight,
                                    child: CardIndexRecInsertView(
                                      indexName: "체 중",
                                      value: record.hrWeight,
                                      metric: "kg",
                                      min: 20,
                                      max: 150,
                                      changeVal: (value) {
                                        ref
                                            .read(
                                                indexRecModelProvider(recordId)
                                                    .notifier)
                                            .changedWeight(value);
                                      },
                                    ),
                                  ),
                                  SizedBox(
//BMI 는 자동으로 계산하기 때문에 별도로 입력하지 않는다.
                                    width: maxWidth / 2,
                                    height: smallboxHeight,
                                    child: CardIndexRecInsertView(
                                      indexName: "BMI",
                                      value: calcBMI(
                                          record.hrHeight, record.hrWeight),
                                      metric: "",
                                      min: 0,
                                      max: 0,
                                      isInsert: false,
                                      changeVal: (value) {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: maxWidth * 0.04,
                              child: const VerticalDivider(),
                            ),
                            SizedBox(
                              width: maxWidth * 0.47,
                              height: boxHeight,
                              child: Column(children: [
                                SizedBox(
                                  width: maxWidth / 2,
                                  height: smallboxHeight,
                                  child: CardIndexRecInsertView(
                                    indexName: "체지방율",
                                    value: record.hrFat,
                                    metric: "%",
                                    min: 0,
                                    max: 70,
                                    changeVal: (value) {
                                      ref
                                          .read(indexRecModelProvider(recordId)
                                              .notifier)
                                          .changedFat(value);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: maxWidth / 2,
                                  height: smallboxHeight,
                                  child: CardIndexRecInsertView(
                                    indexName: "골격근량",
                                    value: record.hrMuscle,
                                    metric: "kg",
                                    min: 10,
                                    max: 90,
                                    changeVal: (value) {
                                      ref
                                          .read(indexRecModelProvider(recordId)
                                              .notifier)
                                          .changedMuscle(value);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: maxWidth / 2,
                                  height: smallboxHeight,
                                  child: CardIndexRecInsertViewForDate(
                                    value: record.hrInsertDate,
                                  ),
                                ),
                              ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: bannerHeight,
                        width: maxWidth,
                        child: BannerForAd(),
                      ),
                      //그래프 들어가는 파트
                      SizedBox(
                        width: maxWidth,
                        height: descriptHeight,
                      ),
                      
                      WidgetDoubleBtn(
                        leftFunc: (){},
                        rightFunc: (){},
                        width: maxWidth,
                        height: btnHeight,
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }
}
