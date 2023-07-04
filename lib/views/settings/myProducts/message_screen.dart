import 'package:flutter/material.dart';
import 'package:oninto_flutter/common_widget/app_textfield.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/generated/assets.dart';

import '../../../common_widget/app_text.dart';
import '../../../common_widget/color_constant.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(
        heading: 'Men Tshirt',
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                itemCount: 8,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  return index % 2 == 1
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          constraints: const BoxConstraints(),
                                          padding: const EdgeInsets.only(
                                              left: 15,
                                              right: 15,
                                              top: 15,
                                              bottom: 10),
                                          margin: const EdgeInsets.only(
                                              top: 10, bottom: 20),
                                          decoration: const BoxDecoration(
                                              color: Color(0xff3F3F3F),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  // Image.asset(
                                                  //   Assets.assetsReviewlist,
                                                  //   height: 40,
                                                  //   width: 40,
                                                  // ),
                                                  AppText(
                                                    text: "Great!!",
                                                    color: Colors.white,
                                                    textSize: 13.0,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(top: 60),
                                          child: AppText(
                                            text: "10:20AM",
                                            textSize: 9,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Poppins",
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      // Image.asset(
                                      //   Assets.assetsReviewlist,
                                      //   height: 40,
                                      //   width: 40,
                                      // ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        constraints: const BoxConstraints(),
                                        padding: const EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 15,
                                            bottom: 15),

                                        margin: const EdgeInsets.only(left: 10),
                                        // decoration: const BoxDecoration(
                                        //     color: AppColor.splashcolor,
                                        //     borderRadius: BorderRadius.all(
                                        //         Radius.circular(10))),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Image.asset(
                                                    Assets.assetsFashion,
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                const Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 15),
                                                      child: AppText(
                                                        text:
                                                            "Hi,How are you ?",
                                                        color:
                                                            AppColor.blackColor,
                                                        textSize: 13.0,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    AppText(
                                                      text: "11:00AM",
                                                      color: Colors.grey,
                                                      textSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                }),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Color(0xff1C000000),
                  offset: Offset(0, -10),
                  blurRadius: 30)
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  child: AppTextField(
                    title: "Type here ……..",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                Image.asset(
                  Assets.assetsattachment,
                  height: 20,
                  width: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  Icons.send,
                  color: AppColor.appcolor,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
