import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/settings/edit_profile_controller.dart';
import 'package:oninto_flutter/common_widget/app_textfield.dart';
import 'package:oninto_flutter/service/local/userInfo_global.dart';

import '../../../common_widget/app_text.dart';
import '../../../common_widget/appbar.dart';
import '../../../common_widget/color_constant.dart';
import '../../../common_widget/common_button.dart';
import '../../../generated/assets.dart';
import '../../../routes/routes.dart';
import '../../../utils/colors_file.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final GlobalController globleController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      resizeToAvoidBottomInset: false,
      appBar: CommonAppbarWidget(
        heading: "Profile",
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
              padding: const EdgeInsets.fromLTRB(25, 30, 24, 20),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: "First Name",
                      textSize: 15.0,
                      color: AppColor.blackColor.withOpacity(0.5),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    AppTextField(
                      height: 57.0,
                      title: globleController.userInfo.value?.firstName ?? '',
                      readOnly: true,
                      hintStyle: const TextStyle(
                          color: AppColor.blackColor, fontSize: 15),
                      style: const TextStyle(
                          color: AppColor.blackColor, fontSize: 15),
                      keyBoardType: TextInputAction.next,
                      textInputType: TextInputType.name,
                      contentPadding:
                          const EdgeInsets.only(top: 8.0, left: 13.0),
                      //margin: const EdgeInsets.only(right: 35.0),
                      borderRadius: BorderRadius.circular(19),
                      containerColor: AppColor.TextColor,
                      prefix: const Icon(
                        Icons.person_outline,
                        size: 30.0,
                        color: AppColor.blackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 17,
                    ),
                    AppText(
                      text: "Last Name",
                      textSize: 15.0,
                      color: AppColor.blackColor.withOpacity(0.5),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    AppTextField(
                      height: 57.0,
                      title: globleController.userInfo.value?.lastName ?? '',
                      readOnly: true,
                      hintStyle: const TextStyle(color: AppColor.blackColor),
                      keyBoardType: TextInputAction.next,
                      textInputType: TextInputType.name,
                      contentPadding:
                          const EdgeInsets.only(top: 8.0, left: 13.0),
                      //margin: const EdgeInsets.only(right: 35.0),
                      borderRadius: BorderRadius.circular(19),
                      containerColor: AppColor.TextColor,
                      prefix: const Icon(
                        Icons.person_outline,
                        size: 30.0,
                        color: AppColor.blackColor,
                      ),
                    ),
                    const SizedBox(height: 22),
                    AppText(
                      text: "Email",
                      textSize: 15.0,
                      color: AppColor.blackColor.withOpacity(0.5),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    AppTextField(
                      height: 57.0,
                      readOnly: true,
                      title: globleController.userInfo.value?.email ?? '',
                      hintStyle: const TextStyle(color: AppColor.blackColor),
                      keyBoardType: TextInputAction.next,
                      textInputType: TextInputType.emailAddress,
                      contentPadding:
                          const EdgeInsets.only(bottom: 8.0, left: 13.0),
                      //margin: const EdgeInsets.only(right: 35.0),
                      borderRadius: BorderRadius.circular(19),
                      containerColor: AppColor.TextColor,
                      prefix: Image.asset(
                        Assets.assetsEmail,
                        scale: 2.2,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    globleController.userInfo.value?.location == null
                        ? const SizedBox.shrink()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: "Location",
                                color: AppColor.blackColor.withOpacity(0.5),
                                textSize: 15.0,
                                style: AppTextStyle.medium,
                              ),
                              const SizedBox(height: 14.0),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 14),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(20)),
                                child: AppText(
                                    text: globleController
                                            .userInfo.value?.location ??
                                        '',
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.w400,
                                    lineHeight: 1.2),
                              ),
                            ],
                          ),
                    // AppTextField(
                    //   maxLines: 5,
                    //   height: 50,
                    //   readOnly: true,
                    //   margin: const EdgeInsets.only(right: 0),
                    //   borderRadius: BorderRadius.circular(20),
                    //   containerColor: AppColor.TextColor,
                    //   title: globleController.userInfo.value?.location ?? '',
                    //   style: const TextStyle(color: AppColor.blackColor),
                    //   hintStyle: const TextStyle(color: AppColor.blackColor),
                    //   //contentPadding: const EdgeInsets.only(top: 8.0,left: 13.0),
                    //   suffix: const Icon(
                    //     Icons.my_location,
                    //     size: 18.0,
                    //     color: AppColor.appcolor,
                    //   ),
                    // ),
                    const SizedBox(height: 12),
                    AppText(
                      text: "Phone Number",
                      textSize: 15.0,
                      color: AppColor.blackColor.withOpacity(0.5),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    AppTextField(
                      height: 50,
                      readOnly: true,
                      borderRadius: BorderRadius.circular(20),
                      containerColor: AppColor.TextColor,
                      textInputType: TextInputType.phone,
                      prefix: Container(
                        margin: const EdgeInsets.only(right: 15),
                        decoration: const BoxDecoration(
                            color: AppColor.appcolor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AppText(
                              text:
                                  "+${globleController.userInfo.value?.countryCode ?? ''}",
                              color: AppColor.white,
                              textSize: 15.0,
                              textAlign: TextAlign.center,
                              style: AppTextStyle.medium,
                            ),
                          ],
                        ),
                      ),
                      title: globleController.userInfo.value?.phone ?? '',
                      hintStyle: const TextStyle(color: AppColor.blackColor),
                      style: const TextStyle(color: AppColor.blackColor),
                      maxLength: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.find<EditProfileController>().initialData();
              Get.toNamed(Routes.editProfileScreen);
            },
            child: CommonButton(
              color: AppColor.appcolor,
              height: 57,
              text: "Edit Profile",
              margin: const EdgeInsets.only(left: 25, right: 25, bottom: 30),
              textStyle: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
