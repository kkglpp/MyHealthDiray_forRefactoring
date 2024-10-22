import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/base_alert.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/component/widget_custom_elebtn.dart';
import 'package:myhealthdiary_app/common/component/widget_double_btn.dart';
import 'package:myhealthdiary_app/sport.list.part/provider/sport_list_infolder_notifier.dart';
import '../../datasource/sport_sort_table_data_impl.dart';


class SportListInFolderManager {
  final BuildContext context;
  final WidgetRef ref;

  SportListInFolderManager({required this.context, required this.ref});

//전체 스포츠 리스트가 있어야해. first List
//현재 폴더에 있는 스포츠 리스트가 있어야해. second List
// first 에서 누르면 second에 추가가 되어야 해.
// second 에서 누르면 빠져야해.
  addSportInFolderAlert(int folderID) async {
    double width = MediaQuery.of(context).size.width * 0.7;
    double height = MediaQuery.of(context).size.height * 0.7;
    double btnHeight = height * 0.1;
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SportAddToFolderAlertContent(
            folderID,
            width: width,
            height: height,
          ),
          actions: [
            WidgetDoubleBtn(
                leftFunc: () {
                  //취소부분인데

                  ref
                      .read(tempStateProviderForEditFolder(folderID).notifier)
                      .resetTempState();
                  context.pop();
                },
                rightFunc: () async {
                  bool rs = await ref
                      .read(tempStateProviderForEditFolder(folderID).notifier)
                      .insertListIntoTable();
                  if (!rs) {
                    // ignore: use_build_context_synchronously
                    baseAlertForConfirm(context, "오류가 발생하였습니다.");
                    // return;
                  }
                  ref
                      .read(tempStateProviderForEditFolder(folderID).notifier)
                      .getSportInFolder();
                  // 해당 폴더에 들어있는 sport 리스트만 초기화
                  await ref
                      .read(sportListInFolderStateProvider(folderID).notifier)
                      .getSportInFolder();
                  // ignore: use_build_context_synchronously
                  context.pop(); //화면으로 돌아가고
                },
                width: width,
                height: btnHeight)
          ],
        );
      },
    );
  }

// 이걸 사실 Provider 쪽에서 하는게 맞긴한데....
// 하나쯤은..뭐....
//만약 옮긴다면 SortFolderNOtifier 쪽에서 하면 될듯.
  Future<bool> deleteFromFolder(int folderID, int sportID) async {
    SortSportTableDataImpl db = SortSportTableDataImpl();
    bool rs = await db.deleterow(folderID, sportID);
    return rs;
  }
} //end class

class SportAddToFolderAlertContent extends ConsumerWidget {
  final int folderID;
  final double width;
  final double height;
  const SportAddToFolderAlertContent(
    this.folderID, {
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double columnWidth = width * 0.35;
    double paddingWidth = width * 0.15;
    double paddingHeight = height * 0.02;

    final wholeList = ref.watch(wholeListForAddInFolder);
    final folderSportList = ref.watch(tempStateProviderForEditFolder(folderID));
    return SizedBox(
      // color: Colors.white,
      width: width,
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: const BoxDecoration(
                // color: Colors.green[100],
                borderRadius: BorderRadius.all(Radius.circular(20))),
            width: columnWidth,
            height: height,
            child: ListView.builder(
              itemCount: wholeList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(0, paddingHeight, 0, 0),
                  child: WidgetCustomEleBtn(
                    width: columnWidth * 0.9,
                    height: height / 10,
                    color: Colors.black,
                    onPressed: () {
                      ref
                          .read(
                              tempStateProviderForEditFolder(folderID).notifier)
                          .addSportInState(wholeList[index]);
                    },
                    msg: wholeList[index].sportName,
                    fontSize: fontSize(context, 3),
                  ),
                );
              },
            ),
          ),

          SizedBox(
            // color: Colors.black,
            width: paddingWidth,
            child: const Icon(Icons.arrow_circle_right_outlined),
          ),

//현재 폴더에 들어있는 스포츠 리스트를 보여주는 부분
          Container(
            decoration: const BoxDecoration(
                // color: Colors.red[100],
                borderRadius: BorderRadius.all(Radius.circular(20))),
            width: columnWidth,
            height: height,
            child: ListView.builder(
              itemCount: folderSportList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(0, paddingHeight, 0, 0),
                  child: WidgetCustomEleBtn(
                    width: columnWidth * 0.9,
                    height: height / 10,
                    color: Colors.black,
                    onPressed: () {
                      ref
                          .read(
                              tempStateProviderForEditFolder(folderID).notifier)
                          .removeSportFromTempFolder(folderSportList[index]);
                    },
                    msg: folderSportList[index].sportName,
                    fontSize: fontSize(context, 3),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
