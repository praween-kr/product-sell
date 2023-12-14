import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/settings/address_controller.dart';
import 'package:oninto_flutter/utils/appbar.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/model/settings/address_model.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utils/empty_widget.dart';

import '../../../utils/common_button.dart';
import '../../../utils/colors_file.dart';
import '../../../utils/app_text.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({super.key});
  // final controller = Get.put(AddressController());
  final AddressController addressController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
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
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  itemCount: addressController.addresses.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    AddressModel address =
                                        addressController.addresses[index];
                                    return addressCard(
                                        address: address,
                                        onClick: () {
                                          //
                                        });
                                  }),
                        ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.settingPaymentScreen);
                  },
                  child: CommonButton(
                    color: AppColor.appColor,
                    margin: const EdgeInsets.only(right: 30.0, left: 30.0),
                    height: 57,
                    text: "Pay Now",
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 35.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.newAddressScreen);
                  },
                  child: CommonButton(
                    color: AppColor.appColor,
                    margin: const EdgeInsets.only(right: 30.0, left: 30.0),
                    height: 57,
                    text: "Add New Address",
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 15),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget addressCard(
      {required Function onClick, required AddressModel address}) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        decoration: BoxDecoration(
            color: AppColor.white,
            border: Border.all(
                color:
                    // controller.selectedContainer.value ==
                    //         index
                    //     ? AppColor.appcolor
                    // :
                    AppColor.borderColor.withOpacity(0.3),
                // AppColor.appcolor,
                width: 1.0),
            borderRadius: BorderRadius.circular(13.0)),
        child: Row(
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
                  const SizedBox(
                    height: 5.0,
                  ),
                  AppText(
                    text: "+1-0000-0000",
                    style: AppTextStyle.medium,
                    textSize: 12.0,
                    color: AppColor.blackColor.withOpacity(0.3),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // mapDialog(LatLng(double.parse(address.latitude ?? '0.0'),
                //     double.parse(address.longitude ?? '0.0')));
              },
              child: Image.asset(
                Assets.assetsLocationImage,
                height: 61.0,
                width: 61.0,
              ),
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
