import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/utils/appbar.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/utils/date_time_formates.dart';
import 'package:oninto_flutter/utils/empty_widget.dart';
import 'package:oninto_flutter/utils/image_view.dart';

import '../../../common_controller/product/my_product_controller.dart';
import '../../../model/product/product_fav_view_model.dart';
import '../../../utils/app_text.dart';

class LikeAndViewsOfProductScreen extends StatelessWidget {
  LikeAndViewsOfProductScreen({super.key});
  final MyProductController _myProductController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbarWidget(
        headingChild: Obx(
          () => Text(
            _myProductController.productTitle.value,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _myProductController.getPrductReactions(
            (_myProductController.productDetailsData.value?.details?.id)
                .toString(),
            productName: _myProductController.productTitle.value,
          );
        },
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Obx(
                    () => Row(
                      children: [
                        myTab(
                          title:
                              "Views (${(_myProductController.reactionOnProduct.value?.viewUserList ?? []).length})",
                          active: _myProductController.isViews.value,
                          onClick: () {
                            _myProductController.isViews.value = true;
                          },
                        ),
                        const SizedBox(width: 20),
                        myTab(
                          title:
                              "Favourite (${(_myProductController.reactionOnProduct.value?.favoriteUserList ?? []).length})",
                          active: !_myProductController.isViews.value,
                          onClick: () {
                            _myProductController.isViews.value = false;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => _myProductController.isViews.value
                      ? (_myProductController
                                      .reactionOnProduct.value?.viewUserList ??
                                  [])
                              .isEmpty
                          ? EmptyWidgets.simple()
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                List<ViewUserList>? list = [];
                                if (_myProductController.reactionOnProduct.value
                                        ?.viewUserList !=
                                    null) {
                                  list = _myProductController.reactionOnProduct
                                          .value?.viewUserList ??
                                      [];
                                }

                                ViewUserList data = list[index];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: AppImage.profile(
                                              context,
                                              url:
                                                  "${ImageBaseUrls.profile}${data.user?.image ?? ''}",
                                              isNetwork: true,
                                              radius: 26,
                                            ),
                                          ),
                                          const Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Icon(
                                              Icons.remove_red_eye,
                                              color: AppColor.appColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 10.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppText(
                                              text:
                                                  "${data.user?.firstName ?? ''} ${data.user?.lastName ?? ''}",
                                              textSize: 16.0,
                                              style: AppTextStyle.regular,
                                            ),
                                            const SizedBox(height: 8.0),
                                            AppText(
                                              text: AppDateTime.getDateTime(
                                                  data.createdAt ?? '',
                                                  format: DateFormat(
                                                      "dd MMM yyyy")),
                                              textSize: 10.0,
                                              style: AppTextStyle.small,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 14),
                              itemCount: (_myProductController.reactionOnProduct
                                          .value?.viewUserList ??
                                      [])
                                  .length,
                            )
                      : (_myProductController.reactionOnProduct.value
                                      ?.favoriteUserList ??
                                  [])
                              .isEmpty
                          ? EmptyWidgets.simple()
                          : ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                List<FavoriteUserList>? list = [];
                                if (_myProductController.reactionOnProduct.value
                                        ?.favoriteUserList !=
                                    null) {
                                  list = _myProductController.reactionOnProduct
                                          .value?.favoriteUserList ??
                                      [];
                                }

                                FavoriteUserList data = list[index];

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22),
                                  child: Row(
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: AppImage.profile(
                                              context,
                                              url:
                                                  "${ImageBaseUrls.profile}${data.user?.image ?? ''}",
                                              isNetwork: true,
                                              radius: 26,
                                            ),
                                          ),
                                          const Positioned(
                                            bottom: 0,
                                            right: 0,
                                            child: Icon(
                                              Icons.favorite,
                                              color: AppColor.appColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 10.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AppText(
                                              text:
                                                  "${data.user?.firstName ?? ''} ${data.user?.lastName ?? ''}",
                                              textSize: 16.0,
                                              style: AppTextStyle.regular,
                                            ),
                                            const SizedBox(height: 8.0),
                                            AppText(
                                              text: AppDateTime.getDateTime(
                                                  data.createdAt ?? '',
                                                  format: DateFormat(
                                                      "dd MMM yyyy")),
                                              textSize: 10.0,
                                              style: AppTextStyle.small,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 14),
                              itemCount: (_myProductController.reactionOnProduct
                                          .value?.favoriteUserList ??
                                      [])
                                  .length,
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget myTab(
      {required Function onClick, required String title, bool active = true}) {
    return GestureDetector(
      onTap: () => onClick(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
            color: active ? AppColor.appColor : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColor.appColor)),
        child: AppText(
          text: title,
          color: active ? Colors.white : AppColor.appColor,
        ),
      ),
    );
  }
}
