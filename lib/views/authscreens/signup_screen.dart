import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/app_textfield.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import '../../common_widget/app_text.dart';
import '../../routes/routes.dart';
import '../../utills/colors_file.dart';
import '../settingScreen/cms_screen/cms_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final RxBool tick = true.obs;
  final RxBool pass = true.obs;
  int type = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.zero,
              child: CommonAppbarWidget(
                leading: GestureDetector(
                  onTap: () {
                        Get.back();
                      },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2,vertical: 5),
                    padding: const EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                        color: AppColor.appcolor,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Icon(Icons.arrow_back_ios),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    text: "Welcome Back !",
                    color: Colors.black,
                    fontFamily: "poppins",
                    fontWeight: FontWeight.w500,
                    textSize: 30,
                  ),
                  const SizedBox(height: 7,),
                  const AppText(
                    text: "Signup your details",
                    color: Color(0x80000000),
                    fontFamily: "poppins",
                    fontWeight: FontWeight.w400,
                    textSize: 15,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const AppText(
                    text: "First Name",
                    color: Color(0x80000000),
                    fontWeight: FontWeight.w400,
                    textSize: 14,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AppTextField(
                    height: 50,
                    borderRadius: BorderRadius.circular(15),
                    margin: const EdgeInsets.only(right: 20),
                    title: "jennySmith@gmail.com",
                    prefix: const Icon(Icons.person_outline),
                    containerColor: AppColor.TextColor,
                    contentPadding: const EdgeInsets.only(
                      top: 30,
                      left: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const AppText(
                    text: "Last Name",
                    color: Color(0x80000000),
                    fontWeight: FontWeight.w400,
                    textSize: 14,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AppTextField(
                    height: 50,
                    borderRadius: BorderRadius.circular(19),
                    margin: const EdgeInsets.only(right: 20),
                    title: "jennySmith@gmail.com",
                    prefix: const Icon(Icons.person_outline),
                    containerColor: AppColor.TextColor,
                    contentPadding: const EdgeInsets.only(
                      top: 30,
                      left: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const AppText(
                    text: "Email",
                    color: Color(0x80000000),
                    fontWeight: FontWeight.w400,
                    textSize: 14,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AppTextField(
                    height: 50,
                    borderRadius: BorderRadius.circular(19),
                    margin: const EdgeInsets.only(right: 20),
                    title: "jennySmith@gmail.com",
                    prefix: const Icon(Icons.person_outline),
                    containerColor: AppColor.TextColor,
                    contentPadding: const EdgeInsets.only(
                      top: 30,
                      left: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const AppText(
                    text: "Phone Number",
                    color: Color(0x80000000),
                    fontWeight: FontWeight.w400,
                    textSize: 14,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AppTextField(
                    height: 50,
                    margin: const EdgeInsets.only(right: 20),
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
                            padding: EdgeInsets.zero,
                            textStyle:
                            TextStyle(color: Colors.white, fontSize: 15),
                            enabled: true,
                            showFlag: false,
                            alignLeft: false,
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                    title: "5555-555-55",
                    style: const TextStyle(
                        color: AppColor.blackColor
                    ),
                    contentPadding: const EdgeInsets.only(right: 2.0),
                    maxLength: 8,
                  ),
                  const SizedBox(height: 18,),
                  const AppText(
                    text: "Location",
                    color: Color(0x80000000),
                    fontWeight: FontWeight.w400,
                    textSize: 14,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  AppTextField(
                    height: 50,
                    margin: const EdgeInsets.only(right: 20),
                    borderRadius: BorderRadius.circular(20),
                    containerColor: AppColor.TextColor,
                    title: "Add",
                    //contentPadding: const EdgeInsets.only(top: 8.0,left: 13.0),
                    suffix: const Icon(
                      Icons.my_location,
                      size: 18.0,
                      color: AppColor.appcolor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            tick.value = !tick.value;
                          },
                          child: tick.value
                              ? const Icon(
                                  Icons.check_box_outline_blank_outlined)
                              : const Icon(Icons.check_box),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 5,
                          ),
                          child: RichText(
                            text:  TextSpan(
                                text: "By creating an"
                                    " account you have to agree\n with "
                                    "our ",
                                style: TextStyle(color: blackColor),
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()..onTap = () => {
                                      Get.to( CmsScreen(type: 1))
                                    },
                                    text: "Privacy Policy",
                                    style: TextStyle(
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                        fontSize: 12),
                                  ),
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.verificationScreen);
                    },
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.height * 0.40,
                        decoration: const BoxDecoration(
                          color: themeColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 2),
                              color: themeColor,
                              spreadRadius: 2,
                              blurRadius: 0,
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              text: "Sign up",
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppText(
                          textSize: 12,
                          color: Colors.black,
                          text: " Already Have an account?",
                          fontFamily: "Poppins",
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                            Get.toNamed(Routes.loginScreen);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: AppText(
                              text: "Login",
                              textSize: 12,
                              fontWeight: FontWeight.w600,
                              underlineColor: themeColor,
                              underline: true,
                              color: themeColor,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
