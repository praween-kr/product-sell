import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home_controller.dart';
import 'package:oninto_flutter/common_widget/app_textfield.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';
import '../../utills/colors_file.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final controller = Get.put(Homecontroller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.toNamed(Routes.forgotScreen);
                  },
                  child: const Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: AppText(
                      text: "Trouble logging In? ",
                      color: Colors.black,
                      underline: true,
                      underlineColor: Colors.black,
                      fontWeight: FontWeight.w400,
                      textSize: 12,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 120,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 0, left: 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: AppText(
                      text: "Welcome Back !",
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      textSize: 35,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const AppText(
                  text: "Login your details",
                  color: Color(0xff292929),
                  fontWeight: FontWeight.w400,
                  textSize: 15,
                ),
                const SizedBox(
                  height: 40,
                ),
                const AppText(
                  text: "Phone Number/ Email",
                  color: Color(0x80000000),
                  fontWeight: FontWeight.w400,
                  textSize: 14,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                  title: "jennySmith@gmail.com",
                  prefix: const Icon(
                    Icons.email_outlined,
                    color: Colors.black,
                  ),
                  containerColor: AppColor.TextColor,
                  contentPadding: const EdgeInsets.only(
                    top: 30,
                    left: 20,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const AppText(
                  text: "Password",
                  color: Color(0x80000000),
                  fontWeight: FontWeight.w400,
                  textSize: 14,
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => AppTextField(
                    title: "*******",
                    isObscure: controller.homePass.value,
                    maxLines: 1,
                    contentPadding: const EdgeInsets.only(
                      top: 30,
                      left: 20,
                    ),
                    style: const TextStyle(color: Colors.black),
                    prefix: const Icon(Icons.lock_open),
                    suffix: GestureDetector(
                      onTap: () {
                        controller.homePass.value = !controller.homePass.value;
                      },
                      child: controller.homePass.value
                          ? const Icon(Icons.remove_red_eye_outlined)
                          : const Icon(Icons.visibility_off_outlined),
                    ),
                    containerColor: AppColor.TextColor,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Obx(
                  () => Row(
                    children: [
                      Transform.scale(
                          scaleY: 0.8,
                          scaleX: 0.8,
                          child: CupertinoSwitch(
                            value: controller.Switch.value,
                            onChanged: (value) {
                              controller.Switch.value =
                                  !controller.Switch.value;
                            },
                            activeColor: Colors.red,
                            trackColor: themeColor,
                          )),
                      const AppText(
                        text: "Remember me",
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        textSize: 13,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.bottomScreen);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.height * 0.35,
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
                          text: "Sign In",
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
                const SizedBox(height: 30),
                const Center(
                    child: AppText(
                  text: "Sign in with",
                  textSize: 16,
                )),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(boxShadow: const [
                          BoxShadow(
                              color: Color(0xff29000000),
                              offset: Offset(5, 5),
                              blurRadius: 5)
                        ], borderRadius: BorderRadius.circular(15)),
                        child: Image.asset(Assets.assetsGoogle,
                            height: 50, width: 50)),
                    const SizedBox(width: 20),
                    Container(
                        decoration: BoxDecoration(boxShadow: const [
                          BoxShadow(
                              color: Color(0xff29000000),
                              offset: Offset(5, 5),
                              blurRadius: 5)
                        ], borderRadius: BorderRadius.circular(15)),
                        child: Image.asset(Assets.assetsFb,
                            height: 50, width: 50)),
                    const SizedBox(width: 20),
                    Container(
                        decoration: BoxDecoration(boxShadow: const [
                          BoxShadow(
                              color: Color(0xff29000000),
                              offset: Offset(5, 5),
                              blurRadius: 5)
                        ], borderRadius: BorderRadius.circular(15)),
                        child: Image.asset(Assets.assetsApple,
                            height: 50, width: 50)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                        text: "Don't have an account  ",
                        style: TextStyle(
                          color: Color(0xff000000),
                        ),
                        children: [
                          TextSpan(
                              text: "SIGN UP",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(Routes.signupScreen);
                                },
                              style: TextStyle(
                                color: Color(0xffF1A339),
                              ))
                        ]),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
