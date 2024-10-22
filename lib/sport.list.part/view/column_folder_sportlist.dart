import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhealthdiary_app/common/const/size.dart';

import '../../managerClass/sport_list_manage/sportlist_infolder_manager.dart';
import 'cell_sport_list.dart';

class ColumnFolderSportList extends ConsumerWidget {
  final int folderID;
  final double widthSize;
  final double heightSize;
  final double cellHeight;
  /// plan / goal / train
  final String opt;
  const ColumnFolderSportList(
      {super.key,
      required this.folderID,
      required this.widthSize,
      required this.heightSize,
      required this.cellHeight,
      required this.opt});

//각 폴더별로 분류 되어있는 스포츠 목록들을 보여주는 Column 한줄이다.
//여기는 foiderID에 따라 보여지는 List가 다르다.
//sportListInFolderStateProvider 로 상태관리 한다. 
//각 스포츠를 꾹 눌러서 폴더에서만 제거할 수 있으며, 폴더 최하단에 있는 add 버튼으로 폴더에 스포츠를 추가할 수 있다.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(sportListInFolderStateProvider(folderID));
    final double width = widthSize;
    final double height = heightSize;

    return SizedBox(
      width: width,
      height: height,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: SizedBox(
              height: 5,
              width: widthSize,
              child: const Divider(
                thickness: 1,
              ),
            ),
          );
        },
        itemCount: list.length + 1,
        itemBuilder: (context, index) {
          if (index == list.length) {
            return SizedBox(
              width: width - 5,
              height: cellHeight,
              child: IconButton(
                  onPressed: () async {
// 해당 폴더 아이디에  운동 종목 추가하는 함수 실행 할 것.
// Class 에서 alert 창을 볼루서 추가/제거한다.
// 일단 기존에 폴더에 들어있는 스포츠들을  불러와서  폴더에 있는 스포츠 리스트를 관리하기 위한 임시 상태 tempStateProviderForEditFolder 에 넣어둔다.
                    ref.read(tempStateProviderForEditFolder(folderID).notifier).getSportInFolder();
//그리고 편집을 위한 alert를 시작한다.
//alert 창에서 저장을 누르면, 폴더에 스포츠가 추가되는 기능만 해두었음.
// 하나하나 추가 삭제 하는게 편하긴한데, 실제 사용하면 불편할 듯 싶었다.
                    SportListInFolderManager manager =
                        SportListInFolderManager(context: context, ref: ref);
                    await manager.addSportInFolderAlert(folderID);
                  },
                  icon: Icon(
                    Icons.post_add,
                    size: fontSize(context, 6),
                  )),
            );
          }
          return CellSportList(
            width: width,
            eachheight: cellHeight,
            sportId: list[index].sportId,
            sportName: list[index].sportName,
            opt: opt,
            folderID: folderID,
          );
        },
      ),
    );
  }
}
