import 'package:flutter/material.dart';

class WidgetCustomTxtBtn extends StatelessWidget {
  final String txt;
  final double fsize;
  final Color clr;
  final Function() onTap;

  const WidgetCustomTxtBtn({super.key, required this.txt, required this.fsize, required this.clr, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: clr,
      ),
      onPressed: (){
        onTap();
      },
      child: Text(
        txt,
        style: TextStyle(
          color: clr,
          fontSize: fsize
        ),
      ),
      );
  }
}