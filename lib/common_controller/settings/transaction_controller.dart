import 'package:get/get.dart';
import 'package:oninto_flutter/model/transaction_model.dart';
import 'package:oninto_flutter/service/api_requests.dart';

class TransactionsController extends GetxController {
  var loadingData = false.obs;
  var transactionList = <TransactionModel>[].obs;

  // Functions
  getTransactions() async {
    await ApiRequests.getTransactionsHistory(
      data: (data) {
        transactionList.value = data;
      },
      loading: (loading) {
        loadingData.value = loading;
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    getTransactions();
  }
}
