import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home/categories_controller.dart';
import 'package:oninto_flutter/common_controller/home/home_controller.dart';
import 'package:oninto_flutter/model/product/product_model.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/service/pagination_model.dart';
import 'package:oninto_flutter/utils/app_print.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/app_toast_loader.dart';
import 'package:oninto_flutter/utils/app_type_status.dart';
import 'package:oninto_flutter/utils/core/core_method.dart';
import 'package:oninto_flutter/utils/empty_widget.dart';
import 'package:oninto_flutter/utils/favourite_button.dart';
import 'package:oninto_flutter/utils/image_view.dart';
import 'package:oninto_flutter/utils/shimmer_widget.dart';
import 'package:oninto_flutter/utils/widgets/blur_widget.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../generated/assets.dart';
import '../../routes/routes.dart';
import '../../utils/appbar.dart';
import '../../utils/color_constant.dart';
import '../../utils/common_button.dart';
import 'product/product_details_navigation.dart';

class CategoryWiseProductsScreen extends StatelessWidget {
  CategoryWiseProductsScreen({super.key});
  // final Homecontroller controller = Get.find();
  final CategoriesController _categoriesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const CommonAppbarWidget(),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 25.0),
        child: Column(
          children: [
            /// Touch Button
            Obx(() => Padding(
                  padding: const EdgeInsets.only(right: 15, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _categoriesController.swapingIndex.value = 0;
                          _categoriesController.listViewTab.value = false;
                          _categoriesController.filter.value = false;
                          _categoriesController.selectValue.value = 0;

                          AppPrint.all(
                              "menu value${_categoriesController.listViewTab.value}");
                        },
                        child: _categoriesController.selectValue.value == 0
                            ? Image.asset(
                                Assets.assetsTouch,
                                height: 30,
                                width: 30,
                              )
                            : Image.asset(Assets.assetsTouchIcon,
                                height: 30, width: 30),
                      ),

                      /// Filter Button
                      Padding(
                        padding: const EdgeInsets.only(right: 7.0, left: 8),
                        child: GestureDetector(
                          onTap: () {
                            _categoriesController.swapingIndex.value = 0;
                            _categoriesController.filter.value = true;
                            _categoriesController.listViewTab.value = true;
                            _categoriesController.selectValue.value = 1;
                            AppPrint.all(
                                "menu value${_categoriesController.listViewTab.value}");
                          },
                          child: _categoriesController.selectValue.value == 1
                              ? Image.asset(Assets.assetsSortIcon,
                                  height: 30, width: 30)
                              : Image.asset(Assets.assetsSort,
                                  height: 30, width: 30),
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(
                  () => _categoriesController.listViewTab.value
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: AppText(
                                  text: "Near by",
                                  textSize: 17,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins"),
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: () async {
                                  _categoriesController.swapingIndex.value = 0;
                                  _categoriesController.localFavourites.clear();
                                  await _categoriesController.getProducts(
                                    productType: 2,
                                    categoryId: _categoriesController
                                        .selectedCategory.value?.id
                                        .toString(),
                                    subCategoryId: _categoriesController
                                        .selectedSubCategory.value?.id
                                        .toString(),
                                  );
                                },
                                child: _categoriesController.loadingData.value
                                    ? ShimmerWidgets.productListView()
                                    : _categoriesController.products.isEmpty
                                        ? EmptyWidgets.simple(
                                            refresh: () async {
                                            _categoriesController
                                                .localFavourites
                                                .clear();
                                            await _categoriesController
                                                .getProducts(
                                              productType: 2,
                                              categoryId: _categoriesController
                                                  .selectedCategory.value?.id
                                                  .toString(),
                                              subCategoryId:
                                                  _categoriesController
                                                      .selectedSubCategory
                                                      .value
                                                      ?.id
                                                      .toString(),
                                            );
                                          })
                                        : ListView.separated(
                                            controller: _categoriesController
                                                .scrollController,
                                            physics: const ClampingScrollPhysics(
                                                parent:
                                                    AlwaysScrollableScrollPhysics()),
                                            separatorBuilder: (_, __) =>
                                                const Divider(height: 1),
                                            itemCount: _categoriesController
                                                .products.length,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              var product =
                                                  _categoriesController
                                                      .products[index];
                                              String img = "";
                                              if ((product.productImages ?? [])
                                                  .isNotEmpty) {
                                                img = product.productImages
                                                        ?.first.image ??
                                                    '';
                                              }

                                              return Obx(
                                                () => productCard(
                                                  price: double.parse(
                                                      product.price ?? '0.0'),
                                                  about: product.name ?? '',
                                                  isShareType: product.type ==
                                                      TypeOfProduct.share,
                                                  productSize: AppCore
                                                      .productSizeText(List<
                                                              String>.generate(
                                                          (product.productSizes ??
                                                                  [])
                                                              .length,
                                                          (index) =>
                                                              (product.productSizes ??
                                                                      [])[index]
                                                                  .size ??
                                                              '').toList()),

                                                  //"XL/42",
                                                  image: img,
                                                  isFavourite: _categoriesController
                                                                  .localFavourites[
                                                              (product.id ?? '')
                                                                  .toString()] !=
                                                          null
                                                      ? _categoriesController
                                                                  .localFavourites[
                                                              (product.id ?? '')
                                                                  .toString()] ??
                                                          false
                                                      : product.isFavourite ==
                                                          1,
                                                  clickOnFavourite: () {
                                                    _categoriesController
                                                        .addProductAsFavourite(
                                                            (product.id ?? '')
                                                                .toString());
                                                  },
                                                  onClick: () =>
                                                      gotoProductDetaiesScreen(
                                                          product),
                                                ),
                                              );
                                            },
                                          ),
                              ),
                            ),
                          ],
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 40, top: 10),
                          child: Obx(
                            () => Stack(
                              children: [
                                _categoriesController.products.isEmpty ||
                                        _categoriesController
                                                .swapingIndex.value >=
                                            _categoriesController
                                                .products.length
                                    ? SizedBox(
                                        height: Get.height,
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            Container(
                                              height: double.infinity,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: <Color>[
                                                    Colors.black
                                                        .withOpacity(0.6),
                                                    // Colors.black.withOpacity(0.3),
                                                    Colors.black
                                                        .withOpacity(0.0),
                                                  ],
                                                  tileMode: TileMode.mirror,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(28),
                                                  bottomLeft:
                                                      Radius.circular(28),
                                                ),
                                              ),
                                            ),
                                            EmptyWidgets.simple(),
                                            GestureDetector(
                                              onTap: () async {
                                                _categoriesController
                                                    .swapingIndex.value = 0;
                                                await _categoriesController
                                                    .getProducts(
                                                  productType: 2,
                                                );
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 80.0),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 14,
                                                        vertical: 12),
                                                decoration: BoxDecoration(
                                                    color: AppColor.appColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: const Icon(
                                                  Icons.refresh,
                                                  color: Colors.white,
                                                  size: 28,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : SwipableStack(
                                        onSwipeCompleted: (index, direction) {
                                          AppPrint.all(
                                              "Swipe Completed: $index, $direction ${_categoriesController.products.length}");
                                        },
                                        onWillMoveNext:
                                            (index, swipeDirection) {
                                          // if (!(index !=
                                          //     _categoriesController
                                          //             .products.length -
                                          //         1)) {
                                          //   _categoriesController.getProducts(
                                          //       limit: 1,
                                          //       pageno: _categoriesController
                                          //           .products.length);
                                          // }
                                          print(
                                              "${_categoriesController.products.length} -> $index");
                                          _categoriesController
                                              .swapingIndex.value = index;

                                          return true;
                                        },
                                        builder: (context, properties) {
                                          var product =
                                              _categoriesController.products[
                                                  properties.index %
                                                      _categoriesController
                                                          .products.length];
                                          String img = "";
                                          if ((product.productImages ?? [])
                                              .isNotEmpty) {
                                            img = product.productImages?.first
                                                    .image ??
                                                '';
                                          }
                                          return SizedBox(
                                            height: Get.height,
                                            child: Stack(
                                              clipBehavior: Clip.none,
                                              alignment: Alignment.bottomCenter,
                                              children: [
                                                AppBlurWidget.child(
                                                  height: Get.height,
                                                  child: AppImage.view(
                                                      "${ImageBaseUrls.product}$img",
                                                      fit: BoxFit.contain,
                                                      width: double.infinity),
                                                  blurChild: AppImage.view(
                                                      "${ImageBaseUrls.product}$img",
                                                      fit: BoxFit.cover,
                                                      height: Get.height),
                                                ),
                                                // Details
                                                Container(
                                                  height: Get.height * 0.45,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      begin: Alignment
                                                          .bottomCenter,
                                                      end: Alignment.topCenter,
                                                      colors: <Color>[
                                                        Colors.black
                                                            .withOpacity(0.6),
                                                        Colors.black
                                                            .withOpacity(0.3),
                                                        Colors.black
                                                            .withOpacity(0.0),
                                                      ],
                                                      tileMode: TileMode.mirror,
                                                    ),
                                                    // color:
                                                    //     Colors.black.withOpacity(0.3),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      bottomRight:
                                                          Radius.circular(28),
                                                      bottomLeft:
                                                          Radius.circular(28),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  bottom: Get.height * .1,
                                                  left: 20,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          // controller.sub.value = true;
                                                          _categoriesController
                                                              .listViewTab
                                                              .value = false;
                                                          //  controller.touchTap.value = true;
                                                          Get.toNamed(Routes
                                                              .bidingProductDetails);
                                                        },
                                                        child: AppText(
                                                          text: product.name ??
                                                              '',
                                                          textSize: 18,
                                                          fontFamily: "Poppins",
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      AppText(
                                                        text:
                                                            "\$${product.price ?? '0.0'}",
                                                        textSize: 18,
                                                        color: Colors.white,
                                                        fontFamily: "Poppins",
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      GestureDetector(
                                                        onTap: () {
                                                          gotoProductDetaiesScreen(
                                                              product);
                                                          // timerDialog(
                                                          //   product,
                                                          //   endTime: DateTime.parse(
                                                          //       "2023-12-10 18:37:00"),
                                                          //   bidNow: () {
                                                          //     Get.back();
                                                          //     AppDialogs
                                                          //         .bidHistoryDialog(
                                                          //       bidingData:
                                                          //           AddBidsHistory(),
                                                          //       confirm: () {
                                                          //         Get.back();
                                                          //         _bidNow((product
                                                          //                     .id ??
                                                          //                 '')
                                                          //             .toString());
                                                          //       },
                                                          //       seeAll: () {
                                                          //         Get.toNamed(Routes
                                                          //             .biddingHistoryScreen);
                                                          //       },
                                                          //     );
                                                          //   },
                                                          // );
                                                        },
                                                        child: CommonButton(
                                                          height: 40,
                                                          radius: 15,
                                                          color:
                                                              AppColor.appColor,
                                                          text: product.type ==
                                                                  TypeOfProduct
                                                                      .share
                                                              ? "Buy Share"
                                                              : product.sellOption ==
                                                                      ProductType
                                                                          .fixedPrice
                                                                  ? "Buy"
                                                                  : "Bid \$${product.lastBidInfo == null ? product.price ?? '0.0' : product.lastBidInfo?.bidPrice ?? '0.0'}",
                                                          textStyle:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                            fontFamily:
                                                                "Poppins",
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                      // const SizedBox(height: 10),
                                                      // AppText(
                                                      //   text:
                                                      //       "min \$${product.minimumSellingPrice ?? '0.0'}",
                                                      //   textSize: 10,
                                                      //   color: Colors.white,
                                                      //   fontFamily: "Poppins",
                                                      //   fontWeight:
                                                      //       FontWeight.w400,
                                                      // ),
                                                      product.sellOption ==
                                                              ProductType
                                                                  .fixedPrice
                                                          ? const SizedBox
                                                              .shrink()
                                                          : const SizedBox(
                                                              height: 10),
                                                      product.sellOption ==
                                                              ProductType
                                                                  .fixedPrice
                                                          ? const SizedBox
                                                              .shrink()
                                                          : GestureDetector(
                                                              onTap: () {
                                                                Get.toNamed(Routes
                                                                    .biddingHistoryScreen);
                                                              },
                                                              child: RichText(
                                                                  text: TextSpan(
                                                                      text: (product.productBidCount ?? 0) < 2 ? "${product.productBidCount ?? 0} Bid " : "${product.productBidCount ?? 0} Bids ",
                                                                      style: const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            10,
                                                                        fontFamily:
                                                                            "Poppins",
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                      ),
                                                                      children: [
                                                                    TextSpan(
                                                                        text:
                                                                            "Show bid history",
                                                                        style: const TextStyle(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                10,
                                                                            fontFamily:
                                                                                "Poppins",
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            decoration: TextDecoration.underline),
                                                                        recognizer: TapGestureRecognizer()
                                                                          ..onTap = () {
                                                                            if (HomeCatProductController().initialized) {
                                                                              Get.find<HomeCatProductController>().getBidHistories(productId: (product.id ?? '').toString());
                                                                            } else {
                                                                              Get.put(HomeCatProductController()).getBidHistories(productId: (product.id ?? '').toString());
                                                                            }

                                                                            Get.toNamed(Routes.biddingHistoryScreen);
                                                                          })
                                                                  ])),
                                                            )
                                                    ],
                                                  ),
                                                ),

                                                /// like and Dislike Heart View
                                                Positioned(
                                                  bottom: -17,
                                                  child: Obx(
                                                    () => Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        likeDeslikeBtn(
                                                          icon: const IconData(
                                                              0xf032e,
                                                              fontFamily:
                                                                  'MaterialIcons'),
                                                          isFav: !_isFavourite(
                                                              _categoriesController,
                                                              product),
                                                          onClick: () {
                                                            if (_isFavourite(
                                                                _categoriesController,
                                                                product)) {
                                                              _categoriesController
                                                                  .addProductAsFavourite(
                                                                      (product.id ??
                                                                              '')
                                                                          .toString());
                                                            }
                                                          },
                                                        ),
                                                        SizedBox(
                                                            width: Get.width *
                                                                0.18),
                                                        likeDeslikeBtn(
                                                          color: AppColor.red,
                                                          icon: Icons.favorite,
                                                          isFav: _isFavourite(
                                                              _categoriesController,
                                                              product),
                                                          onClick: () {
                                                            if (!_isFavourite(
                                                                _categoriesController,
                                                                product)) {
                                                              _categoriesController
                                                                  .addProductAsFavourite(
                                                                (product.id ??
                                                                        '')
                                                                    .toString(),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                _categoriesController.loadingData.value ||
                                        _categoriesController
                                            .nextPageIsLoading.value
                                    ? AppLoader.showWidget()
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
            ),

            /// SubCategory View
            //     : Expanded(
            //   child: GridView.builder(
            //       physics: const ClampingScrollPhysics(),
            //       padding: const EdgeInsets.symmetric(
            //           horizontal: 5, vertical: 5),
            //       gridDelegate:
            //       const SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 3, childAspectRatio: 0.75),
            //       itemCount: 6,
            //       itemBuilder: (context, index) {
            //         var data = controller.Categorydata[index];
            //         return GestureDetector(
            //           onTap: () {
            //             Get.toNamed(Routes.menScreen);
            //             print("menu value ${controller.menu.value}");
            //           },
            //           child: Column(
            //             children: [
            //               Container(
            //                 margin: const EdgeInsets.only(top: 20),
            //                 padding: const EdgeInsets.only(
            //                     top: 15,
            //                     bottom: 15,
            //                     left: 20,
            //                     right: 20),
            //                 decoration: BoxDecoration(
            //                     borderRadius:
            //                     BorderRadius.circular(10),
            //                     border: Border.all(
            //                         color: Colors.grey, width: 1)),
            //                 child: Image.asset(
            //                   data.image,
            //                   fit: BoxFit.contain,
            //                   height: 70,
            //                   width: 50,
            //                 ),
            //               ),
            //               const SizedBox(
            //                 height: 10,
            //               ),
            //               AppText(
            //                 text: controller.Categorydata[index].Name,
            //                 color: Colors.black,
            //                 textSize: 14,
            //               )
            //             ],
            //           ),
            //         );
            //       }),
            // ),

            Obx(
              () => _categoriesController.nextPageIsLoading.value
                  ? _categoriesController.noMoreData.value
                      ? AppPaginationViews.noMore()
                      : AppPaginationViews.loading()
                  : const SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }

  bool _isFavourite(CategoriesController cc, ProductModel product) =>
      (cc.localFavourites[(product.id ?? '').toString()] != null
          ? cc.localFavourites[(product.id ?? '').toString()] ?? false
          : product.isFavourite == 1);

  // _bidNow(String productId) {
  //   Map<String, dynamic> data = {"from": 0};
  //   if (HomeCatProductController().initialized) {
  //     Get.find<HomeCatProductController>().getProductDetails(productId);
  //   } else {
  //     Get.put(HomeCatProductController()).getProductDetails(productId);
  //   }
  //   Get.toNamed(Routes.productDetailsScreen, arguments: data);
  // }

  Widget likeDeslikeBtn(
      {required bool isFav,
      required Function onClick,
      IconData? icon,
      Color? color}) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
              color: color ?? AppColor.blackColor, shape: BoxShape.circle),
          child: FavouriteButton(
            activeIcon: icon,
            activeColor: AppColor.white,
            size: 28,
            isFavourite: true,
            onClick: () => onClick(),
          ),
        ),
        isFav
            ? const SizedBox.shrink()
            : Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                    color: AppColor.white.withOpacity(0.6),
                    shape: BoxShape.circle),
                child: FavouriteButton(
                  activeIcon: icon,
                  activeColor: AppColor.white,
                  size: 28,
                  isFavourite: true,
                  onClick: () => onClick(),
                ),
              ),
      ],
    );
  }

  Widget productCard(
      {required Function onClick,
      String? image,
      double? price,
      bool isFavourite = false,
      bool isShareType = false,
      String? productSize,
      required String about,
      required Function clickOnFavourite}) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.only(
                  bottom: 10, top: 10, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AppImage.view("${ImageBaseUrls.product}$image",
                        height: 170, width: 300, fit: BoxFit.fill),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: AppText(
                            text: "\$${price ?? '0.0'}",
                            textSize: 15,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w600),
                      ),
                      FavouriteButton(
                          onClick: () => clickOnFavourite(),
                          isFavourite: isFavourite),
                    ],
                  ),
                  AppText(
                    text: about,
                    textSize: 10,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: 8),
                  isShareType
                      ? AppCore.shreTag()
                      : AppText(
                          text: productSize ?? '',
                          textSize: 13,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w500,
                          maxlines: 1),
                ],
              )),
        ],
      ),
    );
  }

  Future timerDialog(ProductModel product,
      {required Function bidNow, required DateTime endTime}) async {
    AppPrint.all("clicked---- ");
    return showDialog(
        barrierDismissible: true,
        useSafeArea: false,
        context: Get.context!,
        builder: (BuildContext context) {
          return const Material(
              type: MaterialType.transparency, child: Text("Timer")
              // Obx(
              //   () =>
              //   AppTimer(
              //     bidNow: () {},
              //     viewType: true,
              //     textSize: 14,
              //     // Timer status change listener
              //     onChanged: (TimerType data) {
              //       _homeController.bidingTimerStatus.value = data.status;
              //       // print("Timer Start to --> - ${data.value}");
              //     },
              //     // Biding timer duration
              //     duration: const Duration(minutes: 5),
              //     // No bid added yet then-> Start bid date time else-> last bid date time
              //     startDateTime: _homeController.bidingData.value?.save == null
              //         ? DateTime.parse(
              //             "${_homeController.productDetailsData.value?.details?.startDate}T${_homeController.productDetailsData.value?.details?.bidTime}")
              //         : DateTime.parse(
              //             _homeController.bidingData.value?.save?.createdAt ??
              //                 ''),
              //     // At list one bid added then will be [bidingStarted: true] else [bidingStarted: false]
              //     bidingStarted: _homeController.bidingData.value?.save != null,
              //   ),
              // ),
              );
        });
  }
}
