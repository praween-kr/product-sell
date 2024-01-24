import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utils/appbar.dart';
import 'package:oninto_flutter/utils/common_button.dart';
import 'package:oninto_flutter/views/settingScreen/controller/subscription_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../utils/app_text.dart';
import '../../../utils/color_constant.dart';

class SubscriptionScreen extends StatelessWidget {
  SubscriptionScreen({super.key});
  final controller = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    // String value = "";
    // /// Button Text Arguments View
    // if(Get.arguments != null){
    //   value = Get.arguments;
    // }
    return Scaffold(
        backgroundColor: AppColor.white,
        resizeToAvoidBottomInset: false,
        appBar: const CommonAppbarWidget(
          heading: "Choose plan",
          textStyle: TextStyle(
              fontSize: 20,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w500,
              fontFamily: "Poppins"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  planWidget(),
                  Transform.scale(
                      scale: .5,
                      child: SmoothPageIndicator(
                        controller: controller.pageController,
                        count: 3,
                        effect: ExpandingDotsEffect(
                            spacing: 15.0,
                            activeDotColor: AppColor.appColor,
                            dotColor: AppColor.appColor.withOpacity(0.4),
                            dotWidth: 10),
                        onDotClicked: (index) {},
                      )),
                ],
              ),
              // CommonButton(
              //   color: value == "plan" ? AppColor.appcolor:
              //   AppColor.TextColor,
              //   margin: const EdgeInsets.only(right: 30,left: 30,bottom: 30),
              //   height: 57,
              //   text:  value ==  "plan"
              //   ? "Select Plan" : "Your Current Plan",
              //   textStyle:  TextStyle(
              //       color: value == "plan" ? AppColor.white:
              //       AppColor.blackColor.withOpacity(0.4),
              //       fontSize: 12,fontFamily: "Poppins"),
              // ),
              const SizedBox(height: 30),
              CommonButton(
                color: AppColor.textColor,
                margin: const EdgeInsets.only(right: 30, left: 30, bottom: 30),
                height: 58,
                text: "Your Current Plan",
                textStyle: TextStyle(
                    color: AppColor.blackColor.withOpacity(0.4),
                    fontSize: 15,
                    fontFamily: "Poppins"),
              ),

              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.selectPlanScreen);
                },
                child: const CommonButton(
                  color: AppColor.appColor,
                  margin: EdgeInsets.only(right: 30, left: 30, bottom: 30),
                  height: 56,
                  text: "Change Plan",
                  textStyle: TextStyle(
                      color: AppColor.white,
                      fontSize: 15,
                      fontFamily: "Poppins"),
                ),
              ),
            ],
          ),
        ));
  }

  planWidget() {
    return SizedBox(
      height: Get.height * 0.55,
      child: PageView.builder(
          itemCount: 3,
          controller: controller.pageController,
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  const AppText(
                      text: "Basic",
                      style: AppTextStyle.title,
                      textSize: 20.0,
                      color: AppColor.blackColor),
                  const SizedBox(height: 6.0),
                  AppText(
                    text: "For small and medium business",
                    style: AppTextStyle.regular,
                    textSize: 15.0,
                    color: AppColor.blackColor.withOpacity(0.4),
                  ),
                  const SizedBox(height: 40.0),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                          text: "\$",
                          style: AppTextStyle.title,
                          textSize: 15.0,
                          color: AppColor.appColor),
                      AppText(
                          text: "200",
                          style: AppTextStyle.title,
                          textSize: 49.0,
                          color: AppColor.appColor),
                    ],
                  ),
                  const SizedBox(height: 2.0),
                  AppText(
                    text: "per month",
                    style: AppTextStyle.regular,
                    textSize: 15.0,
                    color: AppColor.blackColor.withOpacity(0.4),
                  ),
                  const SizedBox(height: 30.0),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      4,
                      (index) => const Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.circle,
                                color: AppColor.appColor, size: 8.0),
                            SizedBox(width: 13.0),
                            AppText(
                                text: "Lorem ipsum is a dummy text",
                                style: AppTextStyle.regular,
                                textSize: 15.0,
                                color: AppColor.blackColor),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
