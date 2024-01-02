import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/Socket/model/add_bids_histories.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/utils/common_button.dart';

import '../../generated/assets.dart';

class AppDialogs {
  static confirm(BuildContext context,
          {required String msg,
          required Function clickOnYes,
          Function? clickOnNo,
          Widget? child}) =>
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
                            child: const CommonButton(
                              color: AppColor.appColor,
                              radius: 25,
                              height: 40,
                              text: "Yes",
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          GestureDetector(
                            onTap: clickOnNo != null
                                ? () => clickOnNo()
                                : () => Get.back(),
                            child: const CommonButton(
                              color: AppColor.appColor,
                              radius: 25,
                              height: 40,
                              text: " No ",
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 16),
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

  static simple({Widget? body, bool barrierDismissible = true}) => showDialog(
        context: Get.context!,
        barrierDismissible: barrierDismissible,
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
                    child: body),
              ),
            ),
          );
        },
      );
  static paymentSuccess(Function ok) {
    simple(
        barrierDismissible: false,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Assets.successIcon,
              height: 50,
              width: 50,
            ),
            const SizedBox(height: 14),
            const AppText(
              text: "Payment successfully done",
              color: Colors.green,
              textSize: 18,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 22),
            GestureDetector(
              onTap: () => ok(),
              child: CommonButton(
                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                color: AppColor.appColor,
                radius: 25,
                height: 40,
                text: " Ok ",
                textStyle: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ));
  }

  static bidHistoryDialog(
      {required Function confirm,
      required Function seeAll,
      required AddBidsHistory? bidingData,
      TextEditingController? controller,
      bool? isAddingBid}) {
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
                            color: AppColor.blackColor,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.textField,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Center(
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: controller,
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
                          AppText(
                            text:
                                "Minimum \$${double.parse((bidingData?.save?.bidPrice ?? 0.0).toString()) + 10}",
                            textSize: 10,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Poppins",
                          ),
                          const SizedBox(height: 50),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const AppText(
                                  text: "Bid History",
                                  textSize: 12,
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                ),
                                GestureDetector(
                                  onTap: () => seeAll(),
                                  child: const AppText(
                                    text: "See all",
                                    textSize: 10,
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          ListView.builder(
                              itemCount: (bidingData?.history ?? []).length,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                BidsHistory data =
                                    (bidingData?.history ?? [])[index];
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, right: 20),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: AppText(
                                              text:
                                                  "${data.user?.firstName ?? ''} ${data.user?.lastName ?? ''}",
                                              textSize: 15,
                                              fontFamily: "Poppins",
                                              color: AppColor.blackColor,
                                              fontWeight: FontWeight.w500,
                                              maxlines: 1,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          AppText(
                                            text: "\$${data.bidPrice ?? 0.0}",
                                            textSize: 15,
                                            color: AppColor.appColor,
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider()
                                  ],
                                );
                              }),
                          GestureDetector(
                            onTap:
                                (isAddingBid ?? false) ? null : () => confirm(),
                            child: CommonButton(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              color: AppColor.appColor,
                              text: "Confirm",
                              radius: 15,
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  fontSize: 15,
                                  color: Colors.white),
                              child: (isAddingBid ?? false)
                                  ? const CircularProgressIndicator()
                                  : null,
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
