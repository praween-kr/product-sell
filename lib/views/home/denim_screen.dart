import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/common_widget/common_button.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/utills/colors_file.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';
import '../../common_widget/color_constant.dart';

class DenimScreen extends StatelessWidget {
  const DenimScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: CommonAppbarWidget(
                  heading: "Girls Denim",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Stack(children: [
                Image.asset(Assets.assetsGirlJean),
                Positioned(
                    left: 20,
                    top: MediaQuery.of(context).size.height * 0.30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          Assets.assetsStackjean,
                          height: 80,
                          width: 80,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          Assets.assetsStackjean,
                          height: 80,
                          width: 80,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Stack(children: [
                          Image.asset(
                            Assets.assetsStackjean,
                            height: 80,
                            width: 80,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Image.asset(
                              Assets.assetsVideo,
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ]),
                      ],
                    )),
              ]),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          children: [
                            AppText(
                              text: "Jenny Johnson",
                              textSize: 17,
                              fontWeight: FontWeight.w400,
                              color: AppColor.appcolor,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: AppColor.appcolor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Icon(
                                  Icons.message,
                                  color: Colors.white,
                                ))
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const AppText(
                          text: "Girl Denim",
                          textSize: 17,
                          fontWeight: FontWeight.w400,
                          color: blackColor,
                        ),
                        const Icon(Icons.star, color: AppColor.appcolor),
                        GestureDetector(
                          onTap: () {
                            reviewDialog();
                          },
                          child: const AppText(
                            text: "/4.5",
                            textSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0x4d000000),
                            fontFamily: "Poppins",
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const AppText(
                      text: "\$2000",
                      textSize: 22,
                      fontWeight: FontWeight.w400,
                      color: AppColor.appcolor,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Row(
                      children: [
                        AppText(
                          text: "Category : ",
                          textSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff9F9F9F),
                          fontFamily: "Poppins",
                        ),
                        AppText(
                          text: "girl",
                          textSize: 12,
                          fontWeight: FontWeight.w400,
                          color: blackColor,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Row(
                      children: [
                        AppText(
                          text: "Sub Category : ",
                          textSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff9F9F9F),
                          fontFamily: "Poppins",
                        ),
                        AppText(
                          text: "Jean",
                          textSize: 12,
                          fontWeight: FontWeight.w400,
                          color: blackColor,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Row(
                      children: [
                        AppText(
                          text: "Color :  ",
                          textSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff9F9F9F),
                          fontFamily: "Poppins",
                        ),
                        AppText(
                          text: " Blue",
                          textSize: 12,
                          fontWeight: FontWeight.w400,
                          color: blackColor,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Row(
                      children: [
                        AppText(
                          text: "Brand : ",
                          textSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff9F9F9F),
                          fontFamily: "Poppins",
                        ),
                        AppText(
                          text: " Tommy",
                          textSize: 12,
                          fontWeight: FontWeight.w400,
                          color: blackColor,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(
                color: Color(0x66000000),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: "Condition",
                      textSize: 15,
                      fontWeight: FontWeight.w400,
                      color: AppColor.appcolor,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    AppText(
                      text: "New with tags",
                      textSize: 13,
                      fontWeight: FontWeight.w400,
                      color: blackColor,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    AppText(
                      text:
                          "A brand-new, unused item with tags attached\nor in the original packing.",
                      textSize: 12,
                      fontWeight: FontWeight.w400,
                      lineHeight: 1.3,
                      color: Color(0x4d000000),
                      fontFamily: "Poppins",
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Color(0x66000000),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              AppText(
                                text: "Size :",
                                textSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0x4d000000),
                              ),
                              AppText(
                                text: "XL / 42 / 14",
                                textSize: 12,
                                fontWeight: FontWeight.w400,
                                color: blackColor,
                                fontFamily: "Poppins",
                              )
                            ],
                          ),
                          Row(
                            children: [
                              AppText(
                                text: "Location  :",
                                textSize: 12,
                                color: Color(0x4d000000),
                                fontWeight: FontWeight.w400,
                              ),
                              AppText(
                                text: "Lorem Ipsum California",
                                textSize: 12,
                                fontWeight: FontWeight.w400,
                                color: blackColor,
                                fontFamily: "Poppins",
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              AppText(
                                text: "Posted Date :",
                                textSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0x4d000000),
                              ),
                              AppText(
                                text: "26 May 2020",
                                textSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                color: blackColor,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Image.asset(Assets.assetsSale),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: "Item Description",
                      textSize: 13,
                      fontFamily: "Poppins",
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    AppText(
                        text: "Comfort Experience comfort to greates",
                        textSize: 13,
                        fontFamily: "Poppins",
                        color: Color(0x4d000000)),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.paymentScreen);
                },
                child: CommonButton(
                  height: 50,
                  radius: 15,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  text: "Buy Now",
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400),
                  color: AppColor.appcolor,
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ));
  }

  Future reviewDialog() async {
    print("clicked---- ");

    return showDialog(
        barrierDismissible: true,
        useSafeArea: false,
        context: Get.context!,
        builder: (BuildContext context) {
          return Material(
            type: MaterialType.transparency,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(
                              0.0,
                              0.0,
                            ),
                            blurRadius: 5.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                        // borderRadius: BorderRadius.all(Radius.circular(17)),
                        color: Colors.white),
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 20, right: 20, left: 20),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: AppText(
                            text: "Reviews",
                            textSize: 18,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            color: blackColor,
                          ),
                        ),
                        ListView.builder(
                          itemCount: 5,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppText(
                                      text: "Albert Smith",
                                      textSize: 11,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400,
                                    ),
                                    AppText(
                                      text: "Feb 20, 2023",
                                      textSize: 10,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w400,
                                      color: Color(0x4d000000),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                RatingBar.builder(
                                    initialRating: 5,
                                    updateOnDrag: false,
                                    glow: false,
                                    minRating: 1,
                                    itemSize: 20,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    //  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                    itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: AppColor.appcolor,
                                        ),
                                    ignoreGestures: true,
                                    onRatingUpdate: (rating) {}),
                                const SizedBox(
                                  height: 5,
                                ),
                                const AppText(
                                  text: "Best Product",
                                  textSize: 11,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Color(0x33000000),
                                )
                              ],
                            );
                          },
                        ),
                      ],
                    )),
              ],
            ),
          );
        });
  }
}
