import 'package:flutter/material.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';

class BannerForAd extends StatelessWidget {
  const BannerForAd({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context,BoxConstraints constraints ) {
        final double width = constraints.maxWidth;
        final double height = (constraints.maxHeight * 0.12).clamp(width*1/6, width*1/6)
        ;
        return Container(
          color: constEmptyColor,
          width: width,
          height: height,
          child: const Center(child: Text("Box For AD")),
        );
      }
    );
  }
}