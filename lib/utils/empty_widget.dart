import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:oninto_flutter/generated/assets.dart';

import 'color_constant.dart';


class EmptyWidgets {
  static Widget simple({String? text, Color? textColor}) =>
      SingleChildScrollView(
        physics: const ClampingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: SizedBox(
          height: Get.height * 0.8,
          child: Center(
              child: Padding(
            padding: EdgeInsets.only(bottom: Get.height * 0.2),
            child: Lottie.asset(Assets.lottieNoData),
          )),
        ),
      );
  static Widget noChatsYet({String? text, Color? textColor}) => SizedBox(
        height: Get.height * 0.8,
        child: Center(
            child: Stack(
          alignment: Alignment.center,
          children: [
            Lottie.asset(Assets.lottieNoMessage),
            Positioned(
              top: Get.height * 0.22,
              child: const Text(
                "No messages yet!",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColor.themeColor),
              ),
            )
          ],
        )),
      );
}
