// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class CardSwapperController extends GetxController {
// //--
// }

// class DragTargetWidget extends StatelessWidget {
//   const DragTargetWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DragTarget(onWillAccept: (data) {
//       return true;
//     }, onAccept: (CardItem data) {
//       if (Provider.of<Data>(context).itemsList.length >= 1) {
//         Provider.of<Data>(context).removeLastItem();
//         Provider.of<Data>(context).changeSuccessDrop(true);
//         Provider.of<Data>(context).changeAcceptedData(data);
//       }
//     }, builder: (context, List<CardItem> cd, rd) {
//       if (Provider.of<Data>(context).isSuccessDrop) {
//         return Padding(
//           padding: const EdgeInsets.all(25.0),
//           child: Stack(
//             children:
//                 buildTargetList(Provider.of<Data>(context).getAcceptedData),
//           ),
//         );
//       } else {
//         return Padding(
//           padding: const EdgeInsets.all(25.0),
//           child: DottedBorder(
//             color: Colors.black,
//             gap: 3,
//             strokeWidth: 1,
//             child: Container(
//                 height: 200.0,
//                 width: 200.0,
//                 color: Colors.grey[400],
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5)),
//                   color: Colors.grey[400],
//                   child: const Center(
//                     child: Text(
//                       DROP_ITEMS_HERE,
//                       style: TextStyle(color: Colors.black, fontSize: 22.0),
//                     ),
//                   ),
//                 )),
//           ),
//         );
//       }
//     });
//   }

//   List<Widget> buildTargetList(CardItem cardItem) {
//     List<Widget> targetList = [];
//     targetList.add(
//       DottedBorder(
//         gap: 3,
//         strokeWidth: 1,
//         color: Colors.black,
//         child: SizedBox(
//           height: 200.0,
//           width: 200.0,
//           child: Card(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0)),
//             color: cardItem.cardColor,
//             child: Center(
//                 child: Text(
//               cardItem.content,
//               style: const TextStyle(fontSize: 25.0, color: WHITE_COLOR),
//             )),
//           ),
//         ),
//       ),
//     );
//     return targetList;
//   }
// }

// //-----

// const Color GRAY_COLOR = Colors.grey;
// const Color BROWN_COLOR = Colors.brown;
// const Color RED_COLOR = Colors.red;
// const Color ORANGE_COLOR = Colors.orange;
// const Color BLUE_COLOR = Colors.blue;
// const Color GREEN_COLOR = Colors.green;
// const Color WHITE_COLOR = Colors.white;

// //---
// const String APP_BAR_TITLE = 'Drag & Drop Demo';
// const String NO_ITEMS_LEFT = 'No Items Left';
// const String JAVA = 'Java';
// const String PHP = 'PHP';
// const String KOTLIN = 'Kotlin';
// const String FLUTTER = 'Flutter';
// const String NODEJS = 'Nodejs';
// const DROP_ITEMS_HERE = 'Drop Items Here';

// //--
// class Constants {
//   static String SPLASH_SCREEN = 'SPLASH_SCREEN';
//   static String HOME_SCREEN = 'HOME_SCREEN';

//   static List<CardItem> initializeList(List<CardItem> itemList) {
//     itemList = [
//       CardItem(content: JAVA, cardColor: BROWN_COLOR, margin: null),
//       CardItem(content: PHP, cardColor: RED_COLOR),
//       CardItem(content: KOTLIN, cardColor: ORANGE_COLOR),
//       CardItem(content: FLUTTER, cardColor: BLUE_COLOR),
//       CardItem(content: NODEJS, cardColor: GREEN_COLOR),
//     ];

//     return itemList;
//   }
// }

// //--
// class CardItem {
//   String content;
//   Color cardColor;
//   double margin;

//   CardItem(
//       {required this.content, required this.cardColor, required this.margin});
// }
