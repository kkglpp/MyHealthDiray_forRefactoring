import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/widget/BaseLayout.dart';
import 'package:myhealthdiary_app/common/widget/WidgetCustomTextBox.dart';
import 'package:myhealthdiary_app/common/widget/WidgetEmptyCard.dart';
import 'package:myhealthdiary_app/provider/IndexRecordListNotifier.dart';

import 'Card_IndexRecListView.dart';

class IndexRecListView extends ConsumerWidget {
  static String routeNameForIndexRecList = "routeNameForIndexRecList";
  const IndexRecListView({super.key});

//목록 보여주는 가장 기본적인 화면이다. 빨리하자.
//상태관리 Notifier -> IndexRecordsListNotifier
//Provider 이름 : IndexRecordsStateProvider

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(IndexRecordsStateProvider);
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth-20;
        double maxHeight = constraints.maxHeight;
        double halfWidth = maxWidth*0.38;
        double btnHelght = maxHeight*0.08;
        return BaseLayout(
          body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: maxWidth,
              height: btnHelght,
              // color: Colors.amber,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      ref
                          .read(IndexRecordsStateProvider.notifier)
                          .sortByInsertdateDESC();
                    },
                    child: WidgetCustomTextBox(
                      width: halfWidth,
                      msg: "최근 기록 부터 ⬇️ ",
                      fontSize:fontSize(context,4),
                      fontColor: Colors.blue,
                      bold: true,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ref
                          .read(IndexRecordsStateProvider.notifier)
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
              height: maxHeight*0.8,
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
                              padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                              child: CardIndexRecListView(
                                height: maxHeight*0.25,
                                width: maxWidth,
                                model: state[index]));
                        },
                      )
                    : Center(
                        child: WidgetEmptyCard(
                          width: maxWidth,
                          height: maxHeight*0.8,
                          fontSize: fontSize(context, 12),
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
        
        );
      },
    );
  }
}
