import 'package:flutter/material.dart';

class WidgetCustomTextBox extends StatelessWidget {
  final double? width;
  final double? height;
  final String msg;
  final double fontSize;
  final int maxLine;
  /// 0 -> 좌측 정렬, 1->가운데정렬, 2->우측정렬
  final int fontAlign;
  ///0-> 상단, 1-> 중앙, 2->하단
  final int verAlign;
  final Color fontColor;
  final bool bold;

  const WidgetCustomTextBox(
      {super.key,
      this.width ,
      this.height ,
      required this.msg,
      required this.fontSize,
      this.fontAlign = 1,
      this.verAlign = 1,
      this.fontColor = Colors.black,
      this.bold = false,
      this.maxLine = 2,
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ,
      height: height ,
      child: Column(
        mainAxisAlignment: verAlign==0? MainAxisAlignment.start:verAlign==1?MainAxisAlignment.center :MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: fontAlign == 0
                ? MainAxisAlignment.start
                : fontAlign == 1
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  msg,
                  textAlign: fontAlign == 0
                      ? TextAlign.left
                      : fontAlign == 1
                          ? TextAlign.center
                          : TextAlign.right,
                  maxLines: maxLine,        
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(
                      fontSize: fontSize,
                      color: fontColor,
                      fontWeight: bold ? FontWeight.bold : FontWeight.normal),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
