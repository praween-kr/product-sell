import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/settings/settings_controller.dart';
import 'package:oninto_flutter/common_widget/app_text.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';

import '../../../common_widget/appbar.dart';
import '../../../utills/colors_file.dart';

class CmsScreen extends StatelessWidget {
  CmsScreen({super.key, required});
  final SettingsController settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CommonAppbarWidget(
        heading: Get.arguments == 1
            ? 'Privacy Policy'
            : Get.arguments == 2
                ? 'Help Center'
                : Get.arguments == 3
                    ? 'About Us'
                    : "Privacy Policy",
        textStyle: const TextStyle(
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: const Padding(
        padding: EdgeInsets.only(left: 20.0, top: 27.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: "Lorem Ipsum is simply dummy text of the "
                  "printing and typesetting industry. Lorem Ipsum has been the industry's "
                  "standard dummy text ever since the 1500s, when an unknown printer took a "
                  "galley of type and scrambled it to make a type specimen book. "
                  "It has survived not only five centuries, "
                  "but also the leap into electronic typesetting, "
                  "remaining essentially unchanged.",
              style: AppTextStyle.regular,
              textSize: 15.0,
              color: AppColor.blackColor,
              letterSpacing: 0.2,
              lineHeight: 2.0,
            )
          ],
        ),
      ),
    );
  }
}
