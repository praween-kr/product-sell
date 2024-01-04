import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/product/my_product_controller.dart';
import 'package:oninto_flutter/model/product/product_model.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/utils/app_print.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/appbar.dart';
import 'package:oninto_flutter/utils/empty_widget.dart';
import 'package:oninto_flutter/utils/favourite_button.dart';
import 'package:oninto_flutter/utils/image_view.dart';
import 'package:oninto_flutter/utils/shimmer_widget.dart';

class MyProductFilterScreen extends StatelessWidget {
  MyProductFilterScreen({super.key});

  final MyProductController _myProductController = Get.find();

  @override
  Widget build(BuildContext context) {
    AppPrint.all("products: ${_myProductController.myProducts.length}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppbarWidget(heading: "Filter"),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => RefreshIndicator(
                onRefresh: () async {
                  //
                  if (Get.arguments != null) {
                    if (Get.arguments['filter_type'] == 'sold') {
                      await _myProductController.getMyProducts(
                          sold: true, filter: true);
                    } else if (Get.arguments['filter_type'] == 'new_added') {
                      await _myProductController.getMyProducts(
                          newAdded: true, filter: true);
                    } else if (Get.arguments['filter_type'] == 'pending') {
                      await _myProductController.getMyProducts(
                          pending: true, filter: true);
                    }
                  }
                },
                child: _myProductController.loadingData.value
                    ? ShimmerWidgets.productListView()
                    : _myProductController.myProducts.isEmpty
                        ? EmptyWidgets.simple()
                        : ListView.builder(
                            physics: const ClampingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: _myProductController.myProducts.length,
                            itemBuilder: (BuildContext context, int index) {
                              ProductModel product;
                              if ([0, 1].contains(
                                  _myProductController.tabController.value)) {
                                BuyProductModel temp = (_myProductController
                                    .myProducts[index] as BuyProductModel);
                                product = temp.product ?? ProductModel();
                              } else {
                                product = (_myProductController
                                    .myProducts[index] as ProductModel);
                              }

                              String img = ((product).productImages ?? [])
                                      .isEmpty
                                  ? ''
                                  : product.productImages!.first.image ?? '';
                              return filterCard(
                                product,
                                img,
                                onClick: () => _navigate(product),
                                clickOnFav: () {},
                              );
                            },
                          ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget filterCard(ProductModel product, String img,
      {required Function onClick,
      required Function clickOnFav,
      bool isFavourite = false}) {
    return GestureDetector(
      onTap: () => _navigate(product),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          padding:
              const EdgeInsets.only(bottom: 10, top: 10, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Center(
                  child: AppImage.view("${ImageBaseUrls.product}$img",
                      height: 170, width: double.infinity, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: "\$${product.price ?? 0.0}",
                    textSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  FavouriteButton(
                    onClick: () => clickOnFav(),
                    isFavourite: isFavourite,
                  ),
                ],
              ),
              AppText(
                text: product.name ?? '',
                textSize: 10,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(
                height: 10,
              ),
              const AppText(
                text: "XL/42",
                textSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ],
          )),
    );
  }

  _navigate(ProductModel product) {
    if (product.type == 2) {
      AppPrint.info("Navigate: 1");
      _myProductController.getProductDetails((product.id ?? '').toString());
      Get.toNamed(Routes.myShareProductDetailsScreen);
    } else {
      AppPrint.info("Navigate: 2");
      // Edit & View My Product
      _myProductController.getProductDetails((product.id ?? '').toString());
      Get.toNamed(Routes.myPhysicalProductDetailScreen);
    }
  }
}
