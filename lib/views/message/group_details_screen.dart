import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/Socket/model/group/group_message_model.dart';
import 'package:oninto_flutter/service/apis.dart';
import 'package:oninto_flutter/service/local/user_info_global.dart';
import 'package:oninto_flutter/utils/app_text.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:oninto_flutter/utils/image_view.dart';

import '../../Socket/controller/chat_msg_controller.dart';
import '../../utils/appbar.dart';

class GroupDetailsScreen extends StatelessWidget {
  GroupDetailsScreen({super.key});
  final ChatMsgController _chatMsgController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppbarWidget(
        headingChild: Text(
          "Details",
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              overflow: TextOverflow.ellipsis),
        ),
        textStyle: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black),
      ),
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Obx(
            () => Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _chatMsgController
                                .activeGroup.value?.productBaseInfo?.name ??
                            '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                //
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: AppText(
                        text:
                            "${(_chatMsgController.groupInfo.value?.group?.groupUser ?? []).length} members",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    GroupUser member =
                        (_chatMsgController.groupInfo.value?.group?.groupUser ??
                            [])[index];
                    bool ventor =
                        _chatMsgController.groupInfo.value?.group?.adminId ==
                            member.userId;
                    bool me = UserStoredInfo().userInfo?.id == member.userId;
                    return memberTile(context, member, ventor, me);
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemCount:
                      (_chatMsgController.groupInfo.value?.group?.groupUser ??
                              [])
                          .length,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget memberTile(
      BuildContext context, GroupUser member, bool ventor, bool me) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppImage.profile(
          context,
          isNetwork: true,
          radius: 30,
          url: "${ImageBaseUrls.profile}${member.user?.image}",
        ),
        const SizedBox(width: 14),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      text:
                          "${member.user?.firstName ?? ''} ${member.user?.lastName ?? ''}",
                    ),
                    const SizedBox(height: 8),
                    AppText(
                      text: member.user?.email ?? '',
                      textSize: 14,
                      color: AppColor.grey,
                    ),
                  ],
                ),
              ),
              SizedBox(width: ventor ? 8 : 0),
              ventor || me
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColor.appColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: AppText(
                        text: me ? "Me" : "Vendor",
                        textSize: 12,
                        color: AppColor.appColor,
                      ))
                  : const SizedBox.shrink(),
            ],
          ),
        )),
      ],
    );
  }
}
