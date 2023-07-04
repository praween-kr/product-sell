import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home_controller.dart';
import 'package:oninto_flutter/common_widget/app_text.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/utills/colors_file.dart';
import '../../common_widget/appbar.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});
  final controller = Get.put(Homecontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(
        heading: "My Products",
        textStyle: const TextStyle(
            fontSize: 20,
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                indicator: BoxDecoration(
                    color: AppColor.appcolor,
                    borderRadius: BorderRadius.circular(20)),
                // indicatorColor: Colors.grey,
                // labelColor: Colors.black,
                // unselectedLabelColor: Colors.grey,
                indicatorWeight: 1,
                tabs: [
                  Container(
                    height: 40,
                    width: 100,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: AppColor.appcolor,
                        borderRadius: BorderRadius.circular(19)),
                    child: Center(
                      child: AppText(
                        text: "Buy",
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        color: controller.tabController.value == 0
                            ? const Color(0x33000000)
                            : const Color(0xffF2F2F2),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: AppColor.appcolor,
                        borderRadius: BorderRadius.circular(19)),
                    child: Center(
                      child: AppText(
                        text: "Sell",
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        color: controller.tabController.value == 1
                            ? const Color(0x33000000)
                            : const Color(0xffF2F2F2),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: AppColor.appcolor,
                        borderRadius: BorderRadius.circular(19)),
                    child: Center(
                      child: AppText(
                        text: "Co-owner",
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        color: controller.tabController.value == 2
                            ? const Color(0x33000000)
                            : const Color(0xffF2F2F2),
                      ),
                    ),
                  ),
                ]),
            Expanded(
              child: TabBarView(children: [
                GridView.builder(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    // padding:
                    //     const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.1,
                            crossAxisSpacing: 2),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      //  var data = controller.Categorydata[index];
                      return GestureDetector(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  bottom: 10, left: 20, right: 20, top: 7),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(19),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color(0xff17000000),
                                        offset: Offset(0, 3),
                                        blurRadius: 6)
                                  ]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        Assets.assetgirljean,
                                        fit: BoxFit.cover,
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                    const Positioned(
                                        right: 0,
                                        top: 5,
                                        child: Icon(Icons.more_vert,
                                            color: Colors.white)),
                                  ]),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const AppText(
                                    text: "10 mins ago",
                                    textSize: 12,
                                    color: Color(0x4d000000),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  const AppText(
                                    text: "Girl Denim",
                                    textSize: 13,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  const AppText(
                                    text: "\$2000",
                                    textSize: 18,
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                GridView.builder(
                    physics: const ClampingScrollPhysics(),
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    // padding:
                    //     const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.78,
                            mainAxisSpacing: 30,
                            crossAxisSpacing: 30),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      //  var data = controller.Categorydata[index];
                      return GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(19),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xff17000000),
                                    offset: Offset(0, 3),
                                    blurRadius: 6)
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Stack(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    Assets.assetmobile,
                                    height: 130,
                                    width: 130,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Positioned(
                                    left: 5,
                                    top: 5,
                                    right: 0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            height: 20,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: const Color(0xff30E165),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: const Center(
                                              child: AppText(
                                                text: "Sold",
                                                textSize: 10,
                                                color: Colors.white,
                                              ),
                                            )),
                                        const Icon(Icons.more_vert,
                                            color: Colors.white)
                                      ],
                                    )),
                              ]),
                              const SizedBox(
                                height: 5,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppText(
                                          text: "10 mins ago",
                                          textSize: 12,
                                          color: Color(0x4d000000),
                                          fontWeight: FontWeight.w400,
                                        ),
                                        AppText(
                                          text: "Girl Denim",
                                          textSize: 13,
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        AppText(
                                          text: "\$2000",
                                          textSize: 18,
                                          color: Color(0xff000000),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.favorite,
                                          color: AppColor.appcolor,
                                          size: 12,
                                        ),
                                        AppText(
                                          text: "12",
                                          textSize: 12,
                                          color: Color(0x4d000000),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        Icon(
                                          Icons.remove_red_eye_outlined,
                                          color: AppColor.appcolor,
                                          size: 12,
                                        ),
                                        AppText(
                                          text: "199",
                                          textSize: 13,
                                          color: Color(0x4d000000),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                GridView.builder(
                    physics: const ClampingScrollPhysics(),
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, right: 20),
                    // padding:
                    //     const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.76,
                            mainAxisSpacing: 30,
                            crossAxisSpacing: 30),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      //  var data = controller.Categorydata[index];
                      return GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(19),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xff17000000),
                                    offset: Offset(0, 3),
                                    blurRadius: 6)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      Assets.assetgyradox,
                                      height: 130,
                                      width: 130,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Positioned(
                                      left: 5,
                                      top: 5,
                                      right: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              height: 20,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff30E165),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: const Center(
                                                child: AppText(
                                                  text: "Sold",
                                                  textSize: 10,
                                                  color: Colors.white,
                                                ),
                                              )),
                                        ],
                                      )),
                                ]),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText(
                                      text: "10 mins ago",
                                      textSize: 12,
                                      color: Color(0x4d000000),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    AppText(
                                      text: "Gyarados EX",
                                      textSize: 13,
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    AppText(
                                      text: "\$300",
                                      textSize: 18,
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    AppText(
                                      text: "Sold on : 29 May 2023",
                                      textSize: 10,
                                      color: Color(0x4d000000),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
