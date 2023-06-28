import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';

class CommonAppbarWidget extends StatelessWidget {
  String? heading;

  CommonAppbarWidget({this.heading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(heading ?? ""),
      leading: Container(
        margin: EdgeInsets.only(left: 20),
        padding: EdgeInsets.only(left: 10),
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            color: AppColor.appcolor, borderRadius: BorderRadius.circular(15)),
        child: Icon(Icons.arrow_back_ios),
      ),
      actions: [Icon(Icons.filter_alt_rounded)],
    );
  }
}
