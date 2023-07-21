import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(
        heading: "Filter",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Map<String, dynamic> data = {
                        "from": 0,
                      };
                      Get.toNamed(Routes.denimScreen, arguments: data);
                    },
                    child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        padding: const EdgeInsets.only(
                            bottom: 10, top: 10, left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Center(
                                child: Image.asset(Assets.assetsGirlJean,
                                    height: 170, width: 300, fit: BoxFit.fill),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                               const AppText(
                                  text: "\$200.00",
                                  textSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                Icon(
                                  Icons.favorite,
                                  color: AppColor.blackColor.withOpacity(0.2),
                                )
                              ],
                            ),
                            const AppText(
                              text: "Dolce & Gabbana",
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
            )
          ],
        ),
      ),
    );
  }
}
