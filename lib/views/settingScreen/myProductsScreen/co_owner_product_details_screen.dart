import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/product/my_product_controller.dart';
import 'package:oninto_flutter/utils/appbar.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/utils/common_button.dart';
import 'package:oninto_flutter/utils/details_images_view.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/shimmer_widget.dart';

class CoOwnerProductDetailsScreen extends StatelessWidget {
  CoOwnerProductDetailsScreen({super.key});
  final MyProductController _myProductController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(
        // heading: "Gyarados Ex",
        headingChild: Obx(
          () => _myProductController.loadingData.value
              ? ShimmerWidgets.text(w: Get.width * 0.4)
              : Text(
                  _myProductController
                          .productDetailsData.value?.details?.name ??
                      '',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
        ),
        textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 18,
            fontFamily: "Poppins"),
      ),
      body: Obx(
        () => _myProductController.loadingData.value
            ? ShimmerWidgets.product()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    DetailsImagesView(
                        images: (_myProductController.productDetailsData.value
                                    ?.details?.productImages ??
                                [])
                            .map((e) => e.image ?? '')
                            .toList()),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                              text: _myProductController.productDetailsData
                                      .value?.details?.name ??
                                  '',
                              textSize: 14,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500),
                          const SizedBox(height: 5),
                          AppText(
                            text: _myProductController.productDetailsData.value
                                    ?.details?.description ??
                                '',
                            textSize: 11,
                            fontFamily: "Poppins",
                            lineHeight: 1.5,
                            fontWeight: FontWeight.w400,
                          ),
                          const SizedBox(height: 5),
                          const Divider(thickness: 1),
                          const SizedBox(height: 5),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                  text: "Volume: 0",
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  textSize: 14),
                              AppText(
                                  text: "High: 1.00",
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  textSize: 14),
                              AppText(
                                  text: "Low: 1.00",
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  textSize: 14)
                            ],
                          ),
                          const SizedBox(height: 5),
                          const Divider(thickness: 1),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AppText(
                                  text: "Last Trade Price: \$1.00",
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  textSize: 14),
                              AppText(
                                  text:
                                      "Available Shares: ${_myProductController.productDetailsData.value?.details?.share ?? 0}/${_myProductController.productDetailsData.value?.details?.share ?? 0}",
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  textSize: 14),
                            ],
                          ),
                          const SizedBox(height: 40),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.navbarScreen);
                            },
                            child: CommonButton(
                              height: 50,
                              radius: 20,
                              color: AppColor.appColor,
                              text: "Community",
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
