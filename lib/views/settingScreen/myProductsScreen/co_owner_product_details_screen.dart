import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/product/product_controller.dart';
import 'package:oninto_flutter/common_widget/app_string.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/common_widget/common_button.dart';
import 'package:oninto_flutter/common_widget/details_images_view.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';

class CoOwnerProductDetailsScreen extends StatelessWidget {
  CoOwnerProductDetailsScreen({super.key});
  final ProductController _productController = Get.find();

  @override
  Widget build(BuildContext context) {
    print(
        "---> ${_productController.productDetails.value?.productImages ?? []}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(
        heading: "Gyarados Ex",
        textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 18,
            fontFamily: "Poppins"),
      ),
      body: Obx(
        () => _productController.loadingdata.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    DetailsImagesView(
                        images: (_productController
                                    .productDetails.value?.productImages ??
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
                            text:
                                _productController.productDetails.value?.name ??
                                    '',
                            textSize: 14,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          AppText(
                            text: AppStrings.Gyrados,
                            textSize: 11,
                            fontFamily: "Poppins",
                            lineHeight: 1.5,
                            fontWeight: FontWeight.w400,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                text: "Volume: 0",
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                textSize: 14,
                              ),
                              AppText(
                                text: "High: 1.00",
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                textSize: 14,
                              ),
                              AppText(
                                text: "Low: 1.00",
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                textSize: 14,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                text: "Last Trade Price: \$1.00",
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                textSize: 14,
                              ),
                              AppText(
                                text: "Available Shares: 0/300",
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                textSize: 14,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.navbarScreen);
                            },
                            child: CommonButton(
                              height: 50,
                              radius: 20,
                              color: AppColor.appcolor,
                              text: "Community",
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
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
