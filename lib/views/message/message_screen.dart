import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/Socket/controller/chat_msg_controller.dart';
import 'package:oninto_flutter/common_widget/app_textfield.dart';
import 'package:oninto_flutter/common_widget/appbar.dart';
import 'package:oninto_flutter/generated/assets.dart';

import '../../common_widget/app_text.dart';
import '../../common_widget/color_constant.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key});

  final ChatMsgController _chatMsgController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppbarWidget(
          heading: 'Men Tshirt',
          textStyle: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, color: Colors.black),
          action: const Icon(Icons.more_vert, color: AppColor.blackColor),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.amber,
              width: 100,
              child: const Text("Hi,How are yo "),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Container(
                    width: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    color: Colors.amber,
                    child: const Text("Hi,How are yo "),
                  );
                },
                itemCount: 5,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Color(0xff1c000000),
                    offset: Offset(0, -10),
                    blurRadius: 30)
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: AppTextField(
                      controller: _chatMsgController.newMessageInput,
                      title: "Type here ……..",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  Image.asset(Assets.assetsAttachment, height: 20, width: 20),
                  const SizedBox(width: 5),
                  InkWell(
                      onTap: () {
                        _chatMsgController.sendNewMessage("5208");
                      },
                      child: const Icon(Icons.send, color: AppColor.appcolor))
                ],
              ),
            )
          ],
        )
        // Column(
        //   children: [
        //     const SizedBox(height: 10),
        //     Expanded(
        //       child: ListView.builder(
        //           physics: const ClampingScrollPhysics(),
        //           itemCount: _chatMsgController.messages.length,
        //           padding: const EdgeInsets.symmetric(horizontal: 10),
        //           itemBuilder: (context, index) {
        //             return messageCard();
        //           }),
        //     ),
        //     Container(
        //       padding: const EdgeInsets.only(left: 20, right: 20),
        //       decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        //         BoxShadow(
        //             color: Color(0xff1c000000),
        //             offset: Offset(0, -10),
        //             blurRadius: 30)
        //       ]),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         children: [
        //           Flexible(
        //             child: AppTextField(
        //               controller: _chatMsgController.newMessageInput,
        //               title: "Type here ……..",
        //               style: const TextStyle(
        //                 fontSize: 12,
        //                 fontWeight: FontWeight.w400,
        //                 fontFamily: "Poppins",
        //               ),
        //             ),
        //           ),
        //           Image.asset(Assets.assetsAttachment, height: 20, width: 20),
        //           const SizedBox(width: 5),
        //           InkWell(
        //               onTap: () {
        //                 _chatMsgController.sendNewMessage("5208");
        //               },
        //               child: const Icon(Icons.send, color: AppColor.appcolor))
        //         ],
        //       ),
        //     )
        //   ],
        // ),
        );
  }

  Widget messageCard() => Container(
        color: Colors.grey,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Get.width * 0.5,
          ),
          child: const SizedBox(
            width: 200,
            child: AppText(
                text:
                    "Hi,How are you ?Hi,How are you ?Hi,How are you ?Hi,How are you ?Hi,How are you ?",
                color: Colors.black,
                textSize: 14),
          ),
        ),
      );

  // Widget messageCardx() {
  //   return Row(
  //     children: [
  //       ClipRRect(
  //         borderRadius: BorderRadius.circular(15),
  //         child: Image.asset(Assets.assetsFashion, height: 50, width: 50),
  //       ),
  //       const SizedBox(width: 10),
  //       ConstrainedBox(
  //         constraints: BoxConstraints(
  //           minWidth: 60,
  //           maxWidth: Get.width * 0.7,
  //         ),
  //         child: Container(
  //           color: Colors.red,
  //           child: const Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Padding(
  //                 padding: EdgeInsets.only(left: 15),
  //                 child: AppText(
  //                   text:
  //                       "Hi,How are you ?Hi,How are you ?Hi,How are you ?Hi,How are you ?Hi,How are you ?",
  //                   color: AppColor.blackColor,
  //                   textSize: 13.0,
  //                   fontWeight: FontWeight.w400,
  //                 ),
  //               ),
  //               SizedBox(height: 10),
  //               AppText(
  //                 text: "11:00AM",
  //                 color: Colors.grey,
  //                 textSize: 13.0,
  //                 fontWeight: FontWeight.w400,
  //               )
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
