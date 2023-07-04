import 'package:flutter/material.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/generated/assets.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CommonAppbarWidget(
            heading: "Notifications",
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          (Image.asset(
                            Assets.assetshirt,
                            height: 40,
                            width: 40,
                          )),
                          const SizedBox(
                            width: 20,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text:
                                    "Men's Tshirt Bidding Time extend for \n15 Minutes",
                                textSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                lineHeight: 1.2,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              AppText(
                                text: "Feb 23, 2023 | 12:00 PM",
                                textSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                                color: Color(0x4d000000),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    )
                  ],
                );
              }),
        )
      ]),
    );
  }
}
