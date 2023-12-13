import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/settings/settings_controller.dart';
import 'package:oninto_flutter/common_widget/app_text.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/common_widget/common_button.dart';
import 'package:oninto_flutter/utils/colors_file.dart';

import '../../../common_widget/app_textfield.dart';

class PasswordScreen extends StatelessWidget {
  PasswordScreen({super.key});
  final SettingsController settingsController = Get.find();

  var oldPassVisible = true.obs;
  var newPassVisible = true.obs;
  var confirmPassVisible = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.white,
      appBar: CommonAppbarWidget(
        heading: "Password",
        textStyle: const TextStyle(
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 33.0,
                  ),
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
                        contentPadding:
                            const EdgeInsets.only(top: 8.0, left: 13.0),
                        //margin: const EdgeInsets.only(right: 35.0),
                        borderRadius: BorderRadius.circular(40),
                        containerColor: AppColor.TextColor,
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
                        contentPadding:
                            const EdgeInsets.only(top: 8.0, left: 13.0),
                        //margin: const EdgeInsets.only(right: 35.0),
                        borderRadius: BorderRadius.circular(40),
                        containerColor: AppColor.TextColor,
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
                  const SizedBox(
                    height: 22.0,
                  ),
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
                        contentPadding:
                            const EdgeInsets.only(top: 8.0, left: 13.0),
                        //margin: const EdgeInsets.only(right: 35.0),
                        borderRadius: BorderRadius.circular(40),
                        containerColor: AppColor.TextColor,
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
                            confirmPassVisible.value =
                                !confirmPassVisible.value;
                          },
                        )),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              //Get.toNamed(Routes.verificationScreen);
              await settingsController.changePassword();
            },
            child: CommonButton(
              color: AppColor.appcolor,
              margin: const EdgeInsets.only(right: 30, left: 30, bottom: 35),
              height: 57,
              text: "Update",
              textStyle: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
