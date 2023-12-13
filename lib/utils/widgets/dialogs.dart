import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_widget/app_text.dart';
import 'package:oninto_flutter/common_widget/color_constant.dart';
import 'package:oninto_flutter/common_widget/common_button.dart';
import 'package:oninto_flutter/utils/colors_file.dart';

class AppDialogs {
  static confirm(BuildContext context,
          {required String msg,
          required Function clickOnYes,
          Function? clickOnNo}) =>
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
            type: MaterialType.transparency,
            child: Align(
              child: Container(
                width: 250,
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(25)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    AppText(
                      text: msg,
                      textSize: 15,
                      color: AppColor.blackColor,
                      lineHeight: 1.6,
                      letterSpacing: 0.2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () => clickOnYes(),
                            child: CommonButton(
                              color: AppColor.appcolor,
                              radius: 25,
                              height: 40,
                              text: "Yes",
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                          GestureDetector(
                            onTap: clickOnNo != null
                                ? () => clickOnNo()
                                : () => Get.back(),
                            child: CommonButton(
                              color: AppColor.appcolor,
                              radius: 25,
                              height: 40,
                              text: " No ",
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ),
          );
        },
      );

  static bidHistoryDialog(
      {required Function confirm, required Function seeAll}) {
    print("clicked---- ");
    return showDialog(
        barrierDismissible: true,
        useSafeArea: false,
        context: Get.context!,
        builder: (BuildContext context) {
          return GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Material(
              type: MaterialType.transparency,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
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
                          const SizedBox(height: 10),
                          const AppText(
                            text: "Bid Now",
                            textSize: 15,
                            color: blackColor,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Center(
                          //   child: IntrinsicWidth(
                          //     child: AppTextField(
                          //       textAlign: TextAlign.center,
                          //       textInputType: TextInputType.number,
                          //       inputFormatters: <TextInputFormatter>[
                          //         FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          //       ],
                          //       maxLines: 3,
                          //       containerColor: AppColor.textfield,
                          //       hintStyle: const TextStyle(
                          //         color: AppColor.blackColor,
                          //         fontWeight: FontWeight.w400,
                          //         fontFamily: "Poppins",
                          //       ),
                          //       contentPadding: const EdgeInsets.symmetric(
                          //           vertical: 20,horizontal: 20
                          //       ),
                          //       prefix: const Icon(Icons.attach_money,
                          //         color: AppColor.blackColor,size: 18,),
                          //     ),
                          //   ),
                          // ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.textfield,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: IntrinsicWidth(
                                child: TextField(
                                  cursorColor: AppColor.blackColor,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                      RegExp("[0-9]"),
                                    ),
                                    LengthLimitingTextInputFormatter(5)
                                  ],
                                  keyboardType: TextInputType.number,
                                  textAlignVertical: TextAlignVertical.center,
                                  style: const TextStyle(
                                      color: AppColor.blackColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                  decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 20),
                                      hintText: "2500",
                                      hintStyle: TextStyle(
                                          color: AppColor.blackColor
                                              .withOpacity(0.2),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                      prefixIcon: const Icon(
                                        Icons.attach_money_outlined,
                                        color: AppColor.blackColor,
                                      ),
                                      border: InputBorder.none,
                                      prefixIconConstraints:
                                          const BoxConstraints(
                                        maxWidth: 20,
                                        maxHeight: 40,
                                      )),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const AppText(
                            text: "Minimum \$2000",
                            textSize: 10,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AppText(
                                  text: "Bid History",
                                  textSize: 12,
                                  color: blackColor,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                ),
                                GestureDetector(
                                  onTap: () => seeAll(),
                                  child: const AppText(
                                    text: "See all",
                                    textSize: 10,
                                    color: blackColor,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ListView.builder(
                              itemCount: 5,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return const Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          AppText(
                                            text: "J*******th",
                                            textSize: 15,
                                            fontFamily: "Poppins",
                                            color: blackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          AppText(
                                            text: "\$2100",
                                            textSize: 15,
                                            color: AppColor.appcolor,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider()
                                  ],
                                );
                              }),
                          GestureDetector(
                            onTap: () => confirm(),
                            child: CommonButton(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              color: AppColor.appcolor,
                              text: "Confirm",
                              radius: 15,
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          );
        });
  }
}
