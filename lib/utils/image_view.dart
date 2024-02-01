import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/utils/app_print.dart';
import 'package:shimmer/shimmer.dart';

import 'color_constant.dart';
import 'helper/file_picker.dart';

class AppImage {
  static Widget view(String url,
      {BoxFit? fit,
      double? height,
      double? width,
      bool errorShow = false,
      bool isProfile = false}) {
    return Container(
      height: height,
      width: width,
      color: Colors.grey.shade100,
      child: CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) => Center(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.grey.shade100,
            child: SizedBox(height: height, width: width),
          ),
        ),
        fit: fit,
        errorWidget: (context, url, error) {
          AppPrint.error("Image View Error: $error");
          return Center(
            child: Container(
              height: height,
              width: width,
              color: Colors.grey.shade200,
              child: isProfile
                  ? Image.asset(Assets.assetsPersonIcon, fit: BoxFit.cover)
                  : errorShow
                      ? const Center(
                          child: Text(
                              'No Image'), //Lottie.asset(AssetsLottie.noimage)
                        )
                      : const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }

  static void viewFull(String url) {
    Get.to(
      () => Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            SafeArea(
              child: Center(
                child: view(url, errorShow: true),
              ),
            ),
            Positioned(
                top: 90,
                left: 20,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child:
                          Icon(Icons.arrow_back, color: AppColor.themeColor)),
                ))
          ],
        ),
      ),
    );
  }

//   static Future viewUrl(String url) async {
//     await _launchUrl(url);
//   }

//   static Future<void> _launchUrl(String url) async {
//     final Uri url0 = Uri.parse(url);

//     if (!await launchUrl(url0)) {
//       throw Exception('Could not launch $url0');
//     }
//   }

  static Widget profile(BuildContext context,
      {Function(String? value)? onChanged,
      double? radius,
      Function? onClick,
      required String? url,
      bool isNetwork = false,
      bool viewOnly = true,
      bool showEditIcon = false}) {
    return GestureDetector(
      onTap: viewOnly
          ? null
          : onChanged != null
              ? () {
                  AppPicker().image(
                    (path, type, _) {
                      onChanged(path);
                    },
                    hideFile: true,
                    hideVideo: true,
                  );
                }
              : onClick != null
                  ? () => onClick()
                  : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 2, bottom: 2),
            height: radius == null ? context.width * 0.2 : radius * 2,
            width: radius == null ? context.width * 0.2 : radius * 2,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColor.greylight,
              borderRadius: BorderRadius.circular(context.width * 0.2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(context.width * 0.2),
              child: (url ?? '') != ''
                  ? isNetwork
                      ? view(url ?? '', fit: BoxFit.cover, isProfile: true)
                      : Image.file(
                          File(url ?? ''),
                          fit: BoxFit.cover,
                        )
                  : Image.asset(
                      Assets.assetsPersonIcon,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          viewOnly
              ? const SizedBox.shrink()
              : showEditIcon
                  ? const Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        backgroundColor: AppColor.appColor,
                        radius: 14,
                        child: Icon(
                          Icons.edit,
                          color: AppColor.white,
                          size: 18,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
          viewOnly
              ? const SizedBox.shrink()
              : const Positioned(
                  child: Icon(
                    Icons.camera_alt,
                    color: AppColor.grey,
                    size: 28,
                  ),
                ),
        ],
      ),
    );
  }
}
