import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oninto_flutter/common_controller/settings/edit_profile_controller.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/views/search_google_address.dart';

import '../../../../utils/app_text_field.dart';
import '../../../../utils/appbar.dart';
import '../../../../utils/color_constant.dart';
import '../../../../utils/common_button.dart';
import '../../../../utils/image_view.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final EditProfileController editProfileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      // resizeToAvoidBottomInset: false,
      appBar: const CommonAppbarWidget(
        heading: "Edit Profile",
        textStyle: TextStyle(
            fontSize: 20,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Obx(
                      () => AppImage.profile(
                        context,
                        viewOnly: false,
                        isNetwork:
                            editProfileController.pickedProfileImage.value ==
                                '',
                        onChanged: (String? value) {
                          editProfileController.pickedProfileImage.value =
                              value ?? '';
                        },
                        url: editProfileController.pickedProfileImage.value ==
                                ''
                            ? "${ImageBaseUrls.profile}${editProfileController.profileImageNetwork.value}"
                            : editProfileController.pickedProfileImage.value,
                      ),
                    ),
                  ),
                  AppText(
                    text: "First Name",
                    textSize: 15.0,
                    color: AppColor.blackColor.withOpacity(0.5),
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    controller: editProfileController.firstName,
                    height: 57.0,
                    title: "First name",
                    hintStyle: const TextStyle(
                        color: AppColor.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    style: const TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    keyBoardType: TextInputAction.next,
                    textInputType: TextInputType.name,
                    borderRadius: BorderRadius.circular(19),
                    containerColor: AppColor.textColor,
                    prefix: const Icon(
                      Icons.person_outline,
                      size: 30.0,
                      color: AppColor.blackColor,
                    ),
                  ),
                  const SizedBox(height: 17),
                  AppText(
                    text: "Last Name",
                    textSize: 15.0,
                    color: AppColor.blackColor.withOpacity(0.5),
                  ),
                  const SizedBox(height: 7),
                  AppTextField(
                    controller: editProfileController.lastName,
                    height: 57.0,
                    title: "Last name",
                    hintStyle: const TextStyle(
                        color: AppColor.grey,
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
                    containerColor: AppColor.textColor,
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
                  const SizedBox(height: 12),
                  AppTextField(
                    controller: editProfileController.email,
                    height: 57.0,
                    readOnly: true,
                    title: "example@gmail.com",
                    hintStyle: const TextStyle(
                        color: AppColor.grey,
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
                    containerColor: AppColor.textColor,
                    prefix: Image.asset(
                      Assets.assetsEmail,
                      scale: 2.2,
                    ),
                  ),
                  const SizedBox(height: 18),
                  AppText(
                    text: "Location",
                    color: AppColor.blackColor.withOpacity(0.5),
                    textSize: 15.0,
                    style: AppTextStyle.medium,
                  ),
                  const SizedBox(height: 14.0),
                  AppTextField(
                    onClick: () =>
                        Get.to(() => SearchGoogleAddress(onChanged: (location) {
                              editProfileController.location.text =
                                  location.address ?? '';
                              editProfileController.cordinates.value = LatLng(
                                  location.cordinates?.location?.lat ?? 0.0,
                                  location.cordinates?.location?.lng ?? 0.0);
                            })),
                    readOnly: true,
                    controller: editProfileController.location,
                    height: 50,
                    margin: const EdgeInsets.only(right: 0),
                    borderRadius: BorderRadius.circular(20),
                    containerColor: AppColor.textColor,
                    title: "Location",
                    hintStyle: const TextStyle(
                        color: AppColor.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    style: const TextStyle(
                        color: AppColor.blackColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    suffix: const Icon(
                      Icons.my_location,
                      size: 18.0,
                      color: AppColor.appColor,
                    ),
                  ),
                  const SizedBox(height: 18),
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
                      containerColor: AppColor.textColor,
                      textInputType: TextInputType.phone,
                      prefix: Container(
                        margin: const EdgeInsets.only(right: 15),
                        decoration: const BoxDecoration(
                            color: AppColor.appColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Obx(
                                  () => Text(
                                    "+${editProfileController.countryCode.value}",
                                    style: const TextStyle(
                                        color: AppColor.white, fontSize: 15),
                                  ),
                                ),
                                CountryCodePicker(
                                  padding: EdgeInsets.zero,
                                  textStyle: const TextStyle(
                                      color: Colors.transparent, fontSize: 15),
                                  enabled: true,
                                  showFlag: false,
                                  onChanged: (CountryCode country) {
                                    if (country.dialCode != null) {
                                      editProfileController.countryCode.value =
                                          country.dialCode!.split('+').last;
                                    }
                                  },
                                ),
                              ],
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                              size: 25,
                            ),
                          ],
                        ),
                      ),
                      title: "Phone number",
                      hintStyle: const TextStyle(
                          color: AppColor.grey,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      style: const TextStyle(
                          color: AppColor.blackColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      maxLength: 12),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.08),
            GestureDetector(
              onTap: () async {
                await editProfileController.updateProfile();
              },
              child: const CommonButton(
                color: AppColor.appColor,
                height: 57,
                text: "Update",
                margin: EdgeInsets.only(left: 25, right: 25, bottom: 30),
                textStyle: TextStyle(color: Colors.white, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
