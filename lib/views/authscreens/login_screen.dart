import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';

import '../../utills/colors_file.dart';
import '../../utills/commontextfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: AlignmentDirectional.topEnd,
                child: AppText(text: "Trouble logging In? ",color: Colors.black,underline: true,
                underlineColor: Colors.black,),
              ),const SizedBox(height: 120,),
              const Padding(
                padding: EdgeInsets.only(top: 0, left: 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child:
                  AppText(
                    text: "Welcome Back !",
                    color: Colors.black,
                    fontFamily: "poppins",
                    fontWeight: FontWeight.w500,
                    textSize: 35,
                  ),
                ),
              ),const SizedBox(height: 20,),
              const AppText(
                text: "Login your details",
                color: Colors.black,
                fontFamily: "poppins",
                fontWeight: FontWeight.w400,
                textSize: 18,
              ),
              const SizedBox(height: 40,),
              const AppText(
                text: "Phone Number/ Email",
                color: Colors.black,
                fontFamily: "poppins",
                fontWeight: FontWeight.w400,
                textSize: 18,
              ),
              const SizedBox(height: 10,),
              CommonTextfield(hintText: "jennySmith@gmail.com",),
              const SizedBox(height: 20,),
              const AppText(
                text: "Password",
                color: Colors.black,
                fontFamily: "poppins",
                fontWeight: FontWeight.w400,
                textSize: 18,
              ),
              const SizedBox(height: 10,),
              CommonTextfield2(hintText: "jennySmith@gmail.com",),
              const SizedBox(height: 20,),
              const Row(
                children: [
                  Icon(Icons.alarm_on),
                  AppText(
                    text: "Remember me",
                    color: Colors.black,
                    fontFamily: "poppins",
                    fontWeight: FontWeight.w400,
                    textSize: 18,
                  ),
                ],
              ), const SizedBox(height: 50,),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes. bottomScreen);
                },
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    // margin: const EdgeInsets.only(top: 70, bottom: 20),
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.height * 0.35,
                    decoration: const BoxDecoration(
                      color: themeColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 2),
                          color: themeColor,
                          spreadRadius:  2,
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
                        ), SizedBox(width: 10,),
                        Icon(Icons.arrow_forward,color: Colors.white,)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
