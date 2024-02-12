import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home/home_controller.dart';
import 'package:oninto_flutter/common_controller/product/my_product_controller.dart';
import 'package:oninto_flutter/model/product/product_model.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/utils/common_widgets.dart';
import 'package:oninto_flutter/utils/empty_widget.dart';
import 'package:oninto_flutter/utils/image_view.dart';
import 'package:oninto_flutter/utils/shimmer_widget.dart';

import '../../../model/product/my_purchase_share_model.dart';
import '../../../utils/appbar.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({
    super.key,
  });
  final MyProductController _myProductController = Get.find();

  @override
  Widget build(BuildContext context) {
    if (Get.arguments != null) {
      _myProductController.tabController.value = Get.arguments['from'];
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(
        onBackPress: () {
          Get.back();
          Get.back();
        },
        heading: "My Products",
        textStyle: const TextStyle(
            fontSize: 20,
            color: AppColor.blackColor,
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
              border: Border.all(color: AppColor.appColor),
            ),
            child:
                const Icon(Icons.filter_alt_rounded, color: AppColor.appColor),
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
                _myProductController.getMyProducts(sold: true, filter: true);

                Get.toNamed(Routes.myProductFilterScreen,
                    arguments: {'filter_type': 'sold'});
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
                _myProductController.getMyProducts(
                    newAdded: true, filter: true);
                Get.toNamed(Routes.myProductFilterScreen,
                    arguments: {'filter_type': 'new_added'});
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
                _myProductController.getMyProducts(pending: true, filter: true);
                Get.toNamed(Routes.myProductFilterScreen,
                    arguments: {'filter_type': 'pending'});
              },
            ),
          ],
        ),
      ),
      body: Obx(
        () => DefaultTabController(
          length: 5,
          initialIndex: _myProductController.tabController.value,
          child: Column(
            children: [
              TabBar(
                labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                indicatorPadding: EdgeInsets.zero,
                dividerHeight: 0,
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  return states.contains(MaterialState.focused)
                      ? null
                      : Colors.transparent;
                }),
                onTap: (index) async {
                  _myProductController.tabController.value = index;
                  if (index == 1) {
                    await _myProductController.getAllMyPurchaseShares();
                  } else {
                    await _myProductController.getMyProducts();
                  }
                },
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                indicator:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                indicatorWeight: 1,
                tabs: List.generate(tabs.length, (index) => tabs[index]),
                isScrollable: true,
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    /// Tab 0 ======================Buy Products===================
                    tabBody0(),

                    /// Tab 1 ======================Buy Shares===================
                    tabBody1(),

                    /// Tab 2 ===========================Sell Products=============================
                    tabBody2(),

                    /// Tab 3
                    tabBody3(),

                    /// Tab 4
                    tabBody4(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  RefreshIndicator tabBody4() {
    return RefreshIndicator(
      onRefresh: () async {
        await _myProductController.getMyProducts();
      },
      child: _myProductController.loadingData.value
          ? ShimmerWidgets.productGridView()
          : _myProductController.myPhysicalProducts.isEmpty
              ? EmptyWidgets.simple(refresh: () async {
                  await _myProductController.getMyProducts();
                })
              : GridView.builder(
                  physics: const ClampingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.74,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 30),
                  itemCount: _myProductController.myPhysicalProducts.length,
                  itemBuilder: (context, index) {
                    //  var data = controller.Categorydata[index];
                    var product =
                        _myProductController.myPhysicalProducts[index];
                    return CommonWidgets.productGridCard(
                      productImage:
                          ((product as ProductModel).productImages ?? [])
                                  .isNotEmpty
                              ? (product).productImages!.first.image ?? ''
                              : '',
                      lastUpdate: (product).updatedAt ?? '',
                      price: double.parse((product).price ?? '0.0'),
                      title: (product).name ?? '',
                      isSold: (product).isSold ?? false,
                      onClick: () {
                        if (product.id != null) {
                          // if (product.startDate != null &&
                          //     product.bidTime != '') {
                          //   DateTime temp = DateTime.parse(
                          //       '${product.startDate!}T${product.bidTime!}');
                          //   print(
                          //       "d--> ${DateTime.parse('2024-02-05 18:50:00.000').difference(temp).inHours} ---> $temp");
                          // }
                          _myProductController.getProductDetails(
                              ((product).id ?? '').toString());
                          Get.toNamed(Routes.myPhysicalProductDetailScreen);
                        }
                      },
                    );
                  }),
    );
  }

  RefreshIndicator tabBody3() {
    return RefreshIndicator(
      onRefresh: () async {
        await _myProductController.getMyProducts();
      },
      child: _myProductController.loadingData.value
          ? ShimmerWidgets.productGridView()
          : _myProductController.myCoOwnerProducts.isEmpty
              ? EmptyWidgets.simple()
              : GridView.builder(
                  physics: const ClampingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.74,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 30),
                  itemCount: _myProductController.myCoOwnerProducts.length,
                  itemBuilder: (context, index) {
                    //  var data = controller.Categorydata[index];
                    var product = _myProductController.myCoOwnerProducts[index];
                    return CommonWidgets.productGridCard(
                      productImage:
                          ((product as ProductModel).productImages ?? [])
                                  .isNotEmpty
                              ? product.productImages!.first.image ?? ''
                              : '',
                      lastUpdate: product.updatedAt ?? '',
                      price: double.parse(product.price ?? '0.0'),
                      title: product.name ?? '',
                      isSold: product.isSold ?? false,
                      onClick: () {
                        if (product.id != null) {
                          // Share Product
                          Map<String, dynamic> data = {"from": 0};
                          if (HomeCatProductController().initialized) {
                            Get.find<HomeCatProductController>()
                                .emitShareProductDetails(
                                    (product.id ?? '').toString());
                          } else {
                            Get.put(HomeCatProductController())
                                .emitShareProductDetails(
                                    (product.id ?? '').toString());
                          }
                          Get.toNamed(Routes.publicShareProductDetails,
                              arguments: data);
                        }
                      },
                    );
                  }),
    );
  }

  RefreshIndicator tabBody2() {
    return RefreshIndicator(
      onRefresh: () async {
        await _myProductController.getMyProducts();
      },
      child: _myProductController.loadingData.value
          ? ShimmerWidgets.productGridView()
          : _myProductController.mySellProducts.isEmpty
              ? EmptyWidgets.simple()
              : GridView.builder(
                  physics: const ClampingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.74,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 30),
                  itemCount: _myProductController.mySellProducts.length,
                  itemBuilder: (context, index) {
                    //  var data = controller.Categorydata[index];
                    BuyProductModel product = _myProductController
                        .mySellProducts[index] as BuyProductModel;
                    return CommonWidgets.productGridCard(
                      productImage: (product.product?.productImages ?? [])
                              .isNotEmpty
                          ? product.product?.productImages!.first.image ?? ''
                          : '',
                      lastUpdate: (product).updatedAt ?? '',
                      price: double.parse(product.product?.price ?? '0.0'),
                      title: product.product?.name ?? '',
                      views: 1200,
                      likes: 15200,
                      onClick: () {
                        if (product.product?.id != null) {
                          _myProductController.getProductDetails(
                              (product.product?.id ?? '').toString());
                          Get.toNamed(Routes.myPhysicalProductDetailScreen);
                        }
                      },
                    );
                  }),
    );
  }

  RefreshIndicator tabBody1() {
    return RefreshIndicator(
        onRefresh: () async {
          await _myProductController.getMyProducts();
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Obx(
                () => Row(
                  children: [
                    subTab(
                      title: "Active Shares",
                      onClick: () {
                        _myProductController.activeShareTab.value = true;
                      },
                      active: _myProductController.activeShareTab.value,
                    ),
                    const SizedBox(width: 14),
                    subTab(
                      title: "Sold Shares",
                      onClick: () {
                        _myProductController.activeShareTab.value = false;
                      },
                      active: !_myProductController.activeShareTab.value,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _myProductController.activeShareTab.value
                  ? _myProductController.myActivePurchaseShares.isEmpty
                      ? EmptyWidgets.noproducts(message: "No Active Shares")
                      : ListView.separated(
                          physics: const ClampingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemBuilder: (context, index) {
                            MyShare data = _myProductController
                                .myActivePurchaseShares[index];
                            return shareTile(data, onClick: () async {
                              await _myProductController
                                  .getPurchaseShareDetails(
                                      (data.shareId ?? '').toString());
                              Get.toNamed(Routes.myPurchaseShareDetails);
                            });
                          },
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 20),
                          itemCount: _myProductController
                              .myActivePurchaseShares.length,
                        )
                  : _myProductController.myUnActivePurchaseShares.isEmpty
                      ? EmptyWidgets.noproducts(message: "No Sold Shares")
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
                              Get.toNamed(Routes.myPurchaseShareDetails);
                            });
                          },
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 20),
                          itemCount: _myProductController
                              .myUnActivePurchaseShares.length,
                        ),
            ),
          ],
        ));
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
                      text: "Shares: ${data.totalInvestment ?? '0'}",
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

  Widget subTab(
      {required String title, required Function onClick, bool active = false}) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            AppText(
              text: title,
              textSize: 14,
              color: active ? AppColor.appColor : AppColor.grey,
            ),
            const SizedBox(height: 3),
            Container(
              width: 100,
              height: 2,
              color: active ? AppColor.appColor : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }

  RefreshIndicator tabBody0() {
    return RefreshIndicator(
      onRefresh: () async {
        await _myProductController.getMyProducts();
      },
      child: _myProductController.loadingData.value
          ? ShimmerWidgets.productGridView()
          : _myProductController.myBuyProducts.isEmpty
              ? EmptyWidgets.simple()
              : GridView.builder(
                  physics: const ClampingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.74,
                      mainAxisSpacing: 30,
                      crossAxisSpacing: 30),
                  itemCount: _myProductController.myBuyProducts.length,
                  itemBuilder: (context, index) {
                    //  var data = controller.Categorydata[index];
                    BuyProductModel product = _myProductController
                        .myBuyProducts[index] as BuyProductModel;
                    return CommonWidgets.productGridCard(
                      productImage: (product.product?.productImages ?? [])
                              .isNotEmpty
                          ? product.product?.productImages!.first.image ?? ''
                          : '',
                      lastUpdate: (product).updatedAt ?? '',
                      price: double.parse(product.product?.price ?? '0.0'),
                      title: product.product?.name ?? '',
                      onClick: () {
                        if (product.product?.id != null) {
                          _myProductController.getProductDetails(
                              (product.product?.id ?? '').toString());
                          Get.toNamed(Routes.myPhysicalProductDetailScreen);
                        }
                      },
                    );
                  }),
    );
  }

  List<Widget> get tabs => [
        tabbutton("Buy",
            selected: _myProductController.tabController.value == 0,
            margin: const EdgeInsets.only(left: 0, top: 10)),
        tabbutton("Buy Share",
            selected: _myProductController.tabController.value == 1,
            margin: const EdgeInsets.only(left: 0, top: 10)),
        tabbutton("Sell",
            selected: _myProductController.tabController.value == 2),
        tabbutton("Co-owner",
            selected: _myProductController.tabController.value == 3),
        tabbutton("Physical",
            selected: _myProductController.tabController.value == 4),
      ];

  Widget tabbutton(String title,
      {bool selected = false, EdgeInsetsGeometry? margin}) {
    return Container(
      height: 40,
      width: 100,
      margin: margin ?? const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: selected ? AppColor.appColor : Colors.white,
          border: Border.all(
            color: selected ? AppColor.appColor : Colors.grey.shade300,
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
