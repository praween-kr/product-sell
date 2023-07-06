import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/routes/routes.dart';
import '../../../../common_widget/app_text.dart';
import '../../../../common_widget/app_textfield.dart';
import '../../../../common_widget/appbar.dart';
import '../../../../common_widget/color_constant.dart';
import '../../../../common_widget/common_button.dart';
import '../../../../utills/colors_file.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CommonAppbarWidget(
        heading: "Edit Profile",
        textStyle: const TextStyle(
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: "First Name",
              textSize: 15.0,
              color: AppColor.blackColor.withOpacity(0.5),
            ),
            const SizedBox(height: 12,),
            AppTextField(
              height: 57.0,
              title: "John",
              hintStyle: const TextStyle(
                  color: AppColor.blackColor
              ),
              style: const TextStyle(
                color: AppColor.blackColor
              ),
              keyBoardtype: TextInputAction.next,
              textInputType: TextInputType.name,
              contentPadding: const EdgeInsets.only(top: 8.0,left: 13.0),
              //margin: const EdgeInsets.only(right: 35.0),
              borderRadius: BorderRadius.circular(19),
              containerColor: AppColor.TextColor,
              prefix:  const Icon(Icons.person_outline,size: 30.0,
                color: AppColor.blackColor,
              ),
            ),
            const SizedBox(height: 17,),
            AppText(
              text: "Last Name",
              textSize: 15.0,
              color: AppColor.blackColor.withOpacity(0.5),
            ),
            const SizedBox(height: 7,),
            AppTextField(
              height: 57.0,
              title: "Smith",
              hintStyle: const TextStyle(
                  color: AppColor.blackColor
              ),
              keyBoardtype: TextInputAction.next,
              textInputType: TextInputType.name,
              contentPadding: const EdgeInsets.only(top: 8.0,left: 13.0),
              //margin: const EdgeInsets.only(right: 35.0),
              borderRadius: BorderRadius.circular(19),
              containerColor: AppColor.TextColor,
              prefix:  const Icon(Icons.person_outline,size: 30.0,
                color: AppColor.blackColor,
              ),
            ),
            const SizedBox(height: 22,),
            AppText(
              text: "Email",
              textSize: 15.0,
              color: AppColor.blackColor.withOpacity(0.5),
            ),
            const SizedBox(height: 12,),
            AppTextField(
              height: 57.0,
             title: "Jennysmith@gmail.com",
              hintStyle: const TextStyle(
                  color: AppColor.blackColor
              ),
             keyBoardtype: TextInputAction.next,
              textInputType: TextInputType.emailAddress,
              contentPadding: const EdgeInsets.only(top: 8.0,left: 13.0),
              //margin: const EdgeInsets.only(right: 35.0),
              borderRadius: BorderRadius.circular(19),
              containerColor: AppColor.TextColor,
              prefix:   Image.asset(
                Assets.assetsEmail,
                scale: 2.2,
              ),
            ),
            const SizedBox(height: 18,),
            AppText(
              text: "Phone Number",
              textSize: 15.0,
              color: AppColor.blackColor.withOpacity(0.5),
            ),
            const SizedBox(height: 12,),
            Row(
              children: [
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 100,vertical: 20),
                      decoration: BoxDecoration(
                          color: AppColor.TextColor,
                          borderRadius: BorderRadius.circular(19)
                      ),
                      child: const AppText(
                        text: "5555-555-55",
                        textSize: 15.0,
                        color: AppColor.blackColor,
                      ),
                    ),
                    Container(
                      height: 57,width: 100,
                      decoration: BoxDecoration(
                          color: AppColor.appcolor,
                          borderRadius: BorderRadius.circular(19)
                      ),
                      child:  const CountryCodePicker(
                        initialSelection: 'in',
                        //padding: EdgeInsets.all(15.0),
                        showDropDownButton: true,
                        textStyle: TextStyle(
                            color: AppColor.white,fontSize: 15,
                            fontWeight: FontWeight.w500),
                        backgroundColor: AppColor.white,
                        showFlagDialog: false,
                        showFlag: false,
                        showCountryOnly: true,
                      ),
                    ),
      ]
                ),

              ],
            ),
            const SizedBox(height: 30,),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.editProfileScreen);
              },
              child: Expanded(
                child: CommonButton(
                  color: AppColor.appcolor,
                  height: 57,
                  text: "Update",
                  textStyle: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
