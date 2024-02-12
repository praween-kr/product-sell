import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/appbar.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/utils/date_time_formates.dart';

import '../../../common_controller/product/my_product_controller.dart';
import '../../../model/product/my_purchase_share_details_model.dart';

class MyPurchaseShareDetails extends StatelessWidget {
  MyPurchaseShareDetails({super.key});
  final MyProductController _myProductController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbarWidget(
        headingChild: Obx(
          () => Text(
            _myProductController.purchaseShareDetails.value?.name ?? '',
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: _myProductController.purchaseShareDetails.value?.name ??
                      '',
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Expanded(
                      flex: 1,
                      child: AppText(
                        text: "Total Shares: ${200}",
                        textSize: 12,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AppText(
                        text:
                            "Total Investment: \$${_myProductController.purchaseShareDetails.value?.totalShare ?? 0.0}",
                        textSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 14),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              SharePurchases data = (_myProductController
                      .purchaseShareDetails.value?.sharePurchases ??
                  [])[index];
              return Container(
                color: Colors.grey.shade200,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                            color: AppColor.appColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(5)),
                        child: AppText(
                          text: AppDateTime.getDateTime(
                            data.createdAt,
                            format: DateFormat("dd MMM yyyy"),
                          ),
                          textSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      AppText(
                        text: "Quantity: ${data.totalSharePurchase ?? 0}",
                        textSize: 14,
                      ),
                      const SizedBox(height: 8),
                      AppText(
                        text: "Per Share Price: ${data.perSharePrice ?? '0'}",
                        textSize: 14,
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
            itemCount: (_myProductController
                        .purchaseShareDetails.value?.sharePurchases ??
                    [])
                .length,
          )
        ],
      ),
    );
  }
}
