import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/auth/auth_controller.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/service/local/userInfo_globle.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';
import 'package:pinput/pinput.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({super.key});
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    print(
        "ppsss--->> ${UserStoredInfo().userInfo?.email ?? ''} --- ${authController.verifyEmail.value}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 20, right: 20),
        child: SingleChildScrollView(
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
              const SizedBox(height: 20),
              AppText(
                text:
                    "We have sent the code verification \nto your Email address ${authController.verifyEmail.value}",
                textSize: 15,
                lineHeight: 1.3,
                fontWeight: FontWeight.w400,
                color: const Color(0x80000000),
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
                onChanged: (v) {
                  authController.otp.value = v;
                },
                // preFilledWidget: AppText(
                //     //  text: "_",
                //     // color: AppColor.TextColor,
                //     ),
                defaultPinTheme: PinTheme(
                    height: 80,
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                    width: 80,
                    decoration: BoxDecoration(
                        color: AppColor.TextColor,
                        borderRadius: BorderRadius.circular(20),
                        border:
                            Border.all(color: AppColor.TextColor, width: 2))),
              ),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () async {
                  await authController.verity();
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
                      AppText(text: "Verify", color: Colors.white),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward, color: Colors.white)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Center(
                child: InkWell(
                  onTap: () async {
                    await authController.resendOtp();
                  },
                  child: const AppText(
                    text: "Resend code",
                    color: Colors.red,
                    underline: true,
                    underlineColor: Colors.red,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
