import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/settings/edit_profile_controller.dart';
import 'package:oninto_flutter/generated/assets.dart';

import '../../../../common_widget/app_text.dart';
import '../../../../common_widget/app_textfield.dart';
import '../../../../common_widget/appbar.dart';
import '../../../../common_widget/color_constant.dart';
import '../../../../common_widget/common_button.dart';
import '../../../../utills/colors_file.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  EditProfileController editProfileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      resizeToAvoidBottomInset: false,
      appBar: CommonAppbarWidget(
        heading: "Edit Profile",
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
              padding:
                  const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
              child: Column(
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
                    controller: editProfileController.firstName,
                    height: 57.0,
                    title: "John",
                    hintStyle: const TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    style: const TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    keyBoardType: TextInputAction.next,
                    textInputType: TextInputType.name,
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
                    controller: editProfileController.lastName,
                    height: 57.0,
                    title: "Smith",
                    hintStyle: const TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    style: const TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    keyBoardType: TextInputAction.next,
                    textInputType: TextInputType.name,
                    contentPadding: const EdgeInsets.only(top: 8.0, left: 13.0),
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
                    height: 22,
                  ),
                  AppText(
                    text: "Email",
                    textSize: 15.0,
                    color: AppColor.blackColor.withOpacity(0.5),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AppTextField(
                    controller: editProfileController.email,
                    height: 57.0,
                    title: "Jennysmith@gmail.com",
                    hintStyle: const TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    style: const TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    keyBoardType: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
                    contentPadding: const EdgeInsets.only(top: 8.0, left: 13.0),
                    borderRadius: BorderRadius.circular(19),
                    containerColor: AppColor.TextColor,
                    prefix: Image.asset(
                      Assets.assetsEmail,
                      scale: 2.2,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  AppText(
                    text: "Location",
                    color: AppColor.blackColor.withOpacity(0.5),
                    textSize: 15.0,
                    style: AppTextStyle.medium,
                  ),
                  const SizedBox(height: 14.0),
                  AppTextField(
                    controller: editProfileController.location,
                    height: 50,
                    margin: const EdgeInsets.only(right: 0),
                    borderRadius: BorderRadius.circular(20),
                    containerColor: AppColor.TextColor,
                    title: "Add",
                    hintStyle: const TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    style: const TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    suffix: const Icon(
                      Icons.my_location,
                      size: 18.0,
                      color: AppColor.appcolor,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  AppText(
                    text: "Phone Number",
                    textSize: 15.0,
                    color: AppColor.blackColor.withOpacity(0.5),
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    controller: editProfileController.phone,
                    height: 50,
                    margin: const EdgeInsets.only(right: 0),
                    borderRadius: BorderRadius.circular(20),
                    containerColor: AppColor.TextColor,
                    textInputType: TextInputType.phone,
                    prefix: Container(
                      margin: const EdgeInsets.only(right: 15),
                      decoration: const BoxDecoration(
                          color: AppColor.appcolor,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CountryCodePicker(
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 15),
                              enabled: true,
                              showFlag: false,
                              alignLeft: false),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                    title: "5555-555-55",
                    hintStyle: const TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    style: const TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    maxLength: 8,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              //Get.toNamed(Routes.editProfileScreen);
              await editProfileController.updateProfile();
            },
            child: CommonButton(
              color: AppColor.appcolor,
              height: 57,
              text: "Update",
              margin: const EdgeInsets.only(left: 25, right: 25, bottom: 30),
              textStyle: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
