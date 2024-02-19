// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/appbar.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/utils/date_time_formates.dart';
import 'package:oninto_flutter/utils/empty_widget.dart';
import 'package:oninto_flutter/views/bid_screen/notification_model.dart';

import '../../common_controller/home/home_controller.dart';
import '../../utils/shimmer_widget.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key}) {
    controller.loadingNotification.value = false;
    controller.getNotificationListing();
  }

  final HomeCatProductController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CommonAppbarWidget(
        heading: "Notifications",
        textStyle: TextStyle(
            fontSize: 18,
            fontFamily: "Poppins",
            color: Colors.black,
            fontWeight: FontWeight.w500),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.getNotificationListing();
        },
        child: Obx(
          () => controller.loadingNotification.value
              ? ShimmerWidgets.listView()
              : controller.notificationList.isEmpty
                  ? EmptyWidgets.simple()
                  : SizedBox(
                      height: double.infinity,
                      child: ListView.separated(
                        itemCount: controller.notificationList.length,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        itemBuilder: (context, index) {
                          var data = controller.notificationList[index];
                          return notificationTile(
                            data,
                            delete: () {
                              controller.isSelectedNotification.value = index;
                              controller.deleteNotification(
                                  notificationId: "${data.id}");
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 15,
                          );
                        },
                      ),
                    ),
        ),
      ),
    );
  }

  Widget notificationTile(NotificationModel data, {required Function delete}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey.shade100,
      child: Slidable(
        endActionPane: ActionPane(
          dragDismissible: false,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                delete();
              },
              spacing: 0,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(12),
              label: 'Delete',
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(Assets.assetsBack, height: 50, width: 50),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(text: data.message ?? "", textSize: 11),
                  const SizedBox(height: 10),
                  AppText(
                    text:
                        "${AppDateTime.getDateTime(data.createdAt, format: DateFormat("MMM dd yyyy | hh:mm a"))}",
                    textSize: 10,
                    color: AppColor.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
