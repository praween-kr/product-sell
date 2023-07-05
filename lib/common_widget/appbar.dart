import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';

class CommonAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  String? heading;
  final VoidCallback? onBackPress;
  IconData? iconData;
  TextStyle? textStyle;
  Widget? leading;
  double? preferredheight;
  Widget? action;

  CommonAppbarWidget(
      {this.heading,
      this.iconData,
      this.textStyle,
      this.leading,
      this.onBackPress,
      this.action,
      this.preferredheight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          heading ?? "",
          style: textStyle ??
              const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
        ),
        leading: leading ??
            GestureDetector(
              onTap: onBackPress ??
                  () {
                    Get.back();
                  },
              child: Container(
                margin: EdgeInsets.all(5),
                padding: const EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                    color: AppColor.appcolor,
                    borderRadius: BorderRadius.circular(15)),
                child: const Icon(Icons.arrow_back_ios),
              ),
            ),
        actions: [action ?? Icon(Icons.add)],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
