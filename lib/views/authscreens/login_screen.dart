import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home_controller.dart';
import 'package:oninto_flutter/common_widget/app_textfield.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';

import '../../utills/colors_file.dart';
import '../../utills/commontextfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final controller = Get.put(Homecontroller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
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
                  height: 120,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 0, left: 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: AppText(
                      text: "Welcome Back !",
                      color: Colors.black,
                      fontFamily: "poppins",
                      fontWeight: FontWeight.w500,
                      textSize: 22,
                    ),
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
                  textSize: 15,
                ),
                const SizedBox(
                  height: 40,
                ),
                const AppText(
                  text: "Phone Number/ Email",
                  color: Colors.black,
                  fontFamily: "poppins",
                  fontWeight: FontWeight.w400,
                  textSize: 18,
                ),
                const SizedBox(
                  height: 10,
                ),
                CommonTextfield(
                  hintText: "jennySmith@gmail.com",
                ),
                const SizedBox(
                  height: 20,
                ),
                const AppText(
                  text: "Password",
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  textSize: 18,
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => AppTextField(
                    title: "*******",
                    isObscure: controller.HomePass.value,
                    maxLines: 1,
                    style: TextStyle(color: Colors.black),
                    prefix: Icon(Icons.lock_open),
                    suffix: GestureDetector(
                      onTap: () {
                        controller.HomePass.value = !controller.HomePass.value;
                      },
                      child: controller.HomePass.value
                          ? Icon(Icons.remove_red_eye_outlined)
                          : Icon(Icons.visibility_off_outlined),
                    ),
                    containerColor: Color(0xffF7F7F7),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(
                  () => Row(
                    children: [
                      Transform.scale(
                          scaleY: 0.5,
                          scaleX: 1.1,
                          child: CupertinoSwitch(
                            value: controller.Switch.value,
                            onChanged: (value) {
                              controller.Switch.value =
                                  !controller.Switch.value;
                            },
                            activeColor: Colors.red,
                            trackColor: Colors.yellowAccent,
                          )),
                      AppText(
                        text: "Remember me",
                        color: Colors.black,
                        fontFamily: "poppins",
                        fontWeight: FontWeight.w400,
                        textSize: 18,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.bottomScreen);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10, left: 25, right: 25),
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.height * 0.35,
                    decoration: const BoxDecoration(
                      color: themeColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          color: Color(0xff29000000),
                          spreadRadius: 2,
                          blurRadius: 4,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
