import 'package:flutter/material.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';
import 'package:swipe_to/swipe_to.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(
        heading: "Notifications",
        textStyle: const TextStyle(
            fontSize: 18,
            fontFamily: "Poppins",
            color: Colors.black,
            fontWeight: FontWeight.w500),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            Expanded(
              child: SwipeTo(
                child: ListView.builder(
                    itemCount: 8,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Image.asset(
                              Assets.assetsBack,
                              height: 50,
                              width: 50,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                    text:
                                        "Men's Tshirt Bidding Time extend for 15 Minutes",
                                    textSize: 11),
                                SizedBox(height: 10),
                                AppText(
                                    text: "Feb 23, 2023 | 12:00 PM",
                                    textSize: 10),
                              ],
                            ),
                          ],
                        ),
                      );
                    }),
                // onLeftSwipe: () {
                //   const Icon(
                //     Icons.delete,
                //     color: Colors.red,
                //   );
                // },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
