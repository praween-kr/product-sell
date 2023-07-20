import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/common_widget/common_button.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            const AppText(
              text: "Verification\nCode ",
              textSize: 30,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(
              height: 20,
            ),
            const AppText(
              text:
                  "We have sent the code verification \nto your Email address",
              textSize: 15,
              lineHeight: 1.3,
              fontWeight: FontWeight.w400,
              color: Color(0x80000000),
            ),
            const SizedBox(
              height: 20,
            ),
            const AppText(
              text: "OTP",
              textSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0x80000000),
            ),
            const SizedBox(
              height: 15,
            ),
            Pinput(
              length: 4,
              // preFilledWidget: AppText(
              //     //  text: "_",
              //     // color: AppColor.TextColor,
              //     ),
              defaultPinTheme: PinTheme(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      color: AppColor.TextColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColor.TextColor, width: 2))),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.bottomScreen);
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                decoration: const BoxDecoration(
                  color: AppColor.appcolor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      color: Color(0xff290000000),
                      // spreadRadius: 2,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      text: "Verify",
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            const Center(
              child: AppText(
                text: "Resend code",
                color: Colors.red,
                underline: true,
                underlineColor: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
