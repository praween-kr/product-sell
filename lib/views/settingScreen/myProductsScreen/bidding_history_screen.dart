import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/Socket/model/add_bids_histories.dart';
import 'package:oninto_flutter/common_controller/home/home_controller.dart';
import 'package:oninto_flutter/utils/app_text.dart';

import '../../../utils/appbar.dart';
import '../../../utils/color_constant.dart';

class BiddingHistoryScreen extends StatelessWidget {
  BiddingHistoryScreen({super.key});

  final HomeCatProductController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppbarWidget(
        heading: 'Bidding History',
        textStyle: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () async {
            await _controller.getBidHistories(
                productId:
                    (_controller.productDetailsData.value?.details?.id ?? '')
                        .toString());
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: _controller.bidingDataLoading.value
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      const SizedBox(height: 15),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              (_controller.bidingData.value?.history ?? [])
                                  .length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            BidsHistory data =
                                (_controller.bidingData.value?.history ??
                                    [])[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppText(
                                        text:
                                            "${data.user?.firstName ?? ''} ${data.user?.lastName ?? ''}",
                                        textSize: 15,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                      ),
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
                          })
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
