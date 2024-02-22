import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oninto_flutter/common_controller/settings/transaction_controller.dart';
import 'package:oninto_flutter/model/transaction_model.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/utils/appbar.dart';
import 'package:oninto_flutter/utils/date_time_formates.dart';
import 'package:oninto_flutter/utils/empty_widget.dart';
import 'package:oninto_flutter/utils/image_view.dart';
import 'package:oninto_flutter/utils/shimmer_widget.dart';

import '../../../model/product/product_image_model.dart';
import '../../../utils/app_text.dart';
import '../../../utils/color_constant.dart';

class TransactionHistories extends StatelessWidget {
  TransactionHistories({super.key});
  final TransactionsController _trackingScrollController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppbarWidget(heading: "Transactions"),
      body: RefreshIndicator(
        onRefresh: () async {
          await _trackingScrollController.getTransactions();
        },
        child: Obx(
          () => _trackingScrollController.loadingData.value
              ? ShimmerWidgets.listView(shdow: false)
              : _trackingScrollController.transactionList.isEmpty
                  ? EmptyWidgets.simple()
                  : SingleChildScrollView(
                      physics: const ClampingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Column(
                          children: [
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                TransactionModel data =
                                    _trackingScrollController
                                        .transactionList[index];
                                ProductImages? productImage;
                                if ((data.product?.productImages ?? [])
                                    .isNotEmpty) {
                                  productImage =
                                      (data.product?.productImages ?? []).first;
                                }
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: AppImage.view(
                                            "${ImageBaseUrls.product}${productImage?.image ?? ''}",
                                            height: 85,
                                            width: 80,
                                            fit: BoxFit.cover),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppText(
                                              text: data.product?.name ?? '',
                                              textSize: 14.0,
                                              style: AppTextStyle.regular,
                                            ),
                                            const SizedBox(height: 8.0),
                                            data.shippingAddress?.location ==
                                                    null
                                                ? const SizedBox.shrink()
                                                : Row(
                                                    children: [
                                                      const Icon(
                                                          Icons.location_on,
                                                          size: 15.0,
                                                          color: AppColor.grey),
                                                      const SizedBox(
                                                          width: 5.0),
                                                      Expanded(
                                                        child: AppText(
                                                          text: data
                                                                  .shippingAddress
                                                                  ?.location ??
                                                              '',
                                                          textSize: 10.0,
                                                          style: AppTextStyle
                                                              .regular,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                            const SizedBox(height: 3.0),
                                            AppText(
                                              text:
                                                  "${AppDateTime.getDateTime(data.createdAt, format: DateFormat("MMM dd, yyyy | hh:mm a"))}",
                                              textSize: 10.0,
                                              style: AppTextStyle.small,
                                            ),
                                            const SizedBox(height: 11.0),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 6.0),
                                                  decoration: BoxDecoration(
                                                    color: AppColor.themeColor
                                                        .withOpacity(1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                  ),
                                                  child: Center(
                                                    child: AppText(
                                                      text:
                                                          "\$${(data.amount ?? 0.0).toStringAsFixed(1)}",
                                                      textSize: 14.0,
                                                      style: AppTextStyle.small,
                                                      color: AppColor.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 14),
                              itemCount: _trackingScrollController
                                  .transactionList.length,
                            ),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
