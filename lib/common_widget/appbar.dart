import 'package:flutter/material.dart';

class CommonAppbarWidget {
  static AppBar commonAppBar(
      {required BuildContext context,
      String? title,
      String? iconType,
      required Function onTap}) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: 40,
      backgroundColor: Colors.white,
      elevation: 0,
      leading: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: Colors.yellowAccent,
            borderRadius: BorderRadius.circular(15)),
        child: Icon(Icons.arrow_back_ios),
      ),
      actions: [Icon(Icons.filter_alt_rounded)],
    );
  }
}
