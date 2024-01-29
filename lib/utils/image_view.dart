import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/utils/app_print.dart';
import 'package:shimmer/shimmer.dart';

import 'color_constant.dart';

class AppImage {
  static Widget view(String url,
      {BoxFit? fit,
      double? height,
      double? width,
      bool errorShow = false,
      bool isProfile = false}) {
    // log("Network Image: $url");
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
                  ? Image.asset(Assets.assetsKids, fit: BoxFit.cover)
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
}
