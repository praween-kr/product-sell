import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_widget/app_text.dart';
import '../../../common_widget/appbar.dart';
import '../../../common_widget/color_constant.dart';
import '../../../common_widget/common_button.dart';
import '../../../generated/assets.dart';
import '../../../routes/routes.dart';
import '../../../utills/colors_file.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      resizeToAvoidBottomInset: false,
      appBar: CommonAppbarWidget(
        heading: "Message",
        textStyle: const TextStyle(
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 30, 24, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: "First Name",
              textSize: 15.0,
              color: AppColor.blackColor.withOpacity(0.5),
            ),
            const SizedBox(height: 12,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              decoration: BoxDecoration(
                color: AppColor.TextColor,
                borderRadius: BorderRadius.circular(19)
              ),
              child:const Row(
                children: [
                Icon(Icons.person_outline,size: 12,color: AppColor.blackColor,),
                  SizedBox(width: 15,),
                  AppText(
                    text: "Jenny",
                    textSize: 15.0,
                    color: AppColor.blackColor,
                  ),
              ],),
            ),
            const SizedBox(height: 17,),
            AppText(
              text: "Last Name",
              textSize: 15.0,
              color: AppColor.blackColor.withOpacity(0.5),
            ),
            const SizedBox(height: 7,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              decoration: BoxDecoration(
                  color: AppColor.TextColor,
                  borderRadius: BorderRadius.circular(19)
              ),
              child:const Row(
                children: [
                  Icon(Icons.person_outline,size: 12,color: AppColor.blackColor,),
                  SizedBox(width: 15,),
                  AppText(
                    text: "Smith",
                    textSize: 15.0,
                    color: AppColor.blackColor,
                  ),
                ],),
            ),
            const SizedBox(height: 22,),
            AppText(
              text: "Email",
              textSize: 15.0,
              color: AppColor.blackColor.withOpacity(0.5),
            ),
            const SizedBox(height: 12,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
              decoration: BoxDecoration(
                  color: AppColor.TextColor,
                  borderRadius: BorderRadius.circular(19)
              ),
              child: Row(
                children: [
                  Image.asset(
                    Assets.assetsEmail,
                    height: 12,
                    width: 12,
                    fit: BoxFit.contain,
                  ),
                   const SizedBox(width: 15,),
                  const AppText(
                    text: "Jennysmith@gmail.com",
                    textSize: 15.0,
                    color: AppColor.blackColor,
                  ),
                ],),
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
                        height: 57,width: 73,
                        decoration: BoxDecoration(
                            color: AppColor.appcolor,
                            borderRadius: BorderRadius.circular(19)
                        ),
                        child:  const CountryCodePicker(
                          initialSelection: 'in',
                          showDropDownButton: true,
                          textStyle: TextStyle(
                              color: AppColor.white,fontSize: 22,
                              fontWeight: FontWeight.w300),
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
                  text: "Edit Profile",
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
