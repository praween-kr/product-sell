import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/service/apis.dart';

import 'app_text.dart';
import 'date_time_formates.dart';
import 'favourite_button.dart';
import 'image_view.dart';

class CommonWidgets {
  static Widget productGridCard(
          {required Function onClick,
          required String lastUpdate,
          required String title,
          required double price,
          required String productImage,
          String? soldOn,
          int? likes,
          int? views}) =>
      GestureDetector(
        onTap: () => onClick(),
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
                  child: AppImage.view("${ImageBaseUrls.product}$productImage",
                      height: 130, width: 130, fit: BoxFit.cover),
                ),
                Positioned(
                    left: 5,
                    top: 5,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        soldOn != null
                            ? Container(
                                height: 20,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: const Color(0xff30E165),
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                  child: AppText(
                                      text: "Sold",
                                      textSize: 10,
                                      color: Colors.white),
                                ))
                            : Container(),
                        // const Icon(Icons.more_vert, color: Colors.white)
                      ],
                    )),
              ]),
              const SizedBox(height: 5),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                  text: AppDateTime.getTimeAgo(lastUpdate),
                                  textSize: 12,
                                  color: const Color(0x4d000000),
                                  fontWeight: FontWeight.w400,
                                  maxlines: 1),
                              const SizedBox(height: 4),
                              AppText(
                                  text: title,
                                  textSize: 13,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                  maxlines: 1),
                              const SizedBox(height: 4),
                              AppText(
                                text: "\$$price",
                                textSize: 18,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w500,
                                maxlines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          likes == null
                              ? const SizedBox.shrink()
                              : const Icon(Icons.favorite,
                                  color: AppColor.appColor, size: 12),
                          likes == null
                              ? const SizedBox.shrink()
                              : AppText(
                                  text: likes.toString(),
                                  textSize: 10,
                                  color: const Color(0x4d000000),
                                  fontWeight: FontWeight.w500),
                          views == null
                              ? const SizedBox.shrink()
                              : const Icon(Icons.remove_red_eye_outlined,
                                  color: AppColor.appColor, size: 12),
                          views == null
                              ? const SizedBox.shrink()
                              : AppText(
                                  text: views.toString(),
                                  textSize: 10,
                                  color: const Color(0x4d000000),
                                  fontWeight: FontWeight.w500),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              soldOn == null
                  ? const SizedBox.shrink()
                  : Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: AppText(
                          text:
                              "Sold on : ${AppDateTime.getDateTime(soldOn, format: DateFormat("dd MMM yyyy"))}", //29 May 2023
                          textSize: 10,
                          color: const Color(0x4d000000),
                          fontWeight: FontWeight.w500,
                          maxlines: 1,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      );

  static Widget productGridCard2(
          {required Function onClick,
          required String lastUpdate,
          required String title,
          required double price,
          required String productImage,
          bool isFavourite = false,
          Function? favouriteClick,
          String? soldOn,
          int? likes,
          int? views}) =>
      GestureDetector(
        onTap: () => onClick(),
        child: Container(
          // padding: const EdgeInsets.symmetric(vertical: 10),
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
              Padding(
                padding: const EdgeInsets.all(5),
                child: Stack(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AppImage.view(
                        "${ImageBaseUrls.product}$productImage",
                        height: Get.width * 0.4,
                        width: double.infinity,
                        fit: BoxFit.cover),
                  ),
                  Positioned(
                      left: 5,
                      top: 5,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          soldOn != null
                              ? Container(
                                  height: 20,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff30E165),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                    child: AppText(
                                        text: "Sold",
                                        textSize: 10,
                                        color: Colors.white),
                                  ))
                              : Container(),
                          // const Icon(Icons.more_vert, color: Colors.white)
                        ],
                      )),
                ]),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: AppText(
                                      text: "\$$price",
                                      textSize: 18,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      maxlines: 1,
                                    ),
                                  ),
                                  FavouriteButton(
                                      onClick: favouriteClick == null
                                          ? () {}
                                          : () => favouriteClick(),
                                      isFavourite: isFavourite),
                                ],
                              ),
                              const SizedBox(height: 4),
                              AppText(
                                  text: title,
                                  textSize: 13,
                                  color: const Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                  maxlines: 1),
                              const SizedBox(height: 4),
                              const AppText(
                                  text: "XL/42",
                                  textSize: 13,
                                  color: Color(0xff000000),
                                  fontWeight: FontWeight.w500,
                                  maxlines: 1),
                              const SizedBox(height: 4),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          likes == null
                              ? const SizedBox.shrink()
                              : const Icon(Icons.favorite,
                                  color: AppColor.appColor, size: 12),
                          likes == null
                              ? const SizedBox.shrink()
                              : AppText(
                                  text: likes.toString(),
                                  textSize: 10,
                                  color: const Color(0x4d000000),
                                  fontWeight: FontWeight.w500),
                          views == null
                              ? const SizedBox.shrink()
                              : const Icon(Icons.remove_red_eye_outlined,
                                  color: AppColor.appColor, size: 12),
                          views == null
                              ? const SizedBox.shrink()
                              : AppText(
                                  text: views.toString(),
                                  textSize: 10,
                                  color: const Color(0x4d000000),
                                  fontWeight: FontWeight.w500),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              soldOn == null
                  ? const SizedBox.shrink()
                  : Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: AppText(
                          text:
                              "Sold on : ${AppDateTime.getDateTime(soldOn, format: DateFormat("dd MMM yyyy"))}", //29 May 2023
                          textSize: 10,
                          color: const Color(0x4d000000),
                          fontWeight: FontWeight.w500,
                          maxlines: 1,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      );
//
}
