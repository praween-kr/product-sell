import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/settings/address_controller.dart';
import 'package:oninto_flutter/common_widget/app_textfield.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/common_widget/common_button.dart';
import 'package:oninto_flutter/utills/colors_file.dart';
import 'package:oninto_flutter/utills/google/app_map_view.dart';
import 'package:oninto_flutter/views/search_google_address.dart';

import '../../../../common_widget/appbar.dart';
import '../../../../utills/common_appbar.dart';

class NewAddressScreen extends StatelessWidget {
  NewAddressScreen({super.key});

  AddressController addressController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      resizeToAvoidBottomInset: false,
      appBar: CommonAppbarWidget(
        heading: "Addresses",
        textStyle: const TextStyle(
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 35.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextField(
                      maxLength: 1,
                      onClick: () => Get.to(
                        () => SearchGoogleAddress(
                          onChanged: (place) {
                            addressController.googleSearchQuery.text =
                                place.address ?? '';
                          },
                        ),
                      ),
                      readOnly: true,
                      controller: addressController.googleSearchQuery,
                      height: 46.0,
                      title: "Address Title",
                      contentPadding:
                          const EdgeInsets.only(top: 5.0, left: 1.0),
                      margin: const EdgeInsets.only(right: 35.0),
                      borderRadius: BorderRadius.circular(40),
                      containerColor: AppColor.TextColor,
                      onChanged: (query) async {
                        await addressController.searchGooglePlaces();
                      },
                      prefix: Icon(
                        Icons.location_on,
                        size: 18.0,
                        color: AppColor.blackColor.withOpacity(0.3),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    const AppText(
                      text: "Choose Location",
                      style: AppTextStyle.title,
                      textSize: 15.0,
                      color: AppColor.blackColor,
                    ),
                    const SizedBox(height: 13.0),
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: Image.asset(
                    //     Assets.assetsLocationImage,
                    //     height: 100,
                    //   ),
                    // ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        height: Get.height * 0.2,
                        width: Get.width * 0.85,
                        child: const AppMapView(),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    const AppText(
                      text: "Street",
                      style: AppTextStyle.medium,
                      textSize: 13.0,
                      color: AppColor.blackColor,
                    ),
                    const SizedBox(
                      height: 14.0,
                    ),
                    AppTextField(
                      height: 46.0,
                      title: "Add",
                      style: const TextStyle(fontSize: 13),
                      contentPadding:
                          const EdgeInsets.only(top: 8.0, left: 13.0),
                      margin: const EdgeInsets.only(right: 35.0),
                      borderRadius: BorderRadius.circular(40),
                      containerColor: AppColor.TextColor,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const AppText(
                      text: "House No.",
                      style: AppTextStyle.medium,
                      textSize: 13.0,
                      color: AppColor.blackColor,
                    ),
                    const SizedBox(
                      height: 14.0,
                    ),
                    AppTextField(
                      height: 46.0,
                      title: "Add",
                      style: const TextStyle(fontSize: 13),
                      contentPadding:
                          const EdgeInsets.only(top: 8.0, left: 13.0),
                      margin: const EdgeInsets.only(right: 35.0),
                      borderRadius: BorderRadius.circular(40),
                      containerColor: AppColor.TextColor,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const AppText(
                      text: "Landmark",
                      style: AppTextStyle.medium,
                      textSize: 13.0,
                      color: AppColor.blackColor,
                    ),
                    const SizedBox(
                      height: 14.0,
                    ),
                    AppTextField(
                      height: 46.0,
                      title: "Add",
                      style: const TextStyle(fontSize: 13),
                      contentPadding:
                          const EdgeInsets.only(top: 8.0, left: 13.0),
                      margin: const EdgeInsets.only(right: 35.0),
                      borderRadius: BorderRadius.circular(40),
                      containerColor: AppColor.TextColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: CommonButton(
              color: AppColor.appcolor,
              margin: const EdgeInsets.only(right: 30, left: 30, bottom: 20),
              height: 57,
              text: "Save Address",
              textStyle: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
