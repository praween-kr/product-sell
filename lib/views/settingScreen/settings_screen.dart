import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/cms_controller.dart';
import 'package:oninto_flutter/common_controller/product/my_product_controller.dart';
import 'package:oninto_flutter/common_controller/settings/address_controller.dart';
import 'package:oninto_flutter/common_controller/settings/settings_controller.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/service/local/user_info_global.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/utils/widgets/dialogs.dart';
import 'package:oninto_flutter/views/settingScreen/cms_screen/cms_screen.dart';

import '../../service/apis.dart';
import '../../utils/image_view.dart';

class SettingScreen extends GetView<SettingsController> {
  SettingScreen({super.key});
  final GlobalController globleController = Get.find();
  final CmsController cmsController = Get.find();
  final MyProductController _myProductController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
              left: 35.0, top: 50, right: 35.0, bottom: 85.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText(
                text: "Account",
                color: AppColor.blackColor,
                textSize: 18,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 20),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.profileScreen);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppImage.profile(
                          context,
                          isNetwork: true,
                          radius: 30,
                          url:
                              "${ImageBaseUrls.profile}${globleController.userInfo.value?.image ?? ''}",
                        ),
                        const SizedBox(width: 3),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              AppText(
                                text:
                                    "${globleController.userInfo.value?.firstName ?? ''} ${globleController.userInfo.value?.lastName ?? ''}",
                                textSize: 15.0,
                                color: AppColor.blackColor,
                                style: AppTextStyle.medium,
                              ),
                              const SizedBox(height: 3.0),
                              Row(
                                children: [
                                  Image.asset(
                                    Assets.assetsSendIcon,
                                    scale: 1.0,
                                  ),
                                  const SizedBox(width: 3.0),
                                  Expanded(
                                    child: AppText(
                                      text: globleController
                                              .userInfo.value?.location ??
                                          '',
                                      textSize: 13.0,
                                      maxlines: 1,
                                      color:
                                          AppColor.blackColor.withOpacity(0.3),
                                      style: AppTextStyle.regular,
                                    ),
                                  ),
                                ],
                              ),
                              // const SizedBox(height: 4.0),
                              // GestureDetector(
                              //   onTap: () {
                              //     Get.toNamed(Routes.insightScreen);
                              //   },
                              //   child: Container(
                              //     padding: const EdgeInsets.symmetric(
                              //         horizontal: 8.0, vertical: 5.0),
                              //     decoration: BoxDecoration(
                              //         color: AppColor.appColor,
                              //         borderRadius: BorderRadius.circular(7.0)),
                              //     child: Row(
                              //       mainAxisSize: MainAxisSize.min,
                              //       children: [
                              //         Image.asset(
                              //           Assets.assetsGraphIcon,
                              //           height: 12.0,
                              //           width: 12.0,
                              //         ),
                              //         const SizedBox(width: 2.0),
                              //         const AppText(
                              //           text: "Insights",
                              //           textSize: 13.0,
                              //           color: AppColor.white,
                              //           style: AppTextStyle.regular,
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined,
                            color: AppColor.blackColor.withOpacity(0.3),
                            size: 15)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 31.0,
              ),
              const AppText(
                text: "Settings",
                textSize: 17.0,
                color: AppColor.blackColor,
                style: AppTextStyle.title,
              ),
              const SizedBox(
                height: 18.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        decoration: const BoxDecoration(
                            color: AppColor.appColor, shape: BoxShape.circle),
                        child: const Center(
                          child: Icon(
                            Icons.notifications,
                            color: AppColor.white,
                            size: 25,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 17.0,
                      ),
                      const AppText(
                        text: "Notifications",
                        textSize: 13.0,
                        color: AppColor.blackColor,
                        style: AppTextStyle.regular,
                      ),
                    ],
                  ),
                  Row(children: [
                    Obx(() => Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            activeColor: AppColor.appColor,
                            thumbColor: AppColor.white,
                            trackColor: Colors.red,
                            value: controller.on.value,
                            onChanged: (val) => controller.toggle(),
                          ),
                        )),
                  ]),
                ],
              ),
              const SizedBox(height: 17.0),
              commonRow(
                  icon: Icons.shopping_cart_rounded,
                  title: "My Products",
                  onClick: () {
                    controller.tabController.value = 1;
                    _myProductController.getAllMyPurchaseShares();
                    Get.toNamed(Routes.productScreen);
                  }),
              const SizedBox(height: 17.0),
              commonRow(
                  icon: Icons.shopping_cart_rounded,
                  title: "My Dashboard",
                  onClick: () {
                    // controller.tabController.value = 1;
                    // _myProductController.getMyProducts();
                    Get.toNamed(Routes.myDashboard);
                  }),
              const SizedBox(height: 17.0),

              /// Password Row
              commonRow(
                  icon: Icons.lock,
                  title: "Password",
                  onClick: () {
                    Get.toNamed(Routes.passwordScreen);
                  }),
              const SizedBox(height: 17.0),

              /// Payment Row
              commonRow(
                icon: Icons.payment,
                title: "Payment",
                onClick: () {
                  // Get.toNamed(Routes.settingPaymentScreen);
                  Get.toNamed(Routes.transactionHistories);
                },
              ),
              const SizedBox(
                height: 17.0,
              ),

              /// Address Row
              commonRow(
                icon: Icons.location_on,
                title: "Address",
                onClick: () {
                  if (AddressController().initialized) {
                    Get.find<AddressController>().getAddresses();
                  } else {
                    Get.put(AddressController()).getAddresses();
                  }

                  Get.toNamed(Routes.addressScreen);
                },
              ),
              const SizedBox(
                height: 17.0,
              ),

              /// My Subscription Row
              commonRow(
                icon: Icons.attach_money,
                title: "My Subscription",
                onClick: () {
                  Get.toNamed(Routes.subscriptionScreen);
                },
              ),
              const SizedBox(
                height: 17.0,
              ),

              /// Privacy Policy Row
              commonRow(
                icon: Icons.event_note_sharp,
                title: "Privacy Policy",
                onClick: () {
                  cmsController.getcms(CmsType.privacyPolicy);
                  Get.to(CmsScreen(), arguments: CmsType.privacyPolicy);
                },
              ),
              const SizedBox(
                height: 17.0,
              ),

              /// Help Center Row
              commonRow(
                icon: Icons.headphones,
                title: "Help Center",
                onClick: () {
                  cmsController.getcms(CmsType.help);
                  Get.to(CmsScreen(), arguments: CmsType.help);
                },
              ),
              const SizedBox(
                height: 17.0,
              ),

              /// About Us Row
              commonRow(
                icon: Icons.help,
                title: "About Us",
                onClick: () {
                  cmsController.getcms(CmsType.aboutUs);
                  Get.to(CmsScreen(), arguments: CmsType.aboutUs);
                },
              ),
              const SizedBox(height: 17.0),

              /// Logout Row
              commonRow(
                reverseIcon: true,
                icon: Icons.logout_sharp,
                title: "Logout",
                color: AppColor.blackColor,
                boxColor: AppColor.prdTextColor,
                onClick: () => AppDialogs.confirm(
                  context,
                  msg: "Are you sure\nwant to Logout?",
                  clickOnYes: () {
                    controller.logout();
                  },
                ),
              ),
              const SizedBox(
                height: 17.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// CommonRow View
  Widget commonRow(
      {required IconData icon,
      Color? color,
      Color? boxColor,
      required String title,
      required Function onClick,
      bool reverseIcon = false}) {
    return GestureDetector(
      onTap: () {
        onClick();
      },
      child: Card(
        elevation: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              decoration: BoxDecoration(
                  color: boxColor ?? AppColor.appColor, shape: BoxShape.circle),
              child: Center(
                child: reverseIcon
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(60),
                        child: Icon(
                          icon,
                          color: AppColor.white,
                          size: 25,
                        ),
                      )
                    : Icon(
                        icon,
                        color: AppColor.white,
                        size: 25,
                      ),
              ),
            ),
            const SizedBox(
              width: 17.0,
            ),
            AppText(
              text: title,
              textSize: 13.0,
              color: color ?? AppColor.blackColor,
              style: AppTextStyle.regular,
            ),
          ],
        ),
      ),
    );
  }
}
