import 'package:get/get.dart';
import 'package:oninto_flutter/model/settings/dashboard_info_model.dart';
import 'package:oninto_flutter/service/api_requests.dart';

class MyDashboardController extends GetxController {
  var loadingData = false.obs;

  //
  var dashboardInfo = Rx<DashboardInfo?>(null);
  var buySharesAmount = 0.0.obs;
  var buyFixedAmount = 0.0.obs;
  var buyBidAmount = 0.0.obs;
  var totalSharProfies = 0.0.obs;

  getDashboardInfo() async {
    dashboardInfo.value = await ApiRequests.getMyDasboardData(data: (data) {
      dashboardInfo.value = data;
      //
      for (SharePurchaseCount v in (data?.sharePurchaseCount ?? [])) {
        buySharesAmount.value += double.parse("${v.totalAmount ?? 0.0}");
      }
      for (BidProductCount v in (data?.bidProductCount ?? [])) {
        buyBidAmount.value += double.parse("${v.totalAmount ?? 0.0}");
      }
      for (FixedProductCount v in (data?.fixedProductCount ?? [])) {
        buyFixedAmount.value += double.parse("${v.totalAmount ?? 0.0}");
      }
      for (TotalShareProfilt v in (data?.totalShareProfilt ?? [])) {
        totalSharProfies.value += double.parse("${v.totalProfit ?? 0.0}");
      }
    }, loading: (loading) {
      loadingData.value = loading;
    });
  }

  @override
  void onInit() {
    super.onInit();
    getDashboardInfo();
  }
}
