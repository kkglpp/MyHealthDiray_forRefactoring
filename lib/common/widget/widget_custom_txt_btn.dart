import 'package:flutter/material.dart';

//Sizedbox부터 return
class WidgetCustomTxtBtn extends StatelessWidget {
  final String txt;
  final double width;
  final double height;
  final double fsize;
  final Color clr;
  final Function onTap;

  const WidgetCustomTxtBtn({super.key, required this.txt,required this.width,required this.height, required this.fsize, required this.clr, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
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
        ),
    );
  }
}