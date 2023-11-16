import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/favourites_controller.dart';
import 'package:oninto_flutter/common_controller/home/home_controller.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';
import 'package:oninto_flutter/utills/empty_widget.dart';
import 'package:oninto_flutter/utills/favourite_button.dart';
import 'package:oninto_flutter/utills/image_view.dart';
import 'package:oninto_flutter/utills/shimmer_widget.dart';
import 'package:oninto_flutter/utills/widgets/dialogs.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({super.key});
  final Homecontroller controller = Get.find();
  final FavouritesController _favouritesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          children: [
            const SizedBox(height: 14),
            const Center(
              child: AppText(
                text: "My Favourite",
                textSize: 20,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: Obx(
                () => RefreshIndicator(
                  onRefresh: () async {
                    await _favouritesController.getFavouriteProducts();
                  },
                  child: _favouritesController.loadingData.value
                      ? ShimmerWidgets.productGridView()
                      : _favouritesController.myFavProducts.isEmpty
                          ? EmptyWidgets.simple()
                          : GridView.builder(
                              physics: const ClampingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              padding: const EdgeInsets.only(top: 20),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.1,
                                      crossAxisSpacing: 2),
                              itemCount:
                                  _favouritesController.myFavProducts.length,
                              itemBuilder: (context, index) {
                                var favProduct =
                                    _favouritesController.myFavProducts[index];
                                String proImg =
                                    (favProduct.product?.productImages ?? [])
                                            .isNotEmpty
                                        ? favProduct.product?.productImages!
                                                .first.image ??
                                            ''
                                        : '';
                                return Obx(
                                  () => GestureDetector(
                                    onTap: () {
                                      _favouritesController.getProductDetails(
                                          (favProduct.product?.id ?? '')
                                              .toString());
                                      Get.toNamed(Routes.bidingProductDetatils);
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              bottom: 10,
                                              left: 20,
                                              right: 20,
                                              top: 7),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: AppImage.view(
                                                        "${ImageBaseUrls.product}$proImg",
                                                        height: Get.width * 0.4,
                                                        width: double.infinity,
                                                        fit: BoxFit.cover),
                                                  ),
                                                  Positioned(
                                                    right: 5,
                                                    top: 5,
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration:
                                                          const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              shape: BoxShape
                                                                  .circle),
                                                      child: FavouriteButton(
                                                        isFavourite: true,
                                                        onClick: () {
                                                          AppDialogs.confirm(
                                                              context,
                                                              msg:
                                                                  "Are you sure want to remove this product to your favourite?",
                                                              clickOnYes: () {
                                                            Get.back();
                                                            _favouritesController
                                                                .addProductAsFavourite(
                                                                    (favProduct.product?.id ??
                                                                            '')
                                                                        .toString(),
                                                                    index);
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  _favouritesController
                                                              .removingProduct
                                                              .value !=
                                                          favProduct.product?.id
                                                              .toString()
                                                      ? const SizedBox.shrink()
                                                      : Container(
                                                          height:
                                                              Get.width * 0.4,
                                                          width:
                                                              double.infinity,
                                                          decoration: BoxDecoration(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.4),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                        ),
                                                  _favouritesController
                                                              .removingProduct
                                                              .value !=
                                                          favProduct.product?.id
                                                              .toString()
                                                      ? const SizedBox.shrink()
                                                      : const AppText(
                                                          text: "Removing...",
                                                          color: Colors.white,
                                                          textSize: 12,
                                                        ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
