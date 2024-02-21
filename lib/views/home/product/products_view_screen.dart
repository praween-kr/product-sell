import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common_controller/home/home_controller.dart';
import '../../../utils/app_type_status.dart';
import '../../../utils/appbar.dart';
import '../../../utils/common_widgets.dart';
import '../../../utils/core/core_method.dart';
import '../../../utils/empty_widget.dart';
import '../../../utils/shimmer_widget.dart';
import 'product_details_navigation.dart';

class ProductsView extends StatelessWidget {
  ProductsView({super.key});
  final HomeCatProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppbarWidget(
        heading: "Products",
      ),
      body: Obx(
        () => controller.loadingData.value
            ? ShimmerWidgets.text(w: Get.width * 0.4)
            : controller.products.isEmpty
                ? EmptyWidgets.simple(
                    inCenter: true,
                    refresh: () async {
                      controller.localFavourites.clear();
                      await controller.searchProducts();
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: GridView.builder(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.65,
                                mainAxisSpacing: 30,
                                crossAxisSpacing: 30),
                        itemCount: controller.products.length,
                        itemBuilder: (context, index) {
                          //  var data = controller.Categorydata[index];
                          var product = controller.products[index];
                          return Obx(
                            () => CommonWidgets.productGridCard2(
                              isShareType: product.type == TypeOfProduct.share,
                              productSize: AppCore.productSizeText(
                                  List<String>.generate(
                                      (product.productSizes ?? []).length,
                                      (index) =>
                                          (product.productSizes ?? [])[index]
                                              .size ??
                                          '').toList()),
                              isFavourite: controller.localFavourites[
                                          (product.id ?? '').toString()] !=
                                      null
                                  ? controller.localFavourites[
                                          (product.id ?? '').toString()] ??
                                      false
                                  : product.isFavourite == 1,
                              favouriteClick: () {
                                controller.addProductAsFavourite(
                                    (product.id ?? '').toString());
                              },
                              productImage:
                                  (product.productImages ?? []).isNotEmpty
                                      ? product.productImages!.first.image ?? ''
                                      : '',
                              lastUpdate: product.updatedAt ?? '',
                              price: double.parse(product.price ?? '0.0'),
                              title: product.name ?? '',
                              onClick: () {
                                gotoProductDetaiesScreen(product);
                              },
                            ),
                          );
                        }),
                  ),
      ),
    );
  }
}
