import 'package:flutter/material.dart';
import 'package:oninto_flutter/utills/common_appbar.dart';

import '../../../common_widget/appbar.dart';
import '../../../common_widget/color_constant.dart';

class BiddingScreen extends StatelessWidget {
  const BiddingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppbarWidget(
        heading: 'Bidding History',
        textStyle: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: "J*******th",
                            textSize: 15,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                          AppText(
                            text: "\$2100",
                            textSize: 15,
                            color: AppColor.appcolor,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                    Divider()
                  ],
                );
              })
        ],
      ),
    );
  }
}
