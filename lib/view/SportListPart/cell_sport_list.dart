// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/base_alert.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_text_box.dart';
import 'package:myhealthdiary_app/provider/sport_llist_state_notifier.dart';

import '../../baseModel/sport_folder_model.dart';
import '../../managerClass/sport_list_manage/sportlist_infolder_manager.dart';
import '../../provider/collection_of_basic_state_provider.dart';
import '../../provider/sport_folder_list_state_notifier.dart';
import '../../provider/sport_list_infolder_notifier.dart';
import '../TrainGoalPart/train_goal_insert_view.dart';

class CellSportList extends ConsumerWidget {
  final int sportId;
  final String sportName;
  final double width;
  final double eachheight;

  /// 스포츠를 눌럿을때 어디로 갈지 결정하는 요소이다. goal plan train   planUpdate는 제꼈다....
  final String opt;
  final int folderID;
  const CellSportList(
      {super.key,
      required this.sportId,
      required this.sportName,
      required this.width,
      required this.eachheight,
      required this.opt,
      required this.folderID});
//스포츠 목록에서 각 스포츠들을 보여줄 작은 cell 이다.
//opt에 따라서, 다음 화면을 정한다.
//꾹 누르면 삭제 기능이 가능하게 되어있다
//..
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
//화면에 보여줄 sportID를 셋팅하고
        ref.read(showingSportIdProvider.notifier).state = sportId;
        print(ref.read(showingSportIdProvider.notifier).state);
        // ref.read(titleProvider.notifier).state = sport_name;
//옵션에 따라서 화면을 이동한다.
        if (opt == "goal") {
          context.goNamed(TrainGoalInsertView.routeForTrainGoalInertView);
        }
        if (opt == "plan") {
          // context.goNamed(TrainingPlanAddSetView.routeName1);
        }
        if (opt == "planUpdate") {
          // String planTitle = ref.read(titleProvider.notifier).state;
          // String planDate = ref.read(trainDateProvider.notifier).state;
          // context.goNamed(TrainingPlanAddSetView.routeName2);
        }
        if (opt == "train") {
          // context.goNamed(TrainingPlanAddSetView.routeName4);
        }
      },
//길게 눌렀을때의 삭제기능 : Folder 내 목록을 보여줄떄와, 전체 목록을 보여줄 때가 다르다.
      onLongPress: () async {

//folderID =0 이면 전체 목록에 있는 cell이고  db에서 아주 삭제해야한다.
//0이 아니면, 폴더에 즐겨찾기만 취소하는 기능이다.
        if (folderID != 0) {
          SportListInFolderManager manager =
              SportListInFolderManager(context: context, ref: ref);
          //아 이거... 통일 어긋낫는데...ㅁㅇㄴㅁㅇㅁㅇ망;ㅣㅏㅁㄴ;만ㅇ;ㅣ망;망ㅁ;ㅣ안; ㅇ\
          //하나쯤은.. 괜찮겠지...
          await manager.deleteFromFolder(folderID, sportId);
          await ref
              .read(sportListInFolderStateProvider(folderID).notifier)
              .getSportInFolder();
        }
        if (folderID == 0) {
          bool confirm = await baseAlertForConfirm(context, "정말로 삭제하시겠습니까?");
          if (confirm) {
            //지우고
            ref.read(wholeListStateProvider.notifier).deleteSport(sportId);
            //전체리스트 초기화
            ref.read(wholeListStateProvider.notifier).setWholeList();
            //폴더 편집을 위한 전체리스트도 초기화
            ref.read(wholeListForAddInFolder.notifier).getAllSportsFormed();
            //폴더멸 리스트 새로고침
            //폴더별 리스트 새로고침
            final folderList = ref.read(folderListProvider);
            for (SportFolderModel model in folderList) {
              ref
                  .read(sportListInFolderStateProvider(model.sfId!).notifier)
                  .getSportInFolder();
            }
          }
        }
      },
      child: SizedBox(
        width: width - 5,
        height: eachheight,
        child: WidgetCustomTextBox(
          msg: sportName,
          fontSize: sportName.length > 7
              ? fontSize(context, 1.5)
              : fontSize(context, 2),
          verAlign: 1,
        ),
      ),
    );
  }
}
