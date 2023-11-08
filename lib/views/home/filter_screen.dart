import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/product/product_controller.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';
import 'package:oninto_flutter/utills/image_view.dart';
import 'package:oninto_flutter/utills/shimmer_widget.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({super.key});

  final ProductController _productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(heading: "Filter"),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => _productController.loadingdata.value
                  ? ShimmerWidgets.productListView()
                  : _productController.myProducts.isEmpty
                      ? const Center(child: Text("No data"))
                      : ListView.builder(
                          itemCount: _productController.myProducts.length,
                          itemBuilder: (BuildContext context, int index) {
                            var product = _productController.myProducts[index];
                            String img = (product.productImages ?? []).isEmpty
                                ? ''
                                : product.productImages!.first.image ?? '';
                            print(
                                "${ImageBaseUrls.product}${product.productImages ?? ''}");
                            return GestureDetector(
                              onTap: () {
                                Map<String, dynamic> data = {"from": 0};
                                Get.toNamed(Routes.denimScreen,
                                    arguments: data);
                              },
                              child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 14),
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 10, left: 20, right: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Center(
                                          child: AppImage.view(
                                              "${ImageBaseUrls.product}$img",
                                              height: 170,
                                              width: double.infinity,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AppText(
                                            text: "\$${product.price ?? 0.0}",
                                            textSize: 15,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          Icon(
                                            Icons.favorite,
                                            color: AppColor.blackColor
                                                .withOpacity(0.2),
                                          )
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
                          },
                        ),
            ),
          )
        ],
      ),
    );
  }
}
