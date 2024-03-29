import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oninto_flutter/Socket/model/add_bids_histories.dart';
import 'package:oninto_flutter/common_controller/home/home_controller.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/date_time_formates.dart';
import 'package:oninto_flutter/utils/empty_widget.dart';

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
            physics: const ClampingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: (_controller.bidingData.value?.history ?? []).isEmpty
                ? EmptyWidgets.simple()
                : _controller.bidingDataLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        children: [
                          const SizedBox(height: 15),
                          ListView.separated(
                              separatorBuilder: (_, __) => const Divider(),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  (_controller.bidingData.value?.history ?? [])
                                      .length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                BidsHistory data =
                                    (_controller.bidingData.value?.history ??
                                        [])[index];
                                return Container(
                                  color: data.id ==
                                          _controller.bidingData.value?.save?.id
                                      ? Colors.green.withOpacity(0.2)
                                      : null,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppText(
                                                text:
                                                    "${data.user?.firstName ?? ''} ${data.user?.lastName ?? ''}",
                                                textSize: 15,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                              ),
                                              const SizedBox(height: 8),
                                              AppText(
                                                text:
                                                    "${AppDateTime.getDateTime(data.createdAt, format: DateFormat('hh:mm a | dd MMM yyyy'))}",
                                                textSize: 12,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey,
                                              ),
                                            ],
                                          ),
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
