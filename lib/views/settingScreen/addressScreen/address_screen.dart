import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oninto_flutter/common_controller/settings/address_controller.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/model/settings/address_model.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utils/app_toast_loader.dart';
import 'package:oninto_flutter/utils/appbar.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/utils/empty_widget.dart';
import 'package:oninto_flutter/utils/widgets/dialogs.dart';

import '../../../utils/app_text.dart';
import '../../../utils/common_button.dart';
import '../../../utils/google/pick_location_map.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({super.key, this.paynow});
  final Function(String)? paynow;
  // final controller = Get.put(AddressController());
  final AddressController addressController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const CommonAppbarWidget(
        heading: "Addresses",
        textStyle: TextStyle(
            fontSize: 20,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Get.arguments?['type'] == 'select_address'
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: AppText(
                    text: "Select shiping address",
                    style: AppTextStyle.title,
                    textSize: 15.0,
                    color: AppColor.grey,
                    fontWeight: FontWeight.w400,
                  ),
                )
              : const SizedBox.shrink(),
          Expanded(
            child: SizedBox(
              height: double.infinity,
              child: RefreshIndicator(
                onRefresh: () async {
                  await addressController.getAddresses();
                },
                child: Obx(
                  () => addressController.loadingData.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : SizedBox(
                          height: double.infinity,
                          child: addressController.addresses.isEmpty
                              ? EmptyWidgets.simple()
                              : ListView.builder(
                                  physics: const ClampingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  itemCount: addressController.addresses.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    AddressModel address =
                                        addressController.addresses[index];
                                    return Obx(
                                      () => addressCard(
                                        context,
                                        address: address,
                                        selected: address.id ==
                                            addressController
                                                .selectedAddress.value?.id,
                                        onClick: () {
                                          if (address.id ==
                                              addressController
                                                  .selectedAddress.value?.id) {
                                            addressController
                                                .selectedAddress.value = null;
                                          } else {
                                            addressController.selectedAddress
                                                .value = address;
                                          }
                                        },
                                      ),
                                    );
                                  }),
                        ),
                ),
              ),
            ),
          ),
          Get.arguments?['type'] == 'select_address'
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (addressController.selectedAddress.value == null) {
                            AppToast.show("Please select shiping address");
                            return;
                          }
                          if (paynow != null) {
                            paynow!(
                                (addressController.selectedAddress.value?.id ??
                                        '')
                                    .toString());
                          }
                        },
                        child: const CommonButton(
                          color: AppColor.appColor,
                          margin: EdgeInsets.only(right: 30.0, left: 30.0),
                          height: 57,
                          text: "Pay Now",
                          textStyle:
                              TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.only(bottom: 35.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.newAddressScreen,
                        arguments: {"mode": "add"});
                  },
                  child: const CommonButton(
                    color: AppColor.appColor,
                    margin: EdgeInsets.only(right: 30.0, left: 30.0),
                    height: 57,
                    text: "Add New Address",
                    textStyle: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget addressCard(BuildContext context,
      {required Function onClick,
      required AddressModel address,
      bool selected = false}) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        padding: const EdgeInsets.only(left: 14.0, right: 14.0, top: 14.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        decoration: BoxDecoration(
            color:
                selected ? AppColor.appColor.withOpacity(0.1) : AppColor.white,
            border: Border.all(
                color: selected
                    ? AppColor.appColor
                    : AppColor.borderColor.withOpacity(0.3),
                // AppColor.appcolor,
                width: 1.0),
            borderRadius: BorderRadius.circular(13.0)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppText(
                        text: "Office",
                        style: AppTextStyle.title,
                        textSize: 15.0,
                        color: AppColor.blackColor,
                      ),
                      const SizedBox(height: 5.0),
                      AppText(
                        text: address.location ?? '',
                        style: AppTextStyle.medium,
                        textSize: 13.0,
                        color: AppColor.blackColor.withOpacity(0.3),
                      ),
                      const SizedBox(height: 5.0),
                      AppText(
                        text: address.street ?? '',
                        style: AppTextStyle.medium,
                        textSize: 11.0,
                        color: AppColor.blackColor.withOpacity(0.3),
                      ),
                      const SizedBox(height: 5.0),
                      AppText(
                        text: address.landMark ?? '',
                        style: AppTextStyle.medium,
                        textSize: 11.0,
                        color: AppColor.blackColor.withOpacity(0.3),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => PickLocationMap(
                          cordinates: addressController.cordinates.value,
                          onChanged: (location) {
                            addressController.location.text =
                                location?.location ?? '';
                            addressController.cordinates.value =
                                location == null
                                    ? null
                                    : LatLng(
                                        double.parse(address.latitude ?? '0'),
                                        double.parse(address.longitude ?? '0'));
                          },
                        ));
                  },
                  child: Image.asset(Assets.assetsLocationImage,
                      height: 61.0, width: 61.0),
                ),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(30),
                //   child: Container(
                //     color: Colors.grey.shade200,
                //     height: 60,
                //     width: 60,
                //     child: AppMapView(
                //         initialLatLong: LatLng(
                //             double.parse(address.latitude ?? '0.0'),
                //             double.parse(address.longitude ?? '0.0'))),
                //   ),
                // )
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    addressController.initialFields(
                        houseNo: address.houseNo ?? '',
                        landMark: address.landMark ?? '',
                        latitude: address.latitude ?? '',
                        longitude: address.longitude ?? '',
                        location: address.location ?? '',
                        street: address.street ?? '');
                    Get.toNamed(Routes.newAddressScreen,
                        arguments: {"mode": "edit", "address_id": address.id});
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColor.appColor.withOpacity(0.5),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: AppColor.blue,
                        size: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    // Get.toNamed(Routes.newAddressScreen,
                    //     arguments: {"mode": "add"});
                    AppDialogs.confirm(
                      context,
                      msg: "Are you sure, want to delete?",
                      clickOnYes: () async {
                        await addressController
                            .deleteAddress(address.id.toString());
                      },
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: AppColor.appColor.withOpacity(0.5)),
                      child: const Icon(
                        Icons.delete,
                        color: AppColor.red,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3),
          ],
        ),
      ),
    );
  }

  // mapDialog(LatLng latLng) {
  //   Get.dialog(
  //     Container(
  //       decoration: BoxDecoration(
  //           color: Colors.white, borderRadius: BorderRadius.circular(20)),
  //       height: Get.height * 0.4,
  //       width: Get.width * 0.8,
  //       padding: const EdgeInsets.all(20),
  //       margin: const EdgeInsets.all(30),
  //       child: Column(
  //         children: [
  //           const Icon(Icons.cancel),
  //           Expanded(child: AppMapView(initialLatLong: latLng)),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
