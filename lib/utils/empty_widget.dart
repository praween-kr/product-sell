import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:oninto_flutter/generated/assets.dart';

import 'color_constant.dart';

class EmptyWidgets {
  static Widget simple({String? text, Color? textColor, Function? refresh}) =>
      SingleChildScrollView(
        physics: const ClampingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: SizedBox(
          height: Get.height * 0.8,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 0, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(Assets.lottieNoData),
                const SizedBox(height: 25),
                refresh == null
                    ? const SizedBox.shrink()
                    : GestureDetector(
                        onTap: () => refresh(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColor.themeColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColor.grey.withOpacity(0.5),
                                blurRadius: 20,
                                spreadRadius: 8,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.refresh,
                            color: AppColor.white,
                            size: Get.width * 0.1,
                          ),
                        ),
                      ),
              ],
            ),
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
