import '../../service/api_requests.dart';
import '../../service/local/user_info_global.dart';
import '../../utils/app_print.dart';
import '../../utils/helper/stripe_services.dart';

class AppPaymentMethods {
  /// Confirmation Payment API for store record of payment
  static stripeWebhookConfirmPayment(String transactionId) async {
    return await ApiRequests.stripeWebhookConfirmPayment(transactionId);
  }

  /// Calling this api after successfully payment done for buy product/shares
  static _paymentApi({
    required String transactionId,
    required Map<String, dynamic> paymentData,
    required String productId,
    required double amount,
    String? shpingAddressId,
    required double chargeAccount,
    required int type,
    int? shareQty,
  }) async {
    return await ApiRequests.buyAndAddShippingAddress(
      transactionId: transactionId,
      paymentData: paymentData,
      productId: productId,
      amount: amount,
      shpingAddressId: shpingAddressId,
      chargeAccount: chargeAccount,
      type: type,
      shareQty: shareQty,
    );
  }

  // Stripe Payment Default Dialog/UI and Make Payment
  static stripePayment({
    required double amount,
    required String productId,
    required int type,
    String? addressId,
    int? shareQty,
    //Function(transactionId)
    required Function(String) success,
  }) async {
    await StripePaymentService.stripeMakePayment(
      amount: amount.toString(),
      currency: "USD",
      name:
          "${UserStoredInfo().userInfo?.firstName ?? ''} ${UserStoredInfo().userInfo?.firstName ?? ''}",
      email: UserStoredInfo().userInfo?.email,
      phone: UserStoredInfo().userInfo?.phone == null
          ? null
          : "+${UserStoredInfo().userInfo?.countryCode} ${UserStoredInfo().userInfo?.phone}",
      success: (paymentIntent) async {
        // Success
        AppPrint.all("Payment Info: $paymentIntent");
        if (paymentIntent != null) {
          var resp = await _paymentApi(
              transactionId: paymentIntent['id'],
              paymentData: paymentIntent,
              productId: productId,
              amount: (paymentIntent['amount'] ?? 0.0) / 100,
              shpingAddressId: addressId,
              chargeAccount: 5.0,
              type: type,
              shareQty: shareQty);
          if (resp) {
            success(paymentIntent['id']);
          }
        }
      },
    );
  }
}
