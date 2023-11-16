import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/app_text.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/common_widget/common_button.dart';

class AppDialogs {
  static confirm(BuildContext context,
          {required String msg,
          required Function clickOnYes,
          Function? clickOnNo}) =>
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
            type: MaterialType.transparency,
            child: Align(
              child: Container(
                width: 250,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    AppText(
                      text: msg,
                      textSize: 15,
                      color: AppColor.blackColor,
                      lineHeight: 1.6,
                      letterSpacing: 0.2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () => clickOnYes(),
                            child: CommonButton(
                              color: AppColor.appcolor,
                              radius: 25,
                              height: 40,
                              text: "Yes",
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                          GestureDetector(
                            onTap: clickOnNo != null
                                ? () => clickOnNo()
                                : () => Get.back(),
                            child: CommonButton(
                              color: AppColor.appcolor,
                              radius: 25,
                              height: 40,
                              text: " No ",
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ),
          );
        },
      );
}
