import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/product/product_controller.dart';
import 'package:oninto_flutter/common_widget/app_text.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utills/colors_file.dart';
import 'package:oninto_flutter/utills/common_widgets.dart';
import 'package:oninto_flutter/utills/shimmer_widget.dart';

import '../../../common_widget/appbar.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({
    Key? key,
  }) : super(key: key);
  final ProductController _productController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      _productController.tabController.value = Get.arguments;
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(
        leading: GestureDetector(
          onTap: () {
            Get.back();
            Get.back();
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.only(left: 12),
            decoration: BoxDecoration(
                color: AppColor.appcolor,
                borderRadius: BorderRadius.circular(15)),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        heading: "My Products",
        textStyle: const TextStyle(
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
        action: PopupMenuButton(
          tooltip: "",
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(22))),
          offset: const Offset(0, 20),
          icon: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.appcolor),
            ),
            child:
                const Icon(Icons.filter_alt_rounded, color: AppColor.appcolor),
          ),
          onSelected: (value) {
            value();
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              // padding: EdgeInsets.zero,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: AppText(
                      text: "Sort by",
                      textAlign: TextAlign.center,
                      textSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  Divider(thickness: 1),
                ],
              ),
              value: () {
                // Get.toNamed(Routes.filterScreen);
              },
            ),
            PopupMenuItem(
              // padding: EdgeInsets.zero,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: AppText(
                  text: "Sold",
                  textAlign: TextAlign.center,
                  textSize: 12,
                  color: Colors.black,
                ),
              ),

              value: () {
                _productController.getMyProducts(sold: true, filter: true);
                Get.toNamed(Routes.filterScreen);
              },
            ),
            PopupMenuItem(
              //padding: EdgeInsets.zero,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: AppText(
                  text: "New Added",
                  textAlign: TextAlign.center,
                  textSize: 12,
                  color: Colors.black,
                ),
              ),
              value: () {
                _productController.getMyProducts(newAdded: true, filter: true);
                Get.toNamed(Routes.filterScreen);
              },
            ),
            PopupMenuItem(
              // padding: EdgeInsets.zero,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: AppText(
                  text: "Pending",
                  textAlign: TextAlign.center,
                  textSize: 12,
                  color: Colors.black,
                ),
              ),
              value: () {
                _productController.getMyProducts(pending: true, filter: true);
                Get.toNamed(Routes.filterScreen);
              },
            ),
          ],
        ),
      ),
      body: Obx(
        () => DefaultTabController(
          length: 3,
          initialIndex: _productController.tabController.value,
          child: Column(
            children: [
              TabBar(
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  return states.contains(MaterialState.focused)
                      ? null
                      : Colors.transparent;
                }),
                onTap: (index) async {
                  _productController.tabController.value = index;
                  await _productController.getMyProducts();
                },
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                indicator:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                indicatorWeight: 1,
                tabs: [
                  tabbutton("Buy",
                      selected: _productController.tabController.value == 0),
                  tabbutton("Sell",
                      selected: _productController.tabController.value == 1),
                  tabbutton("Co-owner",
                      selected: _productController.tabController.value == 2),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _productController.loadingdata.value
                        ? ShimmerWidgets.productGridView()
                        : _productController.myBuyProducts.isEmpty
                            ? const Center(
                                child: Text("No data"),
                              )
                            : GridView.builder(
                                physics: const ClampingScrollPhysics(),
                                padding: const EdgeInsets.only(
                                    top: 20, left: 20, right: 20),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.74,
                                        mainAxisSpacing: 30,
                                        crossAxisSpacing: 30),
                                itemCount:
                                    _productController.myBuyProducts.length,
                                itemBuilder: (context, index) {
                                  //  var data = controller.Categorydata[index];
                                  var product =
                                      _productController.myBuyProducts[index];
                                  return CommonWidgets.productGridCard(
                                    productImage: (product.productImages ?? [])
                                            .isNotEmpty
                                        ? product.productImages!.first.image ??
                                            ''
                                        : '',
                                    lastUpdate: product.updatedAt ?? '',
                                    price: double.parse(product.price ?? '0.0'),
                                    title: product.name ?? '',
                                    onClick: () {
                                      _productController.getProductDetails(
                                          (product.id ?? '').toString());
                                      Get.toNamed(
                                          Routes.coOwnerProductDetailsScreen);
                                    },
                                  );
                                }),
                    _productController.loadingdata.value
                        ? ShimmerWidgets.productGridView()
                        : _productController.mySellProducts.isEmpty
                            ? const Center(
                                child: Text("No data"),
                              )
                            : GridView.builder(
                                physics: const ClampingScrollPhysics(),
                                padding: const EdgeInsets.only(
                                    top: 20, left: 20, right: 20),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.74,
                                        mainAxisSpacing: 30,
                                        crossAxisSpacing: 30),
                                itemCount:
                                    _productController.mySellProducts.length,
                                itemBuilder: (context, index) {
                                  //  var data = controller.Categorydata[index];
                                  var product =
                                      _productController.mySellProducts[index];
                                  return CommonWidgets.productGridCard(
                                    productImage: (product.productImages ?? [])
                                            .isNotEmpty
                                        ? product.productImages!.first.image ??
                                            ''
                                        : '',
                                    lastUpdate: product.updatedAt ?? '',
                                    price: double.parse(product.price ?? '0.0'),
                                    title: product.name ?? '',
                                    views: 1200,
                                    likes: 15200,
                                    onClick: () {
                                      _productController.getProductDetails(
                                          (product.id ?? '').toString());
                                      Get.toNamed(
                                          Routes.coOwnerProductDetailsScreen);
                                    },
                                  );
                                }),
                    _productController.loadingdata.value
                        ? ShimmerWidgets.productGridView()
                        : _productController.myCoWonerProducts.isEmpty
                            ? const Center(
                                child: Text("No data"),
                              )
                            : GridView.builder(
                                physics: const ClampingScrollPhysics(),
                                padding: const EdgeInsets.only(
                                    top: 20, left: 20, right: 20),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.74,
                                        mainAxisSpacing: 30,
                                        crossAxisSpacing: 30),
                                itemCount:
                                    _productController.myCoWonerProducts.length,
                                itemBuilder: (context, index) {
                                  //  var data = controller.Categorydata[index];
                                  var product = _productController
                                      .myCoWonerProducts[index];
                                  return CommonWidgets.productGridCard(
                                    productImage: (product.productImages ?? [])
                                            .isNotEmpty
                                        ? product.productImages!.first.image ??
                                            ''
                                        : '',
                                    lastUpdate: product.updatedAt ?? '',
                                    price: double.parse(product.price ?? '0.0'),
                                    title: product.name ?? '',
                                    soldOn: product.createdAt ?? '',
                                    onClick: () {
                                      _productController.getProductDetails(
                                          (product.id ?? '').toString());
                                      Get.toNamed(
                                          Routes.coOwnerProductDetailsScreen);
                                    },
                                  );
                                }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget tabbutton(String title, {bool selected = false}) {
    return Container(
      height: 40,
      width: 100,
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: selected ? AppColor.appcolor : Colors.white,
          border: Border.all(
            color: selected ? AppColor.appcolor : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: AppText(
          text: title,
          textSize: 15,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
          color: selected ? Colors.white : Colors.grey.shade500,
        ),
      ),
    );
  }
}
