import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/app_text.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/common_widget/common_button.dart';
import 'package:oninto_flutter/utills/colors_file.dart';
import 'package:oninto_flutter/views/settings/password/password_controller.dart';
import '../../../common_widget/app_textfield.dart';

class PasswordScreen extends StatelessWidget {
   PasswordScreen({super.key});
  final controller = Get.put(PasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CommonAppbarWidget(
        heading: "Password",
        textStyle: const TextStyle(
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 33.0,),
            const AppText(text: "Old Password",
            style: AppTextStyle.medium,
              textSize: 13.0,
              color: AppColor.blackColor,
            ),
            const SizedBox(height: 14.0),
            // Obx(()=>
             AppTextField(
                  height: 46.0,
                // controller: controller.oldPasswordTextController,
                 //isObscure: controller.oldPassword.value,
                  contentPadding: const EdgeInsets.only(top: 8.0,left: 13.0),
                  margin: const EdgeInsets.only(right: 35.0),
                  borderRadius: BorderRadius.circular(40),
                  containerColor: AppColor.TextColor,
                  suffix:  Icon(Icons.visibility,size: 14.0,
                  color: AppColor.blackColor.withOpacity(0.3),
                  ),
                ),
            //),
            const SizedBox(height: 22.0,),
            const AppText(text: "New Password",
              style: AppTextStyle.medium,
              textSize: 13.0,
              color: AppColor.blackColor,
            ),
            const SizedBox(height: 14.0),
            // Obx(() =>
                   AppTextField(
                    height: 46.0,
                   // isObscure: controller.newPassWord.value,
                   // controller: controller.newPasswordTextController,
                    contentPadding: const EdgeInsets.only(top: 8.0,left: 13.0),
                    margin: const EdgeInsets.only(right: 35.0),
                    borderRadius: BorderRadius.circular(40),
                    containerColor: AppColor.TextColor,
                    suffix:  Icon(Icons.visibility,size: 14.0,
                      color: AppColor.blackColor.withOpacity(0.3),
                    ),
                  ),
      //),
            const SizedBox(height: 22.0,),
            const AppText(text: "Confirm New Password",
              style: AppTextStyle.medium,
              textSize: 13.0,
              color: AppColor.blackColor,
            ),
            const SizedBox(height: 14.0),
            // Obx(() =>
               AppTextField(
                    height: 46.0,
                  //  isObscure: controller.confirmNewPass.value,
                  //  controller: controller.confirmNewPasswordTextController,
                    contentPadding: const EdgeInsets.only(top: 8.0,left: 13.0),
                    margin: const EdgeInsets.only(right: 35.0),
                    borderRadius: BorderRadius.circular(40),
                    containerColor: AppColor.TextColor,
                    suffix:  Icon(Icons.visibility,size: 14.0,
                      color: AppColor.blackColor.withOpacity(0.3),
                    ),
                  ),
            //),
          const SizedBox(height: 30.0,),
            GestureDetector(
              onTap: () {
                //Get.toNamed(Routes.verificationScreen);
              },
              child: CommonButton(
                color: AppColor.appcolor,
                margin: const EdgeInsets.only(right: 30),
                height: 57,
                text: "Update",
                textStyle: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
