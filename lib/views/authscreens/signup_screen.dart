import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/app_textfield.dart';

import '../../common_widget/app_text.dart';
import '../../common_widget/appbar.dart';
import '../../routes/routes.dart';
import '../../utills/colors_file.dart';


class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final  RxBool tick = true.obs;
  final  RxBool pass = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbarWidget.commonAppBar(
          title: "",
          onTap: () {
            Get.back();
          },
          context: context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 30,left: 15),
                child:
                 Align(
                  alignment: Alignment.topLeft,
                  child: AppText(
                    text: "Welcome Back !",
                    color: Colors.black,
                    fontFamily: "poppins",
                    fontWeight: FontWeight.w500,
                    textSize: 25,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20,top:10),
              child: Align(
                alignment: Alignment.topLeft,
                child: AppText(
                  text: "Signup your details",
                  color: Colors.black,
                  fontFamily: "poppins",
                  fontWeight: FontWeight.w500,
                  textSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 20,top:10),
              child: Align(
                alignment: Alignment.topLeft,
                child: AppText(
                  text: "First Name",
                  color: Colors.grey.shade700,
                  fontFamily: "poppins",
                  fontWeight: FontWeight.w500,
                  textSize: 15,
                ),
              ),
            ),
            AppTextField(
              title: "Jenny",
              prefix: const Icon(Icons.person_rounded),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,top:10),
              child: Align(
                alignment: Alignment.topLeft,
                child: AppText(
                  text: "Last Name",
                  color: Colors.grey.shade700,
                  fontFamily: "poppins",
                  fontWeight: FontWeight.w500,
                  textSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            AppTextField(title: "Smith",
              prefix: const Icon(Icons.person_rounded),),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 20,),
              child: Align(
                alignment: Alignment.topLeft,
                child: AppText(
                  text: "Email",
                  color: Colors.grey.shade700,
                  fontFamily: "poppins",
                  fontWeight: FontWeight.w500,
                  textSize: 15,
                ),
              ),
            ),
            AppTextField(prefix: const Icon(Icons.mail_outline_outlined),
              title: "jennySmith@gmail.com",maxLength: 8,  ),
            Padding(
              padding: const EdgeInsets.only(left: 20,top:10),
              child: Align(
                alignment: Alignment.topLeft,
                child: AppText(
                  text: "Password",
                  color: Colors.grey.shade700,
                  fontFamily: "poppins",
                  fontWeight: FontWeight.w500,
                  textSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 15,),
          child: AppTextField(
            prefix: Container(
            decoration: const BoxDecoration(
              color: themeColor,
              borderRadius: BorderRadius.all(Radius.circular(15))
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CountryCodePicker(
                  padding: EdgeInsets.zero,
                  textStyle: TextStyle(color: Colors.white,fontSize: 15),
                  enabled: true,
                  showFlag: false,
                  alignLeft: false,
                ),
                Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,size:25,
                ),
                SizedBox(width: 2,)
              ],
            ),
          ),
                title: "jennySmith@gmail.com",
            contentPadding: const EdgeInsets.only(left: 20),
                maxLength: 8,

              ),
        ),
            const SizedBox(height: 10,),
            AppTextField(inputFormatters:
            [FilteringTextInputFormatter.digitsOnly,
            ],textInputType: TextInputType.text,
              title: "12345678",
              maxLength: 8,
              prefix: const Icon(Icons.lock,color: Colors.grey,),
              suffix: const Icon(
                Icons.remove_red_eye,color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,top:10),
              child: Align(
                alignment: Alignment.topLeft,
                child: AppText(
                  text: "Confirm Password",
                  color: Colors.grey.shade700,
                  fontFamily: "poppins",
                  fontWeight: FontWeight.w500,
                  textSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 20,),
            AppTextField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              title: "12345678",
              maxLength: 8,
              prefix: const Icon(Icons.lock,color: Colors.grey,),
              suffix: const Icon(
                Icons.remove_red_eye,color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Obx(()=> Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Align(
                alignment: AlignmentDirectional.center,
                child:
                Row(
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
                      ),child: RichText(text: const TextSpan(
                      text: "By creating an"
                          " account you have to agree\n with "
                          "our ",style: TextStyle(color: themeColor),children: [
                            TextSpan( text: "Terms & Conditions. "
                        ,style: TextStyle(color: Colors.black,fontSize: 12 ),
                    ),
                    ]
                    ),
                    ),)
                  ],
                ),
              ),
            ),
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.bottomScreen);
              },
              child: Center(
                child: Container(
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
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(bottom: 20,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AppText(textSize: 12,
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
                        text: "SIGN IN",textSize: 12,
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
      ),
    );
  }
}