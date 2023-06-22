import 'package:flutter/material.dart';

class CommonAppbarWidget {
  static AppBar commonAppBar(
      {required BuildContext context,
      String? title,
      String? iconType,
      required Function onTap}) {
    return AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        elevation: 0,
      leading:Container(
        margin: const EdgeInsets.only(left: 18,top: 25,bottom: 5),
        decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(10)),
        child: const Padding(
          padding: EdgeInsets.only(left: 10,),
          child: Icon(Icons.arrow_back_ios,size: 18,),
        ),
      ),
     );
  }
}
