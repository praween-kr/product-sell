import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home/categories_controller.dart';
import 'package:oninto_flutter/common_controller/home/home_controller.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/utills/empty_widget.dart';
import 'package:oninto_flutter/utills/image_view.dart';
import 'package:oninto_flutter/utills/shimmer_widget.dart';

import '../../common_widget/app_text.dart';
import '../../common_widget/appbar.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({super.key});
  final HomeCatProductcontroller controller = Get.find();
  final CategoriesController _categoriesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CommonAppbarWidget(
            heading: "Categories",
          ),
          Expanded(
            child: Obx(
              () => _categoriesController.loadingData.value
                  ? ShimmerWidgets.gridView()
                  : _categoriesController.categoriesList.isEmpty
                      ? EmptyWidgets.simple()
                      : GridView.builder(
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 14),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, childAspectRatio: 0.75),
                          itemCount:
                              _categoriesController.categoriesList.length,
                          itemBuilder: (context, index) {
                            var data =
                                _categoriesController.categoriesList[index];
                            return GestureDetector(
                              onTap: () {
                                _categoriesController.getSubCategories(
                                    (data.id ?? '').toString());
                                _categoriesController.selectedCategory.value =
                                    data;
                                Get.toNamed(Routes.subCategories);
                              },
                              child: Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.grey, width: 1)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: AppImage.view(
                                            "${ImageBaseUrls.category}${data.image ?? ''}",
                                            height: 75,
                                            width: 70,
                                            fit: BoxFit.cover),
                                      )),
                                  const SizedBox(height: 10),
                                  AppText(
                                    text: data.name ?? '',
                                    color: const Color.fromARGB(255, 6, 4, 4),
                                    textSize: 12,
                                  )
                                ],
                              ),
                            );
                          }),
            ),
          ),
        ],
      ),
    );
  }
}
