import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/common_controller/home_controller.dart';
import 'package:swipable_stack/swipable_stack.dart';
import '../../common_widget/app_text.dart';
import '../../common_widget/color_constant.dart';
import '../../generated/assets.dart';

class HomeBidScreen extends StatelessWidget {
  HomeBidScreen({
    Key? key,
  }) : super(key: key);
  final controller = Get.put(Homecontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 60,
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppText(
                      text: "  Hello, jenny",
                      textSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.amberAccent,
                        ),
                        AppText(
                          text: "Street albert, california",
                          textSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0x80000000),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        margin: const EdgeInsets.only(
                          right: 7,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColor.appcolor),
                        ),
                        child: GestureDetector(
                          onTap: () {},
                          child: const Icon(Icons.filter_alt_rounded,
                              color: AppColor.appcolor),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: AppColor.appcolor,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.add),
              Container(
                height: 30,
                width: 30,
                margin: const EdgeInsets.only(
                  right: 7,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.appcolor),
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.filter_alt_rounded,
                      color: AppColor.appcolor),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SwipableStack(
                builder: (context, properties) {
                  return Image.asset(Assets.assetsHomeBid);
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
