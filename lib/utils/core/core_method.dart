import 'package:flutter/widgets.dart';

import '../app_text.dart';
import '../color_constant.dart';

class AppCore {
  static String productSizeText(List<String> list) {
    String sizeText = "";
    for (int i = 0; i < list.length; i++) {
      if (i != 0) {
        sizeText += "/";
      }
      sizeText += list[i];
    }
    return sizeText;
  }

  static Widget shreTag() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
        decoration: BoxDecoration(
          color: AppColor.appColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const AppText(
          text: "Share",
          color: AppColor.appColor,
          textSize: 11,
        ),
      );
  static Widget soldTag({String? level}) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          color: AppColor.green.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: AppText(
          text: level ?? "Sold",
          color: AppColor.green,
          textSize: 12,
        ),
      );
}
