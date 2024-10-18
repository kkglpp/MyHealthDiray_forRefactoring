import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myhealthdiary_app/common/const/colors.dart';
import 'package:myhealthdiary_app/view/home.dart';

class BaseLayout extends StatelessWidget {
  final bool? appbarOption;
  final Color? appbarColor;
  final Color? appbarTextColor;
  final String? barTitle;
  final Widget body;
  final Widget? floatbtn;
  final bool keyboardResize;
  final Widget? leadbtn;
  const BaseLayout({super.key, 
    this.appbarOption = true,
    this.appbarColor = constMainColor,
    this.barTitle="",
    required this.body,
    this.appbarTextColor = constonMainColor,
    this.floatbtn,
    this.keyboardResize = false,
    this.leadbtn,
  });

  @override
  Widget build(BuildContext context) {
    final leadBtn = leadbtn?? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.pop();
                },
              );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: appbarOption == true
          ? AppBar(
              backgroundColor: appbarColor,
              foregroundColor: appbarTextColor,
              title: Text(barTitle!),
              leading: leadBtn,
            )
          : null,
      body: SafeArea(child: body),
      floatingActionButton: floatbtn,
    );
  }
  void handleAsyncError(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Home(),));
  }
}
