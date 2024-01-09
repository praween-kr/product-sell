// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:oninto_flutter/utils/app_text.dart';
// import 'package:oninto_flutter/utils/appbar.dart';
// import 'package:oninto_flutter/utils/color_constant.dart';
// import 'package:oninto_flutter/utils/common_button.dart';

// import '../../../generated/assets.dart';
// import '../../../utils/app_text_field.dart';

// class GyaradoMsgScreen extends StatelessWidget {
//   const GyaradoMsgScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.white,
//       appBar: CommonAppbarWidget(
//           heading: "Message",
//           textStyle: const TextStyle(
//               fontSize: 20,
//               color: AppColor.blackColor,
//               fontWeight: FontWeight.w500,
//               fontFamily: "Poppins"),
//           action: GestureDetector(
//             onTap: () {
//               customDialog(context);
//             },
//             child: Container(
//               margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//               decoration: BoxDecoration(
//                   color: AppColor.white,
//                   boxShadow: [
//                     BoxShadow(
//                         color: AppColor.borderColor.withOpacity(0.3),
//                         blurRadius: 6)
//                   ],
//                   borderRadius: BorderRadius.circular(20.0)),
//               child: const Center(
//                 child: Icon(
//                   Icons.bar_chart_rounded,
//                   color: AppColor.appColor,
//                   size: 40.0,
//                 ),
//               ),
//             ),
//           )),
//       body: Column(
//         children: [
//           Expanded(
//               child: ListView.builder(
//                   itemCount: 1,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(
//                           left: 30.0, top: 28.0, bottom: 20.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const AppText(
//                             text: "John Smith",
//                             textSize: 15,
//                             color: AppColor.blackColor,
//                             style: AppTextStyle.medium,
//                           ),
//                           const SizedBox(height: 7),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 15.0, vertical: 20.0),
//                             decoration: BoxDecoration(
//                                 color: AppColor.chatColor,
//                                 borderRadius: BorderRadius.circular(12)),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 const AppText(
//                                   text: "Hello how are you ?",
//                                   textSize: 11,
//                                   color: AppColor.white,
//                                   style: AppTextStyle.medium,
//                                 ),
//                                 const SizedBox(
//                                   height: 8,
//                                 ),
//                                 AppText(
//                                   text: "10:11am",
//                                   textSize: 10,
//                                   color: AppColor.white.withOpacity(0.3),
//                                   style: AppTextStyle.regular,
//                                 ),
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                     );
//                   })),
//           Container(
//             padding: const EdgeInsets.only(left: 20, right: 20),
//             decoration: const BoxDecoration(color: Colors.white, boxShadow: [
//               BoxShadow(
//                   color: Color(0xff1c000000),
//                   offset: Offset(0, -10),
//                   blurRadius: 30)
//             ]),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 const Flexible(
//                   child: AppTextField(
//                     title: "Type here ……..",
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       fontFamily: "Poppins",
//                     ),
//                   ),
//                 ),
//                 Image.asset(Assets.assetsAttachment, height: 20, width: 20),
//                 const SizedBox(width: 5),
//                 const Icon(Icons.send, color: AppColor.appColor),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }


// }
