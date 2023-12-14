import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oninto_flutter/common_controller/settings/address_controller.dart';
import 'package:oninto_flutter/utils/app_text_field.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/utils/common_button.dart';
import 'package:oninto_flutter/utils/google/pick_location_map.dart';
import 'package:oninto_flutter/views/search_google_address.dart';

import '../../../../utils/appbar.dart';
import '../../../../utils/app_text.dart';

class NewAddressScreen extends StatelessWidget {
  NewAddressScreen({super.key});

  final AddressController addressController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      resizeToAvoidBottomInset: false,
      appBar: const CommonAppbarWidget(
        heading: "Add New Address",
        textStyle: TextStyle(
            fontSize: 20,
            color: AppColor.blackColor,
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
                      onClick: () => Get.to(
                        () => SearchGoogleAddress(
                          onChanged: (place) {
                            addressController.location.text =
                                place.address ?? '';
                            addressController.cordinates.value =
                                place.cordinates?.location == null
                                    ? null
                                    : LatLng(
                                        place.cordinates?.location!.lat ?? 0.0,
                                        place.cordinates?.location?.lng ?? 0.0);
                          },
                        ),
                      ),
                      readOnly: true,
                      controller: addressController.location,
                      height: 46.0,
                      title: "Address Title",
                      contentPadding:
                          const EdgeInsets.only(top: 5.0, left: 1.0),
                      margin: const EdgeInsets.only(right: 35.0),
                      borderRadius: BorderRadius.circular(40),
                      containerColor: AppColor.textColor,
                      prefix: Icon(
                        Icons.location_on,
                        size: 18.0,
                        color: AppColor.blackColor.withOpacity(0.3),
                      ),
                      suffix: const Icon(
                        Icons.search,
                        size: 22.0,
                        color: AppColor.themeColor,
                      ),
                    ),
                    Obx(
                      () => addressController.cordinates.value == null
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                "Latitude: ${addressController.cordinates.value?.latitude}, Longitude: ${addressController.cordinates.value?.latitude}",
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.grey),
                              ),
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        color: Colors.grey.shade300,
                        height: Get.height * 0.2,
                        width: Get.width * 0.85,
                        child: PickLocationMap(
                          onChanged: (location) {
                            addressController.location.text =
                                location?.location ?? '';
                            addressController.cordinates.value =
                                location == null
                                    ? null
                                    : LatLng(location.lat, location.lag);
                          },

                          // AppMapView(
                          //     initialLatLong:
                          //         addressController.cordinates.value),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
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
                      controller: addressController.street,
                      height: 46.0,
                      title: "Street",
                      style: const TextStyle(fontSize: 13),
                      contentPadding:
                          const EdgeInsets.only(top: 8.0, left: 13.0),
                      margin: const EdgeInsets.only(right: 35.0),
                      borderRadius: BorderRadius.circular(40),
                      containerColor: AppColor.textColor,
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
                      controller: addressController.houseNo,
                      height: 46.0,
                      title: "House no.",
                      style: const TextStyle(fontSize: 13),
                      contentPadding:
                          const EdgeInsets.only(top: 8.0, left: 13.0),
                      margin: const EdgeInsets.only(right: 35.0),
                      borderRadius: BorderRadius.circular(40),
                      containerColor: AppColor.textColor,
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
                      controller: addressController.landmark,
                      height: 46.0,
                      title: "Landmark",
                      style: const TextStyle(fontSize: 13),
                      contentPadding:
                          const EdgeInsets.only(top: 8.0, left: 13.0),
                      margin: const EdgeInsets.only(right: 35.0),
                      borderRadius: BorderRadius.circular(40),
                      containerColor: AppColor.textColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              addressController.saveAddress();
            },
            child: const CommonButton(
              color: AppColor.appColor,
              margin: EdgeInsets.only(right: 30, left: 30, bottom: 20),
              height: 57,
              text: "Save Address",
              textStyle: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
