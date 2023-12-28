import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oninto_flutter/common_controller/home/categories_controller.dart';
import 'package:oninto_flutter/common_controller/product/my_product_controller.dart';
import 'package:oninto_flutter/common_controller/product/sell_item_controller.dart';
import 'package:oninto_flutter/utils/details_images_view.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/utils/date_time_formates.dart';
import 'package:oninto_flutter/utils/shimmer_widget.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import '../../../utils/appbar.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/common_button.dart';
import '../../../routes/routes.dart';

class MyPysicalProductDetailScreen extends StatelessWidget {
  MyPysicalProductDetailScreen({super.key});
  final MyProductController _myProductController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: CommonAppbarWidget(
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
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: AppColor.appColor,
                borderRadius: BorderRadius.circular(15)),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        // heading: "Samsung Note 10",
        textStyle: const TextStyle(
            fontSize: 20,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: Obx(() => RefreshIndicator(
            onRefresh: () async {
              await _myProductController.getProductDetails(
                  (_myProductController.productDetailsData.value?.details?.id ??
                          '')
                      .toString());
            },
            child: _myProductController.loadingData.value
                ? ShimmerWidgets.product()
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 30.0),
                      child: Column(
                        children: [
                          DetailsImagesView(
                              images: (_myProductController.productDetailsData
                                          .value?.details?.productImages ??
                                      [])
                                  .map((e) => e.image ?? '')
                                  .toList()),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 30.0, top: 15.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // AppText(
                                                //   text: _myProductController
                                                //           .productDetails
                                                //           .value
                                                //           ?.name ??
                                                //       '',
                                                //   textSize: 17.0,
                                                //   color: AppColor.appcolor,
                                                //   style: AppTextStyle.medium,
                                                // ),
                                                // const SizedBox(
                                                //   height: 10,
                                                // ),
                                                AppText(
                                                  text: _myProductController
                                                          .productDetailsData
                                                          .value
                                                          ?.details
                                                          ?.name ??
                                                      '',
                                                  textSize: 15.0,
                                                  color: AppColor.blackColor,
                                                  style: AppTextStyle.medium,
                                                ),
                                                const SizedBox(height: 10),
                                                AppText(
                                                  text:
                                                      "\$${_myProductController.productDetailsData.value?.details?.price ?? '0.0'}",
                                                  textSize: 23.0,
                                                  color: AppColor.appColor,
                                                  style: AppTextStyle.title,
                                                ),
                                                const SizedBox(height: 5),
                                                AppText(
                                                  text:
                                                      "Inclusive of all taxes",
                                                  textSize: 10.0,
                                                  color: AppColor.blackColor
                                                      .withOpacity(0.3),
                                                  style: AppTextStyle.regular,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                const Icon(
                                                  Icons.favorite,
                                                  color: AppColor.appColor,
                                                ),
                                                const SizedBox(height: 5),
                                                AppText(
                                                  text: "${_myProductController
                                                      .productDetailsData
                                                      .value
                                                      ?.favoriteCount ??
                                                      '0'}",
                                                  textSize: 15.0,
                                                  color: AppColor.blackColor
                                                      .withOpacity(0.3),
                                                  style: AppTextStyle.regular,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 20),
                                            Column(
                                              children: [
                                                const Icon(
                                                  Icons.visibility,
                                                  color: AppColor.appColor,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                AppText(
                                                  text: "199",
                                                  textSize: 15.0,
                                                  color: AppColor.blackColor
                                                      .withOpacity(0.3),
                                                  style: AppTextStyle.regular,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    commonText(
                                      "Category",
                                      _myProductController.productDetailsData
                                              .value?.details?.category?.name ??
                                          '',
                                    ),
                                    const SizedBox(height: 10),
                                    commonText(
                                      "Sub Category",
                                      _myProductController
                                              .productDetailsData
                                              .value
                                              ?.details
                                              ?.category
                                              ?.subCategory
                                              ?.name ??
                                          '',
                                    ),
                                    const SizedBox(height: 10),
                                    commonText(
                                        "Color",
                                        _myProductController.productDetailsData
                                                .value?.details?.color ??
                                            ''),
                                    const SizedBox(height: 10),
                                    commonText(
                                        "Brand",
                                        _myProductController.productDetailsData
                                                .value?.details?.brand ??
                                            ''),
                                    //const SizedBox(height: 20,),
                                  ],
                                ),
                              ),
                              Divider(
                                color: AppColor.blackColor.withOpacity(0.1),
                                thickness: 2,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 30.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const AppText(
                                      text: "Condition",
                                      color: AppColor.appColor,
                                      textSize: 15,
                                      style: AppTextStyle.title,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const AppText(
                                      text: "New with tags",
                                      color: AppColor.blackColor,
                                      textSize: 13,
                                      style: AppTextStyle.title,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    AppText(
                                      text:
                                          "A brand-new, unused item with tags attached or "
                                          "in the original packing.",
                                      color:
                                          AppColor.blackColor.withOpacity(0.3),
                                      textSize: 12,
                                      style: AppTextStyle.medium,
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                color: AppColor.blackColor.withOpacity(0.1),
                                thickness: 2,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30.0, right: 30.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    commonText(
                                        "Location :",
                                        _myProductController.productDetailsData
                                                .value?.details?.location ??
                                            ''),
                                    const SizedBox(height: 10),
                                    commonText(
                                        "Posted Date",
                                        AppDateTime.getDateTime(
                                            _myProductController
                                                    .productDetailsData
                                                    .value
                                                    ?.details
                                                    ?.createdAt ??
                                                '',
                                            format: DateFormat("dd MMM yyyy"))),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(Assets.assetsSale),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const AppText(
                                          text: "Item Description",
                                          textSize: 13,
                                          fontFamily: "Poppins",
                                          color: AppColor.blackColor,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        AppText(
                                            text: _myProductController
                                                    .productDetailsData
                                                    .value
                                                    ?.details
                                                    ?.description ??
                                                '',
                                            textSize: 13,
                                            fontFamily: "Poppins",
                                            color: AppColor.blackColor
                                                .withOpacity(0.3)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 31.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.subscriptionScreen,
                                    // arguments: "plan"
                                  );
                                },
                                child: CommonButton(
                                  color: AppColor.textColor,
                                  height: 57,
                                  radius: 23,
                                  text: "Boost your post",
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 35),
                                  textStyle: TextStyle(
                                      color:
                                          AppColor.blackColor.withOpacity(0.3),
                                      fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                height: 31.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  //Get.toNamed(Routes.editItemScreen);
                                  if (CategoriesController().initialized) {
                                    Get.find<CategoriesController>()
                                        .getCategories();
                                  } else {
                                    Get.put(CategoriesController())
                                        .getCategories();
                                  }
                                  //
                                  SellItemController sc;
                                  if (SellItemController().initialized) {
                                    sc = Get.find<SellItemController>();
                                  } else {
                                    sc = Get.put(SellItemController());
                                  }
                                  sc.tabController.value = 1;
                                  sc.initialData(_myProductController
                                      .productDetailsData.value?.details);

                                  Get.toNamed(Routes.sellItemScreen,
                                          arguments: 'edit')!
                                      .then((value) async {
                                    await _myProductController
                                        .getProductDetails((_myProductController
                                                    .productDetailsData
                                                    .value
                                                    ?.details
                                                    ?.id ??
                                                '')
                                            .toString());
                                  });
                                },
                                child: const CommonButton(
                                  color: AppColor.appColor,
                                  height: 57,
                                  text: "Edit",
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 35),
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
          )),
    );
  }

  /// Common Text View
  Widget commonText(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: title,
          color: AppColor.itemBorderColor,
          textSize: 12,
          style: AppTextStyle.medium,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: AppText(
            text: value,
            color: AppColor.blackColor,
            textSize: 12,
            style: AppTextStyle.medium,
          ),
        ),
      ],
    );
  }
}
