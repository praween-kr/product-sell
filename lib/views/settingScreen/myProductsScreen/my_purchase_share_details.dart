import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/appbar.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/utils/common_button.dart';
import 'package:oninto_flutter/utils/date_time_formates.dart';

import '../../../common_controller/home/home_controller.dart';
import '../../../common_controller/product/my_product_controller.dart';
import '../../../model/product/my_purchase_share_details_model.dart';
import '../../../routes/routes.dart';

class MyPurchaseShareDetails extends StatelessWidget {
  MyPurchaseShareDetails({super.key});
  final MyProductController _myProductController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppbarWidget(
        heading: "Share Details",
        // headingChild: Obx(
        //   () => Text(
        //     _myProductController.purchaseShareDetails.value?.name ?? '',
        //     style: const TextStyle(
        //       color: Colors.black,
        //       fontWeight: FontWeight.w600,
        //       fontSize: 15,
        //     ),
        //   ),
        // ),
      ),
      body: SizedBox(
        height: double.infinity,
        child: Obx(
          () => _myProductController.loadingData.value
              ? const Center(child: AppText(text: "Loading..."))
              : RefreshIndicator(
                  onRefresh: () async {
                    await _myProductController.getPurchaseShareDetails(
                        (_myProductController.purchaseShareDetails.value?.id ??
                                '')
                            .toString());
                  },
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: AppText(
                                      text: _myProductController
                                              .purchaseShareDetails
                                              .value
                                              ?.name ??
                                          '',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  AppButton.text(
                                    title: "View",
                                    active: true,
                                    onClick: () {
                                      _viewShareAndBuy();
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  infoTile(
                                      level: "Total Invested: ",
                                      value:
                                          "\$${_myProductController.purchaseShareDetails.value?.totalPurchaseSharePrice ?? 0}"),
                                  infoTile(
                                      alignEnd: true,
                                      level: "Total Quantity: ",
                                      value:
                                          "${_myProductController.purchaseShareDetails.value?.totalSharePurchase ?? 0} Shares"),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  infoTile(
                                    level: "Total Profites: ",
                                    value:
                                        "\$${_myProductController.purchaseShareDetails.value?.totalProfit ?? 0.0}",
                                    valueColor: (_myProductController
                                                    .purchaseShareDetails
                                                    .value
                                                    ?.totalProfit ??
                                                0.0) <
                                            0
                                        ? AppColor.red
                                        : AppColor.green,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          color: Colors.grey.shade200,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 22, vertical: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: AppText(
                                    text: "Quantity x Price",
                                    textSize: 14,
                                  ),
                                ),
                                AppText(
                                  text: "Invested Price",
                                  textSize: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            SharePurchases data = (_myProductController
                                    .purchaseShareDetails
                                    .value
                                    ?.sharePurchases ??
                                [])[index];

                            return Container(
                              color: Colors.grey.shade100,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 22, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                              text:
                                                  "${data.totalSharePurchase ?? 0} ",
                                              style:
                                                  DefaultTextStyle.of(context)
                                                      .style,
                                              children: <TextSpan>[
                                                const TextSpan(
                                                    text: 'Shares x ',
                                                    style: TextStyle(
                                                      color: AppColor.grey,
                                                    )),
                                                TextSpan(
                                                    text:
                                                        '\$${data.perSharePrice ?? '0'}'),
                                              ],
                                            ),
                                          ),
                                        ),
                                        AppText(
                                          text:
                                              "\$${((data.totalSharePurchase ?? 0) * (data.perSharePrice ?? 0.0)).toStringAsFixed(1)}",
                                          textSize: 14,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                          color: AppColor.appColor
                                              .withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: AppText(
                                        text: data.createdAt == null
                                            ? ''
                                            : "${AppDateTime.getDateTime(
                                                data.createdAt,
                                                format:
                                                    DateFormat("dd MMM yyyy"),
                                              )} ${AppDateTime.time12hr(
                                                timeOfDay:
                                                    TimeOfDay.fromDateTime(
                                                        DateTime.parse(
                                                            data.createdAt!)),
                                              )}",
                                        color: AppColor.appColor,
                                        textSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (_, __) => const Divider(
                            color: AppColor.white,
                            height: 1,
                          ),
                          itemCount: (_myProductController.purchaseShareDetails
                                      .value?.sharePurchases ??
                                  [])
                              .length,
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget infoTile(
      {required String level,
      Color? levelColor,
      required String value,
      Color? valueColor,
      bool alignEnd = false}) {
    return Expanded(
      flex: 1,
      child: Wrap(
        alignment: alignEnd ? WrapAlignment.end : WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          AppText(
            text: level,
            textSize: 12,
            color: levelColor,
          ),
          AppText(
            text: value,
            textSize: 14,
            color: valueColor,
          ),
        ],
      ),
    );
  }

  _viewShareAndBuy() {
    // Share Product
    Map<String, dynamic> data = {"from": 0};
    if (HomeCatProductController().initialized) {
      Get.find<HomeCatProductController>().emitShareProductDetails(
          (_myProductController.purchaseShareDetails.value?.id ?? '')
              .toString());
    } else {
      Get.put(HomeCatProductController()).emitShareProductDetails(
          (_myProductController.purchaseShareDetails.value?.id ?? '')
              .toString());
    }
    Get.toNamed(Routes.publicShareProductDetails, arguments: data);
  }
}
