import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/utils/color_constant.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidgets {
  static cardDecoration({double radius = 0, bool shdow = true, Color? color}) =>
      BoxDecoration(
          color: color ?? Colors.white,
          boxShadow: shdow
              ? [
                  BoxShadow(
                      color: Colors.grey.shade400.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 10)
                ]
              : null,
          borderRadius: BorderRadius.all(Radius.circular(radius)));

  static Widget listView(
          {bool scrollHide = false,
          bool withoutImage = false,
          int textLine = 3,
          double imgRadius = 90,
          bool circularImg = false}) =>
      ListView.separated(
        shrinkWrap: scrollHide,
        physics: scrollHide
            ? const NeverScrollableScrollPhysics()
            : const ClampingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, index) => Container(
          margin: const EdgeInsets.only(left: 14, right: 14, top: 14),
          decoration: cardDecoration(radius: 20),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            children: [
              withoutImage
                  ? const SizedBox.shrink()
                  : card(
                      w: imgRadius,
                      h: imgRadius,
                      radius: circularImg ? imgRadius : null),
              const SizedBox(width: 14),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: textLine == 2
                    ? [
                        text(w: Get.width * 0.35),
                        text(w: Get.width * 0.2),
                        // text(w: Get.width * 0.2),
                      ]
                    : [
                        text(w: Get.width * 0.2),
                        text(w: Get.width * 0.1),
                        text(w: Get.width * 0.3),
                        // text(w: Get.width * 0.2),
                      ],
              )
            ],
          ),
        ),
        separatorBuilder: (_, __) => const SizedBox(height: 0),
        itemCount: 4,
      );

  /// Grid view
  static Widget gridView(
          {int count = 12, ScrollPhysics? physics, bool shrinkWrap = false}) =>
      GridView.builder(
        shrinkWrap: shrinkWrap,
        physics: physics ??
            const ClampingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 0.75),
        itemCount: count,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    card(h: Get.width * 0.24),
                    card(h: Get.width * 0.22, color: AppColor.white, p: 2),
                    card(h: Get.width * 0.19, p: 8),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: text(h: 10),
                ),
              ],
            ),
          );
        },
      );

  static Widget productGridView(
          {int count = 6, ScrollPhysics? physics, bool shrinkWrap = false}) =>
      GridView.builder(
        shrinkWrap: shrinkWrap,
        physics: physics ??
            const ClampingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.75),
        itemCount: count,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    card(h: Get.width * 0.5),
                    card(h: Get.width * 0.48, color: AppColor.white, p: 2),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          card(h: Get.width * 0.3),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                text(h: 8, w: Get.width * 0.2),
                                text(h: 8, w: 25),
                              ],
                            ),
                          ),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: text(h: 8, w: Get.width * 0.26)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );

  static Widget productListView({bool scrollHide = false, int textLine = 3}) =>
      ListView.separated(
        shrinkWrap: scrollHide,
        physics: scrollHide
            ? const NeverScrollableScrollPhysics()
            : const ClampingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              card(w: double.infinity, h: 170, radius: 14),
              const SizedBox(width: 14),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      text(w: Get.width * 0.2),
                      Icon(Icons.favorite,
                          color: Colors.grey.shade300, size: 28),
                    ],
                  ),
                  text(w: Get.width * 0.1),
                  text(w: Get.width * 0.3),
                ],
              )
            ],
          ),
        ),
        separatorBuilder: (_, __) => const SizedBox(height: 0),
        itemCount: 3,
      );

  /// Home shimmer
  static home() => SingleChildScrollView(
        physics: const ClampingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  card(h: 42, w: double.infinity),
                  card(
                      h: 35,
                      w: double.infinity,
                      p: 8,
                      color: Colors.white.withOpacity(0.5)),
                ],
              ),
            ),
            card(h: Get.height * 0.22, w: double.infinity, radius: 0),
            const SizedBox(height: 14),
            gridView(
              count: 6,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
            ),
          ],
        ),
      );

  /// Product Details shimmer
  static product() => SingleChildScrollView(
        physics: const ClampingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            Stack(
              children: [
                card(h: Get.height * 0.35, w: double.infinity, radius: 0),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: SizedBox(
                                  width: 70,
                                  child: Stack(
                                    children: [
                                      card(h: 70, color: AppColor.white),
                                      card(h: 67, p: 2),
                                    ],
                                  ),
                                ),
                              )),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(w: Get.width * 0.3, h: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          7,
                          (index) => text(
                              w: index == 6 ? Get.width * 0.5 : double.infinity,
                              h: 12,
                              color: Colors.grey.shade200)),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(flex: 1, child: text(h: 12)),
                  SizedBox(width: Get.width * 0.15),
                  Expanded(flex: 1, child: text(h: 12)),
                ],
              ),
            )
          ],
        ),
      );

  /// Single Line List View

  ////============================
  static Widget text({
    double? w,
    double? h,
    Color? color,
  }) =>
      Shimmer.fromColors(
        baseColor: color ?? Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: h ?? 14,
          width: w,
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: color ?? Colors.grey.shade300,
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
        ),
      );
  static Widget favourite({
    double? s,
    Color? color,
  }) =>
      Shimmer.fromColors(
        baseColor: color ?? Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Icon(
          Icons.favorite,
          color: color ?? Colors.grey.shade300,
          size: s,
        ),
      );
  static Widget card(
          {double? w,
          double? h,
          Color? color,
          Color? colorAnimated,
          double? radius,
          double p = 0.0,
          Widget? child}) =>
      Shimmer.fromColors(
        baseColor: color ?? Colors.grey.shade300,
        highlightColor: colorAnimated ?? Colors.grey.shade100,
        child: Padding(
          padding: EdgeInsets.all(p),
          child: Container(
            height: h,
            width: w,
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: color ?? Colors.grey.shade300,
              borderRadius: BorderRadius.all(
                Radius.circular(radius ?? 20),
              ),
            ),
            child: child,
          ),
        ),
      );
}
