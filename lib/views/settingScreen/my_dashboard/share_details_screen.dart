import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/settings/my_dashboard_controller.dart';
import 'package:oninto_flutter/utils/app_text.dart';

import '../../../common_controller/product/my_product_controller.dart';
import '../../../model/product/my_purchase_share_model.dart';
import '../../../routes/routes.dart';
import '../../../service/apis.dart';
import '../../../utils/appbar.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/common_button.dart';
import '../../../utils/empty_widget.dart';
import '../../../utils/image_view.dart';

class PurchaseShareDetailsScreen extends StatelessWidget {
  PurchaseShareDetailsScreen({super.key});

  final MyDashboardController _controller = Get.find<MyDashboardController>();
  final MyProductController _myProductController =
      Get.find<MyProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const CommonAppbarWidget(
        heading: "My Shares",
        textStyle: TextStyle(
            fontSize: 20,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: Obx(
        () => _controller.loadingData.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  await _myProductController.getMyProducts();
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Obx(
                        () => Row(
                          children: [
                            AppButton.tabText(
                              title: "Active Shares",
                              onClick: () {
                                _myProductController.activeShareTab.value =
                                    true;
                              },
                              active: _myProductController.activeShareTab.value,
                            ),
                            const SizedBox(width: 14),
                            AppButton.tabText(
                              title: "Sold Shares",
                              onClick: () {
                                _myProductController.activeShareTab.value =
                                    false;
                              },
                              active:
                                  !_myProductController.activeShareTab.value,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: _myProductController.activeShareTab.value
                          ? _myProductController.myActivePurchaseShares.isEmpty
                              ? EmptyWidgets.noproducts(
                                  message: "No Active Shares")
                              : ListView.separated(
                                  physics: const ClampingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  itemBuilder: (context, index) {
                                    MyShare data = _myProductController
                                        .myActivePurchaseShares[index];
                                    return shareTile(data, onClick: () {
                                      _myProductController
                                          .getPurchaseShareDetails(
                                              (data.shareId ?? '').toString());
                                      Get.toNamed(
                                          Routes.myPurchaseShareDetails);
                                    });
                                  },
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 20),
                                  itemCount: _myProductController
                                      .myActivePurchaseShares.length,
                                )
                          : _myProductController
                                  .myUnActivePurchaseShares.isEmpty
                              ? EmptyWidgets.noproducts(
                                  message: "No Sold Shares")
                              : ListView.separated(
                                  physics: const ClampingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  itemBuilder: (context, index) {
                                    MyShare data = _myProductController
                                        .myUnActivePurchaseShares[index];
                                    return shareTile(data, onClick: () async {
                                      await _myProductController
                                          .getPurchaseShareDetails(
                                              (data.shareId ?? '').toString());
                                      Get.toNamed(
                                          Routes.myPurchaseShareDetails);
                                    });
                                  },
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 20),
                                  itemCount: _myProductController
                                      .myUnActivePurchaseShares.length,
                                ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget mycard(Widget child, {Function? onClick}) {
    return GestureDetector(
      onTap: onClick == null ? () {} : () => onClick(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColor.grey.withOpacity(0.5),
              blurRadius: 20,
            ),
          ],
        ),
        child: child,
      ),
    );
  }

  Widget analysisTile(
      {required String title, required String value, Color? valueColor}) {
    return Row(
      children: [
        AppText(
          text: title,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.topRight,
            child: AppText(
              text: value,
              fontWeight: FontWeight.w600,
              color: valueColor ?? AppColor.blackColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget productDBCard(
      {required String title, Color? theme, required double profiteAmount}) {
    return Container(
      width: double.infinity,
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(
        //   color: AppColor.appColor,
        // ),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey.withOpacity(0.5),
            blurRadius: 20,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            text: title,
            textAlign: TextAlign.center,
            maxlines: 2,
          ),
          const SizedBox(height: 8),
          AppText(
            text: "\$$profiteAmount",
            textSize: 20,
            color: profiteAmount < 0 ? AppColor.red : AppColor.green,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
            maxlines: 3,
          ),
        ],
      ),
    );
  }

  Widget shareTile(MyShare data, {required Function onClick}) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: AppImage.view(
                    "${ImageBaseUrls.product}${data.productImage ?? ''}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: data.share?.name ?? '',
                      textSize: 14.0,
                      style: AppTextStyle.regular,
                    ),
                    const SizedBox(height: 10.0),
                    AppText(
                      text: "Total Invest: \$${data.totalInvestment ?? '0'}",
                      textSize: 14.0,
                      style: AppTextStyle.regular,
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
