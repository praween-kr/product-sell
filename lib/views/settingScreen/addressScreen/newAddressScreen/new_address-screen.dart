import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oninto_flutter/common_controller/settings/address_controller.dart';
import 'package:oninto_flutter/utils/app_text_field.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/utils/google/pick_location_map.dart';
import 'package:oninto_flutter/views/search_google_address.dart';

import '../../../../utils/app_text.dart';
import '../../../../utils/appbar.dart';

class NewAddressScreen extends StatelessWidget {
  NewAddressScreen({super.key});

  final AddressController addressController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CommonAppbarWidget(
        heading: (Get.arguments != null && Get.arguments["mode"] == "edit")
            ? "Edit Address"
            : "Add New Address",
        textStyle: const TextStyle(
            fontSize: 20,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, top: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                onClick: () => Get.to(
                  () => SearchGoogleAddress(
                    onChanged: (place) {
                      addressController.location.text = place.address ?? '';
                      addressController.cordinates.value =
                          place.cordinates?.location == null
                              ? null
                              : LatLng(place.cordinates?.location!.lat ?? 0.0,
                                  place.cordinates?.location?.lng ?? 0.0);
                    },
                  ),
                ),
                readOnly: true,
                controller: addressController.location,
                height: 46.0,
                title: "Address Title",
                contentPadding: const EdgeInsets.only(top: 5.0, left: 1.0),
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
                          style:
                              const TextStyle(fontSize: 10, color: Colors.grey),
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
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => PickLocationMap(
                                cordinates: addressController.cordinates.value,
                                onChanged: (location) {
                                  addressController.location.text =
                                      location?.location ?? '';
                                  addressController.cordinates.value =
                                      location == null
                                          ? null
                                          : LatLng(location.lat, location.lag);
                                },
                              ))!
                          .then(
                        (value) async {
                          addressController.refreshMap.value = true;
                          await Future.delayed(
                              const Duration(milliseconds: 200));
                          addressController.refreshMap.value = false;
                        },
                      );
                    },
                    child: Stack(
                      children: [
                        Obx(
                          () => addressController.refreshMap.value
                              ? Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  color:
                                      const Color.fromARGB(31, 107, 106, 104),
                                )
                              : PickLocationMap(
                                  cordinates:
                                      addressController.cordinates.value,
                                  onChanged: (location) {
                                    addressController.location.text =
                                        location?.location ?? '';
                                    addressController.cordinates.value =
                                        location == null
                                            ? null
                                            : LatLng(
                                                location.lat, location.lag);
                                  },
                                ),
                        ),
                        Container(color: Colors.white.withOpacity(0.2))
                      ],
                    ),
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
                contentPadding: const EdgeInsets.only(top: 8.0, left: 13.0),
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
                contentPadding: const EdgeInsets.only(top: 8.0, left: 13.0),
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
                contentPadding: const EdgeInsets.only(top: 8.0, left: 13.0),
                margin: const EdgeInsets.only(right: 35.0),
                borderRadius: BorderRadius.circular(40),
                containerColor: AppColor.textColor,
              ),
              SizedBox(height: Get.height * 0.08),
              GestureDetector(
                onTap: () {
                  if (Get.arguments != null &&
                      Get.arguments["mode"] == "edit") {
                    addressController
                        .editAddress(Get.arguments["address_id"].toString());
                  } else {
                    addressController.saveAddress();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 30),
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColor.appColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: AppText(
                    text:
                        "${(Get.arguments != null && Get.arguments["mode"] == "edit") ? "Edit" : 'Save'} Address",
                    color: AppColor.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
