import 'package:get/get.dart';

class SettingPaymentController extends GetxController{

  final List<Map> data = List.generate(3,
          (index) => {'id': index, 'name': 'Item $index', 'isSelected': false});

}