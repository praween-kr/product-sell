import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';

class CommonAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  String? heading;
  IconData? iconData;
  TextStyle? textStyle;
  Widget? leading;
  double? preferredheight;

  CommonAppbarWidget(
      {this.heading,
      this.iconData,
      this.textStyle,
      this.leading,
      this.preferredheight});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        heading ?? "",
        style: textStyle ??
            const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),
      ),
      leading: leading ??
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              padding: const EdgeInsets.only(left: 12),
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  color: AppColor.appcolor,
                  borderRadius: BorderRadius.circular(15)),
              child: const Icon(Icons.arrow_back_ios),
            ),
          ),
      actions: [
        Icon(
          iconData,
          color: Colors.red,
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
