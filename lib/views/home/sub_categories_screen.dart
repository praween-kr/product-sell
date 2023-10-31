import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home/categories_controller.dart';
import 'package:oninto_flutter/common_widget/app_text.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/utills/empty_widget.dart';
import 'package:oninto_flutter/utills/image_view.dart';

class SubCategoriesScreen extends StatelessWidget {
  SubCategoriesScreen({super.key});
  // final controller = Get.put(MenListController());
  // final bottomcontroller = Get.put(BottomNavController());
  // final controller1 = Get.put(Homecontroller());
  final CategoriesController _categoriesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(
        headingChild: Obx(
          () => Text(
            _categoriesController.selectedCategory.value?.name ?? "",
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => _categoriesController.loadingSubData.value
                  ? const Center(child: CircularProgressIndicator())
                  : _categoriesController.subCategoriesList.isEmpty
                      ? EmptyWidgets.simple()
                      : GridView.builder(
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, childAspectRatio: 0.75),
                          itemCount:
                              _categoriesController.subCategoriesList.length,
                          itemBuilder: (context, index) {
                            var data =
                                _categoriesController.subCategoriesList[index];
                            return GestureDetector(
                              onTap: () {
                                // controller1.menu.value = true;
                                // controller1.touchTap.value = true;
                                Get.toNamed(Routes.subCategoryScreen);
                              },
                              child: Column(
                                children: [
                                  Container(
                                      // margin: const EdgeInsets.only(top: 20),
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
                                            "${AppApis.imageBaseUrl}${data.image ?? ''}",
                                            height: 60,
                                            width: 60,
                                            fit: BoxFit.cover),
                                      )),
                                  const SizedBox(height: 10),
                                  AppText(
                                    text: data.name ?? '',
                                    color: Colors.black,
                                    textSize: 14,
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