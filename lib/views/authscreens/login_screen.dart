import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/app_textfield.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';

import '../../utills/colors_file.dart';
import '../../utills/commontextfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
              top: 30, right: 20, left: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: AppText(
                    text: "Trouble logging In? ",
                    color: Colors.black,
                    underline: true,
                    underlineColor: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: AppText(
                    text: "Welcome Back !",
                    color: Colors.black,
                    fontFamily: "poppins",
                    fontWeight: FontWeight.w500,
                    textSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const AppText(
                  text: "Login your details",
                  color: Colors.black,
                  fontFamily: "poppins",
                  fontWeight: FontWeight.w400,
                  textSize: 18,
                ),
                const SizedBox(
                  height: 40,
                ),
                const AppText(
                  text: "Phone Number/ Email",
                  color: Colors.black,
                  fontFamily: "poppins",
                  fontWeight: FontWeight.w400,
                  textSize: 15,
                ),
                const SizedBox(
                  height: 10,
                ),
               AppTextField(prefix: const Icon(Icons.mail_outline_outlined),
                  title: "jennySmith@gmail.com",
                ),
                const SizedBox(
                  height: 20,
                ),
                const AppText(
                  text: "Password",
                  color: Colors.black,
                  fontFamily: "poppins",
                  fontWeight: FontWeight.w400,
                  textSize: 18,
                ),
                const SizedBox(
                  height: 10,
                ),
                AppTextField(
                  title: "jennySmith@gmail.com",
                  maxLength: 8,
                  prefix: const Icon(Icons.lock),
                  suffix: const Icon(
                    Icons.remove_red_eye,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  children: [
                    Icon(Icons.toggle_off_outlined),
                    AppText(
                      text: "Remember me",
                      color: Colors.black,
                      fontFamily: "poppins",
                      fontWeight: FontWeight.w400,
                      textSize: 15,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
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
                            text: "Sign In",
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
                  height: 40,
                ),
                const Center(
                  child: AppText(
                    textSize: 15,
                    text: "Sign in with",
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: const Color(0xffF2F2F2),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 5),
                                  blurRadius: 10,
                                  color: Colors.grey.shade500),
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        // child: Image.asset(
                        //   Assets.assetsGoogleImage,
                        //   scale: 5,
                        // )
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: const Color(0xffF2F2F2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 5),
                                  blurRadius: 10,
                                  color: Colors.grey.shade500),
                            ]),
                        // child: Image.asset(
                        //   Assets.assetsFacebookImage,
                        //   scale: 5,
                        // )
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: const Color(0xffF2F2F2),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(0, 5),
                                  blurRadius: 10,
                                  color: Colors.grey.shade500),
                            ]),
                        // child: Image.asset(
                        //   Assets.assetsAppleImage,
                        //   scale: 5,
                        // )
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppText(
                        text: "Don't have account?",
                        fontFamily: "Poppins",
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.signupScreen);
                          },
                          child: const AppText(
                            text: "Sign Up",
                            fontWeight: FontWeight.w800,
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
        ),
      ),
    );
  }
}
