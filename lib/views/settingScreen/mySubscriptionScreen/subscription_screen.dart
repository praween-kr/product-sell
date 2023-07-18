import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/common_button.dart';
import 'package:oninto_flutter/utills/colors_file.dart';
import 'package:oninto_flutter/views/settingScreen/controller/subscription_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../common_widget/color_constant.dart';
import '../../../utills/common_appbar.dart';

class SubscriptionScreen extends StatelessWidget {
  SubscriptionScreen({super.key});
  final controller = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CommonAppbarWidget(
        heading: "Choose plan",
        textStyle: const TextStyle(
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body:  Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 const SizedBox(height: 24.0,),
                 const AppText(text: "Basic",
                  style: AppTextStyle.title,
                  textSize: 20.0,
                  color: AppColor.blackColor,
                ),
                 const SizedBox(height: 6.0,),
                  AppText(text: "For small and medium business",
                  style: AppTextStyle.regular,
                  textSize: 15.0,
                  color: AppColor.blackColor.withOpacity(0.4),
                ),
                const SizedBox(height: 40.0,),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(text: "\$",
                      style: AppTextStyle.title,
                      textSize: 15.0,
                      color: AppColor.appcolor,
                    ),
                    AppText(text: "200",
                      style: AppTextStyle.title,
                      textSize: 49.0,
                      color: AppColor.appcolor,
                    ),
                  ],
                ),
                const SizedBox(height: 2.0,),
                 AppText(text: "per month",
                  style: AppTextStyle.regular,
                  textSize: 15.0,
                  color: AppColor.blackColor.withOpacity(0.4),
                ),
                const SizedBox(height: 30.0,),
                ListView.builder(
                  itemCount: 4,
                    shrinkWrap: true,
                    itemBuilder: (context, position){
                      return const Padding(
                        padding: EdgeInsets.only(bottom: 15.0),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.circle,color: AppColor.appcolor,size: 8.0,),
                            SizedBox(width: 13.0,),
                            AppText(text: "Lorem ipsum is a dummy text",
                              style: AppTextStyle.regular,
                              textSize: 15.0,
                              color: AppColor.blackColor,
                            ),
                          ],
                        ),
                      );
                    }
                ),
                const SizedBox(height: 20.0,),
                Transform.scale(
                    scale: .5,
                    child: SmoothPageIndicator(
                      controller: controller.pageController,
                      count: 3,
                      effect:  ExpandingDotsEffect(
                        spacing: 15.0,
                          activeDotColor:AppColor.appcolor,
                          dotColor: AppColor.appcolor.withOpacity(0.4),
                          dotWidth: 10),
                      onDotClicked: (index) {},
                    )),
              ],
            ),
          ),
          CommonButton(
            color: AppColor.TextColor,
            margin: const EdgeInsets.only(right: 30,left: 30,bottom: 30),
            height: 57,
            text: "Your Current Plan",
            textStyle:  TextStyle(
                color: AppColor.blackColor.withOpacity(0.4),
                fontSize: 12,fontFamily: "Poppins"),
          ),
        ],
      ),
    );
  }
}
