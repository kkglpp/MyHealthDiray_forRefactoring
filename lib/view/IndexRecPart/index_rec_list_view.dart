import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/provider/index_record_list_notifier.dart';
import '../../common/widget/base_layout.dart';
import '../../common/widget/widget_custom_flt_btn.dart';
import '../../common/widget/widget_custom_text_box.dart';
import '../../common/widget/widget_empty_card.dart';

import '../../provider/collection_of_basic_state_provider.dart';
import 'card_index_rec_list_view.dart';
import 'index_rec_insert_view.dart';

class IndexRecListView extends ConsumerWidget {
  static String routeNameForIndexRecList = "routeNameForIndexRecList";
  const IndexRecListView({super.key});

//목록 보여주는 가장 기본적인 화면이다. 빨리하자.
//상태관리 Notifier -> IndexRecordsListNotifier
//Provider 이름 : IndexRecordsStateProvider

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(indexRecordsStateProvider);
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth - 20;
        double maxHeight = constraints.maxHeight;
        double halfWidth = maxWidth * 0.38;
        double btnHelght = maxHeight * 0.08;
        return BaseLayout(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: maxWidth,
                    height: btnHelght,
                    // color: Colors.amber,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                            ref
                                .read(indexRecordsStateProvider.notifier)
                                .sortByInsertdateDESC();
                          },
                          child: WidgetCustomTextBox(
                            width: halfWidth,
                            msg: "최근 기록 부터 ⬇️ ",
                            fontSize: fontSize(context, 4),
                            fontColor: Colors.blue,
                            bold: true,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            ref
                                .read(indexRecordsStateProvider.notifier)
                                .sortByInsertdateASC();
                          },
                          child: WidgetCustomTextBox(
                            width: halfWidth,
                            msg: "오래된 기록 부터 ⬆️ ",
                            fontSize: fontSize(context, 4),
                            fontColor: Colors.red,
                            bold: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: maxWidth,
                    height: maxHeight * 0.8,
                    child: RefreshIndicator(
                      onRefresh: () async {},
                      child: state.isNotEmpty
                          ? ListView.separated(
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                );
                              },
                              itemCount: state.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                    child: CardIndexRecListView(
                                        heightValue: maxHeight * 0.25,
                                        widthValue: maxWidth,
                                        model: state[index]));
                              },
                            )
                          : Center(
                              child: WidgetEmptyCard(
                                width: maxWidth,
                                height: maxHeight * 0.8,
                                fontSize: fontSize(context, 12),
                              ),
                            ),
                    ),
                  )
                ],
              ),
            ),
            floatbtn: WidgetCustomFltBtn(onTap: () {
              //혹시 어디선가 누락 되었을지 모르니, 화면에 보여줄 recordId 관리하는 프로바이더 초기화 하고.
              ref.read(showingHealthIndexRecordIDProvider.notifier).state =0;
              //입력페이지로 넘어간다.
              context.goNamed(IndexRecInsertView.routeForIndexRecInsertView);
            }));
      },
    );
  }
}