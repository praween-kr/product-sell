import 'package:flutter/material.dart';
import 'package:oninto_flutter/common_widget/app_string.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/common_widget/common_button.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';

class GyradosScreen extends StatelessWidget {
  const GyradosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(
        heading: "Gyarados Ex",
        textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 18,
            fontFamily: "Poppins"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Image.asset(Assets.assetsparker),
              Positioned(
                  left: 20,
                  top: MediaQuery.of(context).size.height * 0.25,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        Assets.assetsgyrados,
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Image.asset(
                        Assets.assetsgyrados1,
                        height: 80,
                        width: 80,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Stack(children: [
                        Image.asset(
                          Assets.assetspokemon,
                          height: 80,
                          width: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Image.asset(
                            Assets.assetsVideo,
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ]),
                    ],
                  )),
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    text: "Gyarados EX",
                    textSize: 14,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  AppText(
                    text: AppStrings.Gyrados,
                    textSize: 11,
                    fontFamily: "Poppins",
                    lineHeight: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: "Volume: 0",
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                        textSize: 14,
                      ),
                      AppText(
                        text: "High: 1.00",
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                        textSize: 14,
                      ),
                      AppText(
                        text: "Low: 1.00",
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                        textSize: 14,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: "Last Trade Price: \$1.00",
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                        textSize: 14,
                      ),
                      AppText(
                        text: "Available Shares: 0/300",
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                        textSize: 14,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CommonButton(
                    height: 50,
                    color: AppColor.appcolor,
                    text: "Community",
                    textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins",
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
