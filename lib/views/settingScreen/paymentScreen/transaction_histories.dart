import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/settings/transaction_controller.dart';
import 'package:oninto_flutter/model/transaction_model.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/utils/appbar.dart';
import 'package:oninto_flutter/utils/image_view.dart';

import '../../../utils/app_text.dart';
import '../../../utils/color_constant.dart';

class TransactionHistories extends StatelessWidget {
  TransactionHistories({super.key});
  final TransactionsController _trackingScrollController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppbarWidget(),
      body: RefreshIndicator(
        onRefresh: () async {
          await _trackingScrollController.getTransactions();
        },
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Column(
              children: [
                Obx(
                  () => ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      TransactionModel data =
                          _trackingScrollController.transactionList[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: AppImage.view(
                                  "${ImageBaseUrls.product}${data.product?.productImages ?? ''}",
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    text: data.product?.name ?? '',
                                    textSize: 16.0,
                                    style: AppTextStyle.regular,
                                  ),
                                  const SizedBox(height: 1.0),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on, size: 15.0),
                                      const SizedBox(width: 5.0),
                                      Expanded(
                                        child: AppText(
                                          text:
                                              data.shippingAddress?.location ??
                                                  '',
                                          textSize: 10.0,
                                          style: AppTextStyle.regular,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 3.0,
                                  ),
                                  const AppText(
                                    text: "June 19, 2022 | 9:15AM",
                                    textSize: 10.0,
                                    style: AppTextStyle.small,
                                  ),
                                  const SizedBox(
                                    height: 11.0,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 6.0),
                                    decoration: BoxDecoration(
                                      color: AppColor.blackColor,
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: const Center(
                                      child: AppText(
                                        text: "\$5000",
                                        textSize: 10.0,
                                        style: AppTextStyle.small,
                                        color: AppColor.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemCount: _trackingScrollController.transactionList.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
