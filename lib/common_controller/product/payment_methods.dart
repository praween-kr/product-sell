import 'package:oninto_flutter/utils/app_print.dart';

import '../../service/api_requests.dart';
import '../../service/local/user_info_global.dart';
import '../../utils/app_toast_loader.dart';
import '../../utils/helper/stripe_services.dart';

class AppPaymentMethods {
  /// Confirmation Payment API for store record of payment
  // static stripeWebhookConfirmPayment(String transactionId) async {
  //   return await ApiRequests.stripeWebhookConfirmPayment(transactionId);
  // }

  /// Calling this api after successfully payment done for buy product/shares
  static _paymentApi(
      {required String productId,
      required double amount,
      String? shpingAddressId,
      required double chargeAccount,
      required int type,
      int? shareQty,
      required Function(Map<String, dynamic>?) intentData}) async {
    await ApiRequests.buyAndAddShippingAddress(
        productId: productId,
        amount: amount,
        shpingAddressId: shpingAddressId,
        chargeAccount: chargeAccount,
        type: type,
        shareQty: shareQty,
        intentData: (data) {
          intentData(data);
        });
  }

  // Stripe Payment Default Dialog/UI and Make Payment
  static stripePayment({
    required double amount,
    required String productId,
    required int type,
    String? shpingAddressId,
    int? shareQty,
    required Function(String?) success,
  }) async {
    if (amount <= 0) {
      AppToast.show("Please add amount");
      return;
    } else if ((amount.toString())[0] == '0') {
      AppToast.show("Please enter valid amount");
      return;
    }
    await _paymentApi(
        productId: productId,
        amount: amount,
        shpingAddressId: shpingAddressId,
        chargeAccount: 5.0,
        type: type,
        shareQty: shareQty,
        intentData: (intentdata) async {
          if (intentdata != null && intentdata['paymentIntent'] != null) {
            AppPrint.all("Payment Intent API Call:: --> $intentdata");
            await StripePaymentService.stripeMakePayment(
              amount: amount.toString(),
              currency: "USD",
              name:
                  "${UserStoredInfo().userInfo?.firstName ?? ''} ${UserStoredInfo().userInfo?.firstName ?? ''}",
              email: UserStoredInfo().userInfo?.email,
              phone: UserStoredInfo().userInfo?.phone == null
                  ? null
                  : "+${UserStoredInfo().userInfo?.countryCode} ${UserStoredInfo().userInfo?.phone}",
              success: () async {
                success(intentdata['paymentIntent']['id']);
              },
              paymentIntent: intentdata['paymentIntent'],
            );
          }
        });
  }
}
