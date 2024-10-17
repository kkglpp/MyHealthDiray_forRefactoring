import 'package:flutter/material.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';

class WidgetCustomFltBtn extends StatelessWidget {
  final Function() onTap;
  const WidgetCustomFltBtn({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
          onPressed: () {
           onTap();
          },
          icon: Container(
            color: Colors.white.withAlpha(1),
            child: const Icon(
              Icons.add_box_outlined,
              size: 60,
              color: constMainColor,
            ),
          ),

          );
  }
}