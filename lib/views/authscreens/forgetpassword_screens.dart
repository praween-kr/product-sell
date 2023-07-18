import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/app_textfield.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/common_widget/common_button.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';

class ForgotScreen extends StatelessWidget {
  const ForgotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonAppbarWidget(),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppText(
                  text: "Forgot\nPassword",
                  textSize: 30,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 20),
                const AppText(
                  text:
                      "Please enter your register email id. We will \nsend One Time Password on your\nemail id",
                  textSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0x80000000),
                  lineHeight: 1.3,
                ),
                const SizedBox(height: 20),
                const AppText(
                  text: "Email",
                  textSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0x80000000),
                ),
                const SizedBox(height: 10),
                AppTextField(
                  borderRadius: BorderRadius.circular(20),
                  title: "jennysmith@gmail.com",
                  containerColor: AppColor.TextColor,
                  prefix: const Icon(Icons.email_outlined),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.verificationScreen);
                  },
                  child: CommonButton(
                    color: AppColor.appcolor,
                   // margin: const EdgeInsets.only(right: 20,left: 20),
                    radius: 20,
                    height: 57,
                    text: "Send",
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
