//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class AppDropdown extends StatelessWidget {
//   ValueChanged<dynamic>? onChanged;
//   List<dynamic>? items;
//   String? hinttext;
//   Widget? dropDownButton;
//   final dropdownButtonProps;
//   AppDropdown({Key? key,
//     required this.onChanged,
//     required this.items,
//     required this.hinttext,
//     this.dropDownButton,
//     this.dropdownButtonProps,
//
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 55,
//       width: Get.width,
//       decoration: const BoxDecoration(
//          // color: dropdowncolor,
//           borderRadius: BorderRadius.all(Radius.circular(19))
//       ),
//       child: DropdownSearch<dynamic>(
//       dropdownDecoratorProps: DropDownDecoratorProps(
//           dropdownSearchDecoration: InputDecoration(
//               contentPadding: const EdgeInsets.only(left: 15,top: 15),
//               disabledBorder: InputBorder.none,
//               focusedBorder: InputBorder.none,
//               enabledBorder:InputBorder.none,
//               border: InputBorder.none,
//               hintText: hinttext??"Please Select"
//           )),
//       popupProps: PopupProps.menu(
//         constraints: const BoxConstraints(maxHeight: 180,),
//         menuProps: MenuProps(
//           shape: UnderlineInputBorder(
//             borderRadius: BorderRadius.circular(22),
//             borderSide:  BorderSide.none,),),),
//       dropdownButtonProps: dropdownButtonProps??const DropdownButtonProps(icon: Icon(Icons.arrow_drop_down_sharp,size: 25,)),
//       onChanged: onChanged,
//       items:items!,
//     ),
//     );
//   }
// }
