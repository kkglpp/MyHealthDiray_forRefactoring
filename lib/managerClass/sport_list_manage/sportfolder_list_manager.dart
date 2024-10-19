// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/base_alert.dart';
import 'package:myhealthdiary_app/common/const/size.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_text_box.dart';
import 'package:myhealthdiary_app/common/widget/widget_custom_text_field.dart';
import 'package:myhealthdiary_app/common/widget/widget_double_btn.dart';

import '../../provider/sort_folder_state_notifier.dart';
import '../../provider/sport_folder_list_state_notifier.dart';


class SportFolderListManager {
  final BuildContext context;
  final WidgetRef ref;

  SportFolderListManager({required this.context, required this.ref});

// 폴더를 추가하는 alert 함수
  addFodlerAlert() {
    double width = MediaQuery.of(context).size.width * 0.8;
    double height = MediaQuery.of(context).size.height * 0.3;
    double titleFsize = fontSize(context, 6);
    double contentHeight = height *0.3;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: WidgetCustomTextBox(
            width: width,
            height: height * 0.2,
            msg: "폴더명 입력",
            fontSize: titleFsize,
          ),
          content: SizedBox(
            // color: Colors.amber,
            width: width,
            height: contentHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetCustomTextField(
                  hintText: "폴더명 : 최대 10글자",
                  width: width / 2,
                  height: height * 0.2,
                  maxLength: 10,
                  onchanged: (newName) {
                    ref
                        .read(sortFolderStateProvider.notifier)
                        .changeFolderName(newName);
                  },
                ),
              ],
            ),
          ),
          actions: [
            WidgetDoubleBtn(
              leftFunc: () {
                context.pop();
              },
              rightFunc: () async {
                // 저장하고 -> 에러처리하고 -> 초기화 하고 -> 돌아갈 화면 초기화 하기
                bool result = await ref
                    .read(sortFolderStateProvider.notifier)
                    .saveFolder(); //저장하기
                if (!result) {
                  baseAlertForConfirm(context, "오류가 발생하였습니다.");
                  context.pop(); //화면으로 돌아가고
                  return;
                } // 에러처리하고
                await ref
                    .read(sortFolderStateProvider.notifier)
                    .setSampleModel(); // 초기화 하고
                await ref
                    .read(folderListProvider.notifier)
                    .setState(); //돌아가 화면에서 바뀔 부분 초기화
                context.pop(); //화면으로 돌아가고
              },
              width: width,
              height: height*0.2,
            ),
          ],
        );
      },
    );
  }
} //end class
