import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/settings_controller.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
  leading: const AppText(
    text: "Account",
    textSize: 17.0,
    color: AppColor.blackColor,
    style: AppTextStyle.regular,
  ),
),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                   const Icon(Icons.person_rounded,color: AppColor.blackColor,size: 50,),
                    const SizedBox(width: 3,),
                    Column(
                      children: [
                        const AppText(
                          text: "John Smith",
                          textSize: 17.0,
                          color: AppColor.blackColor,
                          style: AppTextStyle.regular,
                        ),
                        const Row(
                          children: [
                            Icon(Icons.send,color: AppColor.appcolor,size: 10.0,),
                            AppText(
                              text: "California",
                              textSize: 13.0,
                              color: AppColor.blackColor,
                              style: AppTextStyle.regular,
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 2.0),
                          decoration: BoxDecoration(
                            color: AppColor.appcolor,
                            borderRadius: BorderRadius.circular(7.0)
                          ),
                          child: Row(
                            children: [
                              Image.asset(Assets.assetsGraphIcon,
                              height: 12.0,width: 12.0,
                              ),
                              const AppText(
                                text: "Insights",
                                textSize: 13.0,
                                color: AppColor.white,
                                style: AppTextStyle.regular,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.arrow_forward_ios_outlined,
                        color: AppColor.blackColor,size:15),
                  ],
                )
              ],
            ),
            const SizedBox(height: 31.0,),
            const AppText(
              text: "Settings",
              textSize: 17.0,
              color: AppColor.blackColor,
              style: AppTextStyle.medium,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: 33,width: 33,
                      decoration: const BoxDecoration(
                          color: AppColor.appcolor,
                          shape: BoxShape.circle
                      ),
                      child: const Center(
                        child: Icon(Icons.notifications,
                          color: AppColor.white,size: 20,),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    const AppText(text: "Notifications",
                      textSize: 12,color: AppColor.blackColor,
                      style: AppTextStyle.regular,
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(()=>
                          Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              activeColor: AppColor.appcolor,
                              thumbColor: AppColor.white,
                              trackColor: AppColor.blackColor,
                              value: controller.on.value,
                              onChanged: (val) => controller.toggle(),
                            ),
                          )
                      ),
                    ]
                ),
              ],
            ),
            const SizedBox(height: 17.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 42,width: 42,
                  decoration: const BoxDecoration(
                      color: AppColor.appcolor,
                      shape: BoxShape.circle
                  ),
                  child: const Center(
                    child: Icon(Icons.shopping_cart_sharp,color: AppColor.white,size: 20,),
                  ),
                ),
                const SizedBox(width: 15,),
                InkWell(
                  onTap: (){
                    },
                  child: const AppText(text: "My Products",
                    textSize: 13.0,color: AppColor.blackColor,
                    style: AppTextStyle.regular,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 17.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 42,width: 42,
                  decoration: const BoxDecoration(
                      color: AppColor.appcolor,
                      shape: BoxShape.circle
                  ),
                  child: const Center(
                    child: Icon(Icons.lock,color: AppColor.white,size: 20,),
                  ),
                ),
                const SizedBox(width: 15,),
                InkWell(
                  onTap: (){
                  },
                  child: const AppText(text: "Password",
                    textSize: 13.0,color: AppColor.blackColor,
                    style: AppTextStyle.regular,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 17.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 42,width: 42,
                  decoration: const BoxDecoration(
                      color: AppColor.appcolor,
                      shape: BoxShape.circle
                  ),
                  child: const Center(
                    child: Icon(Icons.payment,color: AppColor.white,size: 20,),
                  ),
                ),
                const SizedBox(width: 15,),
                InkWell(
                  onTap: (){
                  },
                  child: const AppText(text: "Payment",
                    textSize: 13.0,color: AppColor.blackColor,
                    style: AppTextStyle.regular,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 17.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 42,width: 42,
                  decoration: const BoxDecoration(
                      color: AppColor.appcolor,
                      shape: BoxShape.circle
                  ),
                  child: const Center(
                    child: Icon(Icons.location_on,color: AppColor.white,size: 20,),
                  ),
                ),
                const SizedBox(width: 15,),
                InkWell(
                  onTap: (){
                  },
                  child: const AppText(text: "Address",
                    textSize: 13.0,color: AppColor.blackColor,
                    style: AppTextStyle.regular,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 17.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 42,width: 42,
                  decoration: const BoxDecoration(
                      color: AppColor.appcolor,
                      shape: BoxShape.circle
                  ),
                  child: const Center(
                    child: Icon(Icons.attach_money,color: AppColor.white,size: 20,),
                  ),
                ),
                const SizedBox(width: 15,),
                InkWell(
                  onTap: (){
                  },
                  child: const AppText(text: "My Subscription",
                    textSize: 13.0,color: AppColor.blackColor,
                    style: AppTextStyle.regular,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 17.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 42,width: 42,
                  decoration: const BoxDecoration(
                      color: AppColor.appcolor,
                      shape: BoxShape.circle
                  ),
                  child: const Center(
                    child: Icon(Icons.privacy_tip_rounded,color: AppColor.white,size: 20,),
                  ),
                ),
                const SizedBox(width: 15,),
                InkWell(
                  onTap: (){
                  },
                  child: const AppText(text: "Privacy Policy",
                    textSize: 13.0,color: AppColor.blackColor,
                    style: AppTextStyle.regular,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 17.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 42,width: 42,
                  decoration: const BoxDecoration(
                      color: AppColor.appcolor,
                      shape: BoxShape.circle
                  ),
                  child: const Center(
                    child: Icon(Icons.headphones,color: AppColor.white,size: 20,),
                  ),
                ),
                const SizedBox(width: 15,),
                InkWell(
                  onTap: (){
                  },
                  child: const AppText(text: "Help Center",
                    textSize: 13.0,color: AppColor.blackColor,
                    style: AppTextStyle.regular,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 17.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 42,width: 42,
                  decoration: const BoxDecoration(
                      color: AppColor.appcolor,
                      shape: BoxShape.circle
                  ),
                  child: const Center(
                    child: Icon(Icons.help,color: AppColor.white,size: 20,),
                  ),
                ),
                const SizedBox(width: 15,),
                InkWell(
                  onTap: (){
                  },
                  child: const AppText(text: "About Us",
                    textSize: 13.0,color: AppColor.blackColor,
                    style: AppTextStyle.regular,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 17.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 42,width: 42,
                  decoration: const BoxDecoration(
                      color: AppColor.appcolor,
                      shape: BoxShape.circle
                  ),
                  child: const Center(
                    child: Icon(Icons.login_outlined,color: Colors.red,size: 20,),
                  ),
                ),
                const SizedBox(width: 15,),
                InkWell(
                  onTap: (){
                  },
                  child: const AppText(text: "Logout",
                    textSize: 13.0,color: AppColor.blackColor,
                    style: AppTextStyle.regular,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
