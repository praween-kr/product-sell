import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/auth/auth_controller.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utils/app_print.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/app_text_field.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/utils/helper/social_login_helper.dart';
import 'package:oninto_flutter/utils/regex.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  // final controller = Get.put(Homecontroller());
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              const AppText(
                text: "Welcome Back!",
                color: Colors.black,
                fontWeight: FontWeight.w500,
                textSize: 35,
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
              const SizedBox(height: 10),
              AppTextField(
                title: "example@gmail.com",
                controller: authController.inputPhoneEmail,
                hintStyle: const TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w400),
                onChanged: (v) {
                  authController.usernameIsPhoneType.value =
                      AppRegex.num0to9Only.hasMatch(v.trim());
                  AppPrint.info(
                      authController.usernameIsPhoneType.value.toString());
                  if (v == '') {
                    authController.usernameIsPhoneType.value = false;
                  }
                },
                prefix: Obx(
                  () => authController.usernameIsPhoneType.value
                      ? Container(
                          margin: const EdgeInsets.only(right: 15),
                          decoration: const BoxDecoration(
                              color: AppColor.appColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CountryCodePicker(
                                padding: EdgeInsets.zero,
                                textStyle: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                                enabled: true,
                                showFlag: false,
                                alignLeft: false,
                                onChanged: (CountryCode country) {
                                  if (country.dialCode != null) {
                                    authController.countryCode.value =
                                        country.dialCode!.split('+').last;
                                    AppPrint.all(
                                        authController.countryCode.value);
                                  }
                                },
                              ),
                              const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                                size: 25,
                              ),
                            ],
                          ),
                        )
                      : const Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        ),
                ),
                containerColor: AppColor.textColor,
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
                  controller: authController.inputPassword,
                  onChanged: (text) {
                    if (text.trim() == '') {
                      authController.inputPassword.clear();
                    }
                  },
                  title: "*******",
                  hintStyle: const TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),
                  isObscure: authController.passVisible.value,
                  maxLines: 1,
                  contentPadding: const EdgeInsets.only(
                    top: 35,
                    left: 20,
                  ),
                  style: const TextStyle(color: Colors.black),
                  prefix: Icon(Icons.lock_open,
                      color: AppColor.blackColor.withOpacity(0.6)),
                  suffix: GestureDetector(
                    onTap: () {
                      authController.passVisible.value =
                          !authController.passVisible.value;
                    },
                    child: authController.passVisible.value
                        ? const Icon(Icons.remove_red_eye_outlined)
                        : Icon(
                            Icons.visibility_off_outlined,
                            color: AppColor.blackColor.withOpacity(0.4),
                          ),
                  ),
                  containerColor: AppColor.textColor,
                ),
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 15),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Transform.scale(
                            scaleY: 0.8,
                            scaleX: 0.8,
                            child: CupertinoSwitch(
                              value: authController.rememberMe.value,
                              onChanged: (value) {
                                authController.rememberMe.value =
                                    !authController.rememberMe.value;
                              },
                              activeColor: AppColor.themeColor,
                              trackColor: Colors.grey.shade400,
                              thumbColor: Colors.grey.shade100,
                            )),
                        const AppText(
                          text: "Remember me",
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          textSize: 13,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.forgotScreen);
                      },
                      child: const AppText(
                        text: "Forgot password",
                        color: Colors.black,
                        underline: true,
                        underlineColor: Colors.black,
                        fontWeight: FontWeight.w400,
                        textSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () async {
                  AppPrint.info("---");
                  await authController.signin();
                  // print(" menu value ${controller.menu.value}");
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  decoration: const BoxDecoration(
                    color: AppColor.appColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 2),
                        color: Colors.black45,
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
                  socialLoginButton(
                      image: Assets.assetsGoogle,
                      onTap: () async {
                        var result = await SocialLoginHelper.loginWithGoogle();
                        print("result $result");
                      }),
                  const SizedBox(
                    width: 15,
                  ),
                  socialLoginButton(
                      image: Assets.assetsFb,
                      onTap: () async {
                        var fbResult =
                            await SocialLoginHelper.loginWithFacebook();
                        print("fbResult $fbResult");
                      }),
                  GetPlatform.isIOS
                      ? const SizedBox(
                          width: 15,
                        )
                      : Container(),
                  GetPlatform.isIOS
                      ? socialLoginButton(
                          image: Assets.assetsApple,
                          onTap: () async {
                            var appleResult =
                                await SocialLoginHelper.loginWithApple();
                            print("appleResult $appleResult");
                          })
                      : Container(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                      text: "Don't have an account  ",
                      style: const TextStyle(
                        color: Color(0xff000000),
                      ),
                      children: [
                        TextSpan(
                            text: "SIGN UP",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(Routes.signupScreen);
                              },
                            style: const TextStyle(
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
    );
  }

  Widget socialLoginButton({required String image, required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        elevation: 3,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Image.asset(image, height: 50, width: 50),
      ),
    );
  }
}
