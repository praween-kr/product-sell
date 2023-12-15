import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home/home_controller.dart';
import 'package:oninto_flutter/common_controller/product/my_product_controller.dart';
import 'package:oninto_flutter/utils/appbar.dart';
import 'package:oninto_flutter/model/product/product_model.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/utils/app_print.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/empty_widget.dart';
import 'package:oninto_flutter/utils/favourite_button.dart';
import 'package:oninto_flutter/utils/image_view.dart';
import 'package:oninto_flutter/utils/shimmer_widget.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});

  final MyProductController _myProductController = Get.find();
  final HomeCatProductController _homecontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    AppPrint.all("products: ${_homecontroller.products.length}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(heading: "Filter"),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => RefreshIndicator(
                onRefresh: () async {
                  if (Get.arguments != null &&
                      Get.arguments['from'] == 'home') {
                    _homecontroller.localFavourites.clear();
                    await _homecontroller.filterProducts();
                  }
                },
                child: (Get.arguments != null && Get.arguments['from'] == 'home'
                        ? _homecontroller.filtering.value
                        : _myProductController.loadingdata.value)
                    ? ShimmerWidgets.productListView()
                    : (Get.arguments != null && Get.arguments['from'] == 'home'
                            ? _homecontroller.products.isEmpty
                            : _myProductController.myProducts.isEmpty)
                        ? EmptyWidgets.simple()
                        : ListView.builder(
                            physics: const ClampingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: (Get.arguments != null &&
                                    Get.arguments['from'] == 'home'
                                ? _homecontroller.products.length
                                : _myProductController.myProducts.length),
                            itemBuilder: (BuildContext context, int index) {
                              var product = Get.arguments != null &&
                                      Get.arguments['from'] == 'home'
                                  ? _homecontroller.products[index]
                                  : _myProductController.myProducts[index];
                              String img = (product.productImages ?? []).isEmpty
                                  ? ''
                                  : product.productImages!.first.image ?? '';
                              return Obx(
                                () => filterCard(
                                  product,
                                  img,
                                  onClick: () => _navigate(product),
                                  isFavourite: _homecontroller.localFavourites[
                                              (product.id ?? '').toString()] !=
                                          null
                                      ? _homecontroller.localFavourites[
                                              (product.id ?? '').toString()] ??
                                          false
                                      : product.isFavourite == 1,
                                  clickOnFav: () {
                                    _homecontroller.addProductAsFavourite(
                                        (product.id ?? '').toString());
                                  },
                                ),
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
      Get.toNamed(Routes.coOwnerProductDetailsScreen);
    } else {
      if (Get.arguments != null && Get.arguments['from'] == 'my_product') {
        AppPrint.info("Navigate: 2");
        // Edit & View My Product
        _myProductController.getProductDetails((product.id ?? '').toString());
        Get.toNamed(Routes.myPhysicalProductDetailScreen);
      } else {
        AppPrint.info("Navigate: 3");
        Map<String, dynamic> data = {"from": 0};
        _homecontroller.getProductDetails((product.id ?? '').toString());
        Get.toNamed(Routes.productDetailsScreen, arguments: data);
      }
    }
  }
}
