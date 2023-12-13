import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/cms_controller.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';

import '../../../common_widget/appbar.dart';
import '../../../utils/colors_file.dart';

class CmsScreen extends StatelessWidget {
  CmsScreen({super.key, required});

  final CmsController cmsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CommonAppbarWidget(
        heading: Get.arguments == CmsType.privacyPolicy
            ? 'Privacy Policy'
            : Get.arguments == CmsType.help
                ? 'Help Center'
                : Get.arguments == CmsType.aboutUs
                    ? 'About Us'
                    : "Privacy Policy",
        textStyle: const TextStyle(
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: Obx(
        () => cmsController.loadingData.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Html(data: cmsController.cmsData.value),
                ),
              ),
      ),
    );
  }
}
