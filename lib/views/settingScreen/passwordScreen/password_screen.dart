import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/settings/settings_controller.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/appbar.dart';
import 'package:oninto_flutter/utils/color_constant.dart';

import '../../../utils/app_text_field.dart';
import '../../../utils/common_button.dart';

// ignore: must_be_immutable
class PasswordScreen extends StatelessWidget {
  PasswordScreen({super.key});
  final SettingsController settingsController = Get.find();

  var oldPassVisible = true.obs;
  var newPassVisible = true.obs;
  var confirmPassVisible = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const CommonAppbarWidget(
        heading: "Password",
        textStyle: TextStyle(
            fontSize: 20,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 33.0),
              const AppText(
                text: "Old Password",
                style: AppTextStyle.medium,
                textSize: 13.0,
                color: AppColor.blackColor,
              ),
              const SizedBox(height: 14.0),
              Obx(
                () => AppTextField(
                    height: 46.0,
                    controller: settingsController.oldPassword,
                    isObscure: oldPassVisible.value,
                    maxLines: 1,
                    contentPadding: const EdgeInsets.only(top: 8.0, left: 13.0),
                    //margin: const EdgeInsets.only(right: 35.0),
                    borderRadius: BorderRadius.circular(40),
                    containerColor: AppColor.textColor,
                    suffix: IconButton(
                      icon: oldPassVisible.value
                          ? Icon(
                              Icons.visibility_off,
                              size: 20,
                              color: AppColor.blackColor.withOpacity(0.3),
                            )
                          : Icon(
                              Icons.visibility,
                              size: 20,
                              color: AppColor.blackColor.withOpacity(0.3),
                            ),
                      onPressed: () {
                        oldPassVisible.value = !oldPassVisible.value;
                      },
                    )),
              ),
              const SizedBox(
                height: 22.0,
              ),
              const AppText(
                text: "New Password",
                style: AppTextStyle.medium,
                textSize: 13.0,
                color: AppColor.blackColor,
              ),
              const SizedBox(height: 14.0),
              Obx(
                () => AppTextField(
                    height: 46.0,
                    isObscure: newPassVisible.value,
                    controller: settingsController.newPassword,
                    maxLines: 1,
                    contentPadding: const EdgeInsets.only(top: 8.0, left: 13.0),
                    //margin: const EdgeInsets.only(right: 35.0),
                    borderRadius: BorderRadius.circular(40),
                    containerColor: AppColor.textColor,
                    suffix: IconButton(
                      icon: newPassVisible.value
                          ? Icon(
                              Icons.visibility_off,
                              size: 20,
                              color: AppColor.blackColor.withOpacity(0.3),
                            )
                          : Icon(
                              Icons.visibility,
                              size: 20,
                              color: AppColor.blackColor.withOpacity(0.3),
                            ),
                      onPressed: () {
                        newPassVisible.value = !newPassVisible.value;
                      },
                    )),
              ),
              const SizedBox(height: 22.0),
              const AppText(
                text: "Confirm New Password",
                style: AppTextStyle.medium,
                textSize: 13.0,
                color: AppColor.blackColor,
              ),
              const SizedBox(height: 14.0),
              Obx(
                () => AppTextField(
                  height: 46.0,
                  isObscure: confirmPassVisible.value,
                  controller: settingsController.confirmPassword,
                  maxLines: 1,
                  contentPadding: const EdgeInsets.only(top: 8.0, left: 13.0),
                  //margin: const EdgeInsets.only(right: 35.0),
                  borderRadius: BorderRadius.circular(40),
                  containerColor: AppColor.textColor,
                  suffix: IconButton(
                    icon: confirmPassVisible.value
                        ? Icon(
                            Icons.visibility_off,
                            size: 20,
                            color: AppColor.blackColor.withOpacity(0.3),
                          )
                        : Icon(
                            Icons.visibility,
                            size: 20,
                            color: AppColor.blackColor.withOpacity(0.3),
                          ),
                    onPressed: () {
                      confirmPassVisible.value = !confirmPassVisible.value;
                    },
                  ),
                ),
              ),
              SizedBox(height: context.height * 0.1),
              GestureDetector(
                onTap: () async {
                  //Get.toNamed(Routes.verificationScreen);
                  await settingsController.changePassword();
                },
                child: const CommonButton(
                  color: AppColor.appColor,
                  height: 57,
                  text: "Update",
                  textStyle: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
