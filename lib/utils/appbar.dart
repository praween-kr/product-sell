import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/utils/color_constant.dart';

class CommonAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? heading;
  final Widget? headingChild;
  final VoidCallback? onBackPress;
  final IconData? iconData;
  final TextStyle? textStyle;
  final Widget? leading;
  final double? preferredHeight;
  final Widget? action;

  const CommonAppbarWidget(
      {super.key,
      this.heading,
      this.headingChild,
      this.iconData,
      this.textStyle,
      this.leading,
      this.onBackPress,
      this.action,
      this.preferredHeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: headingChild ??
            Text(
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
                margin: const EdgeInsets.only(
                    left: 20, right: 5, top: 5, bottom: 5),
                padding: const EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                    color: AppColor.appColor,
                    borderRadius: BorderRadius.circular(15)),
                child: const Icon(Icons.arrow_back_ios, color: Colors.white),
              ),
            ),
        leadingWidth: 70,
        actions: action == null
            ? []
            : [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 5, right: 20, top: 5, bottom: 5),
                  child: action ?? const Icon(Icons.add),
                )
              ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
