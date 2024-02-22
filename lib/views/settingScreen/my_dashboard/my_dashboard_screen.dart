import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/settings/my_dashboard_controller.dart';
import 'package:oninto_flutter/service/local/user_info_global.dart';
import 'package:oninto_flutter/utils/app_text.dart';

import '../../../common_controller/product/my_product_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/appbar.dart';
import '../../../utils/color_constant.dart';

class MyDashboard extends StatelessWidget {
  MyDashboard({super.key});

  final MyDashboardController _controller = Get.find<MyDashboardController>();
  final MyProductController _myProductController =
      Get.find<MyProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const CommonAppbarWidget(
        heading: "My Dashboard",
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
                  await _controller.getDashboardInfo();
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 14),

                      // User Info
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: const TextSpan(text: "Hello, "),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Hello, ',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColor.appColor,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        '${UserStoredInfo().userInfo?.firstName ?? ''} ${UserStoredInfo().userInfo?.lastName ?? ''}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.blackColor),
                                  ),
                                  const TextSpan(
                                    text: '!',
                                    style:
                                        TextStyle(color: AppColor.blackColor),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),

                      // Total Profits
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppText(
                              text: "Profits",
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 14),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       flex: 1,
                            //       child: productDBCard(
                            //         title: "Bid",
                            //         profiteAmount: 1230.2,
                            //         theme: Colors.blue,
                            //       ),
                            //     ),
                            //     const SizedBox(width: 14),
                            //     Expanded(
                            //       flex: 1,
                            //       child: productDBCard(
                            //         title: "Fixed",
                            //         profiteAmount: 1230.2,
                            //         theme: Colors.orange,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            // const SizedBox(height: 14),
                            productDBCard(
                              title: "Shares",
                              profiteAmount: _controller.totalSharProfies.value,
                              theme: Colors.green,
                            ),
                          ],
                        ),
                      ),

                      // Total Profits
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppText(
                              text: "Quick Analysis (Buy)",
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 14),
                            mycard(
                              onClick: () {
                                _myProductController.getAllMyPurchaseShares();
                                Get.toNamed(Routes.purchaseShareDetails);
                              },
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(
                                    text: "Share",
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(height: 8),
                                  analysisTile(
                                    title: "Qunatity",
                                    value:
                                        "${(_controller.dashboardInfo.value?.sharePurchaseCount ?? []).length} products",
                                    valueColor: AppColor.blackColor,
                                  ),
                                  const SizedBox(height: 8),
                                  analysisTile(
                                    title: "Invested",
                                    value:
                                        "\$${_controller.buySharesAmount.value}",
                                    valueColor: AppColor.red,
                                  ),
                                  const SizedBox(height: 8),
                                  analysisTile(
                                    title: "Profits",
                                    value:
                                        "\$${_controller.totalSharProfies.value}",
                                    valueColor: AppColor.green,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 14),
                            mycard(
                              onClick: () {
                                //
                              },
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(
                                    text: "Bid",
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(height: 8),
                                  analysisTile(
                                    title: "Qunatity",
                                    value:
                                        "${(_controller.dashboardInfo.value?.bidProductCount ?? []).length} products",
                                    valueColor: AppColor.blackColor,
                                  ),
                                  const SizedBox(height: 8),
                                  analysisTile(
                                    title: "Amount",
                                    value:
                                        "\$${_controller.buyBidAmount.value}",
                                    valueColor: AppColor.red,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 14),
                            mycard(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(
                                    text: "Fixed",
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(height: 8),
                                  analysisTile(
                                    title: "Qunatity",
                                    value:
                                        "${(_controller.dashboardInfo.value?.fixedProductCount ?? []).length} products",
                                    valueColor: AppColor.blackColor,
                                  ),
                                  const SizedBox(height: 8),
                                  analysisTile(
                                    title: "Amount",
                                    value:
                                        "\$${_controller.buyFixedAmount.value}",
                                    valueColor: AppColor.red,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Total Profits
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AppText(
                              text: "Quick Analysis (Sell)",
                              fontWeight: FontWeight.w600,
                            ),
                            const SizedBox(height: 14),
                            mycard(
                              onClick: () {
                                _myProductController.tabController.value = 2;
                                _myProductController.getMyProducts();
                                Get.toNamed(Routes.productScreen);
                              },
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(
                                    text: "Share",
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(height: 8),
                                  analysisTile(
                                    title: "Total",
                                    value:
                                        "${_controller.dashboardInfo.value?.sellershareSold?.totalShare ?? 0} products",
                                  ),
                                  const SizedBox(height: 8),
                                  analysisTile(
                                    title: "Sold",
                                    value:
                                        "${_controller.dashboardInfo.value?.sellershareSold?.totalShareSold ?? 0} products",
                                    valueColor: AppColor.green,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 14),
                            mycard(
                              onClick: () {
                                _myProductController.tabController.value = 4;
                                _myProductController.getMyProducts();
                                Get.toNamed(Routes.productScreen);
                              },
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(
                                    text: "Bid",
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(height: 8),
                                  analysisTile(
                                    title: "Total",
                                    value:
                                        "${_controller.dashboardInfo.value?.bidProductSellCount?.totalbidProduct ?? 0} products",
                                  ),
                                  const SizedBox(height: 8),
                                  analysisTile(
                                    title: "Sold",
                                    value:
                                        "${_controller.dashboardInfo.value?.bidProductSellCount?.bidProductSellCount ?? 0} products",
                                    valueColor: AppColor.green,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 14),
                            mycard(
                              onClick: () {
                                _myProductController.tabController.value = 4;
                                _myProductController.getMyProducts();
                                Get.toNamed(Routes.productScreen);
                              },
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(
                                    text: "Fixed",
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SizedBox(height: 8),
                                  analysisTile(
                                    title: "Total",
                                    value:
                                        "${_controller.dashboardInfo.value?.fixedProductSellCount?.totalfixed ?? 0} products",
                                  ),
                                  const SizedBox(height: 8),
                                  analysisTile(
                                    title: "Sold",
                                    value:
                                        "${_controller.dashboardInfo.value?.fixedProductSellCount?.fixedProductSellCount ?? 0} products",
                                    valueColor: AppColor.green,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //
                      const SizedBox(height: 30),
                    ],
                  ),
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
}
