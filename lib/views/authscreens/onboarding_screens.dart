import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home_controller.dart';
import 'package:oninto_flutter/common_widget/app_string.dart';
import 'package:oninto_flutter/common_widget/app_text.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utills/colors_file.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});
  final controller = Get.put(Homecontroller());

  @override
  Widget build(BuildContext context) {
    var dim = MediaQuery.of(context).size;
    return Scaffold(
        body: PageView.builder(
      // physics: const NeverScrollableScrollPhysics(),
      onPageChanged: controller.onPageChanged,
      itemCount: controller.onBoardingData.length,
      controller: controller.pageController,
      itemBuilder: (BuildContext context, int index) {
        var data = controller.onBoardingData[index];
        return Column(children: [
          Image.asset(
            data.image,
            fit: BoxFit.contain,
            height: dim.height * 0.6,
            width: dim.width,
          ),
          Expanded(
            child: Container(
                width: dim.width,
                //margin: EdgeInsets.only(top: dim.height * 0.30),
                padding: EdgeInsets.only(
                    top: dim.height * 0.06,
                    left: dim.width * 0.10,
                    right: dim.width * 0.10),
                decoration: const BoxDecoration(
                    color: Color(0xffF1A339),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      text: data.title,
                      textSize: 25,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AppText(
                        text: AppStrings.Onboarding,
                        textSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        lineHeight: 1.4),
                    SizedBox(height: 40),
                    /*Align(
                          alignment: Alignment.bottomCenter,
                          child: SmoothPageIndicator(
                            controller: controller.pageController,
                            count: controller.onBoardingData.length,
                            effect: const WormEffect(
                                activeDotColor: Colors.black,
                                dotColor: Colors.grey,
                                dotHeight: 12,
                                dotWidth: 12),
                          ),
                        ),*/
                    Transform.scale(
                        scale: .5,
                        child: SmoothPageIndicator(
                          controller: controller.pageController,
                          count: controller.onBoardingData.length,
                          effect: const ExpandingDotsEffect(
                              activeDotColor: Colors.black,
                              dotColor: Colors.grey,
                              dotWidth: 25),
                          onDotClicked: (index) {},
                        )),
                    /*GestureDetector(
                            onTap: () {
                              if (controller.pagePosition.value ==
                                  controller.onBoardingData.length - 1) {
                                Get.offAllNamed(Routes.loginScreen);
                              } else {
                                controller
                                    .nextScreen(controller.pagePosition.value);
                              }
                            },
                            child: Icon(Icons.arrow_forward)),*/
                  ],
                )),
          ),
        ]);
      },
    ));
  }
}
