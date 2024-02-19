import 'package:flutter/material.dart';

import '../../../utils/appbar.dart';
import '../../../utils/color_constant.dart';

class MyDashboard extends StatelessWidget {
  const MyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: const CommonAppbarWidget(
        heading: "My Dashboard",
        textStyle: TextStyle(
            fontSize: 20,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins"),
      ),
      body: Container(),
    );
  }
}
