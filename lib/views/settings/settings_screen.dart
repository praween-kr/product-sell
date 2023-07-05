import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/views/settings/settings_controller.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';

class SettingScreen extends StatelessWidget {
   SettingScreen({super.key});
  final controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const AppText(text: "Account",
        style: AppTextStyle.title,
          color: AppColor.blackColor,
          textSize: 20.0,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 35.0,right: 35.0,bottom: 85.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(Assets.assetsPersonIcon,scale: 1.0,),
                      const SizedBox(width: 3,),
                      Column(

                        children: [
                          const AppText(
                            text: "John Smith",
                            textSize: 15.0,
                            color: AppColor.blackColor,
                            style: AppTextStyle.medium,
                          ),
                          const SizedBox(height: 3.0,),
                           Row(
                             children: [
                             Image.asset(Assets.assetsSendIcon,scale: 1.0,),
                               const SizedBox(width: 3.0,),
                              AppText(
                                text: "California",
                                textSize: 13.0,
                                color: AppColor.blackColor.withOpacity(0.3),
                                style: AppTextStyle.regular,
                              ),
                            ],
                          ),
                          const SizedBox(height: 4.0,),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
                            decoration: BoxDecoration(
                              color: AppColor.appcolor,
                              borderRadius: BorderRadius.circular(7.0)
                            ),
                            child: Row(
                              children: [
                                Image.asset(Assets.assetsGraphIcon,
                                height: 12.0,width: 12.0,
                                ),
                                const SizedBox(width: 2.0,),
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
                   Row(
                     children: [
                      Icon(Icons.arrow_forward_ios_outlined,
                          color: AppColor.blackColor.withOpacity(0.3),
                          size:15),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 31.0,),
              const AppText(
                text: "Settings",
                textSize: 17.0,
                color: AppColor.blackColor,
                style: AppTextStyle.title,
              ),
              const SizedBox(height: 18.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                        decoration: const BoxDecoration(
                            color: AppColor.appcolor,
                            shape: BoxShape.circle
                        ),
                        child: const Center(
                          child: Icon(Icons.notifications,
                            color: AppColor.white,size: 25,),
                        ),
                      ),
                      const SizedBox(width: 17.0,),
                      const AppText(text: "Notifications",
                        textSize: 13.0,color: AppColor.blackColor,
                        style: AppTextStyle.regular,
                      ),
                    ],
                  ),
                  Row(
                      children: [
                        Obx(()=>
                            Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                activeColor: AppColor.appcolor,
                                thumbColor: AppColor.white,
                                trackColor: Colors.red,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                    decoration: const BoxDecoration(
                        color: AppColor.appcolor,
                        shape: BoxShape.circle
                    ),
                    child: const Center(
                      child: Icon(Icons.shopping_cart_rounded,color: AppColor.white,
                        size: 25,),
                    ),
                  ),
                  const SizedBox(width: 17.0,),
                  InkWell(
                    onTap: (){
                      Get.toNamed(Routes.productScreen);
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                    decoration: const BoxDecoration(
                        color: AppColor.appcolor,
                        shape: BoxShape.circle
                    ),
                    child: const Center(
                      child: Icon(Icons.lock,color: AppColor.white,size: 25,),
                    ),
                  ),
                  const SizedBox(width: 15,),
                  InkWell(
                    onTap: (){
                      Get.toNamed(Routes.passwordScreen);
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                    decoration: const BoxDecoration(
                        color: AppColor.appcolor,
                        shape: BoxShape.circle
                    ),
                    child: const Center(
                      child: Icon(Icons.payment,color: AppColor.white,size: 25,),
                    ),
                  ),
                  const SizedBox(width: 17.0,),
                  InkWell(
                    onTap: (){
                     Get.toNamed(Routes.settingPaymentScreen);
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                    decoration: const BoxDecoration(
                        color: AppColor.appcolor,
                        shape: BoxShape.circle
                    ),
                    child: const Center(
                      child: Icon(Icons.location_on,color: AppColor.white,size: 25,),
                    ),
                  ),
                  const SizedBox(width: 17.0,),
                  InkWell(
                    onTap: (){
                      Get.toNamed(Routes.addressScreen);
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                    decoration: const BoxDecoration(
                        color: AppColor.appcolor,
                        shape: BoxShape.circle
                    ),
                    child: const Center(
                      child: Icon(Icons.attach_money,color: AppColor.white,size: 25,),
                    ),
                  ),
                  const SizedBox(width: 17.0,),
                  InkWell(
                    onTap: (){
                     Get.toNamed(Routes.mySubscription);
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 42,width: 42,
                    decoration: const BoxDecoration(
                        color: AppColor.appcolor,
                        shape: BoxShape.circle
                    ),
                    child: const Center(
                      child: Icon(Icons.event_note_sharp,color: AppColor.white,size: 25,),
                    ),
                  ),
                  const SizedBox(width: 17.0,),
                  InkWell(
                    onTap: (){
                      Get.toNamed(Routes.cmsScreen);
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                    decoration: const BoxDecoration(
                        color: AppColor.appcolor,
                        shape: BoxShape.circle
                    ),
                    child: const Center(
                      child: Icon(Icons.headphones,color: AppColor.white,size: 25,),
                    ),
                  ),
                  const SizedBox(width: 17.0,),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                    decoration: const BoxDecoration(
                        color: AppColor.appcolor,
                        shape: BoxShape.circle
                    ),
                    child: const Center(
                      child: Icon(Icons.help,color: AppColor.white,size: 25,),
                    ),
                  ),
                  const SizedBox(width: 17.0,),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle
                    ),
                    child: const Center(
                      child: Icon(Icons.logout_sharp,color: AppColor.white,size: 25,),
                    ),
                  ),
                  const SizedBox(width: 17.0,),
                  InkWell(
                    onTap: (){
                      Get.toNamed(Routes.loginScreen);
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
      ),
    );
  }
}
