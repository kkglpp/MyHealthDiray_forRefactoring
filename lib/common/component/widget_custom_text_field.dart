
import 'package:flutter/material.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';
import 'package:myhealthdiary_app/common/const/size.dart';

class WidgetCustomTextField extends StatelessWidget {
  final double width;
  final double height;
  final String? hintText;
  final String? errorText;
  final bool obscure;
  final bool autofocus;
  final int maxLength;
  final ValueChanged<String>? onchanged;
  const WidgetCustomTextField({
    super.key,
    this.width = 100,
    this.height = 80,
    this.hintText,
    this.errorText,
    this.obscure = false,
    this.autofocus = false,
    this.maxLength=15,
    required this.onchanged,
  });

  @override
  Widget build(BuildContext context) {
    const baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: constBorderColor,
        width: 0.5,
      ),
    );

    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        cursorColor: constMainColor,
        obscureText: obscure,
        autofocus: autofocus,
        onChanged: onchanged,
        maxLength: maxLength,
        style: TextStyle(fontSize: fontSize(context, 2.5)),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(5),
            hintText: hintText,
            errorText: errorText,
            hintStyle:  TextStyle(color: constMainColor, fontSize: fontSize(context, 2)),
            fillColor: constInputColor,
            filled: true,
            border: baseBorder,
            counterText: '',
            focusedBorder: baseBorder.copyWith(
                borderSide:
                    baseBorder.borderSide.copyWith(color: constMainColor))),
      ),
    );
  }
}
