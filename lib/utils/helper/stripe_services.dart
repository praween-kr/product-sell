import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/utils/color_constant.dart';

import '../app_toast_loader.dart';

class StripePaymentService {
  //Singleton pattern
  static final StripePaymentService _stripePaymentService =
      StripePaymentService._internal();

  factory StripePaymentService() {
    return _stripePaymentService;
  }

  StripePaymentService._internal();

  static Map<String, dynamic>? paymentIntent;

  static final _dio = Dio();

  static String stripeTestKey =
      "pk_test_51Iy9mmSHUZtgmXhRe50T8kUlQ12fvx2vPJwAH7evpvq4DiDiqE9DgHr17cGNXcVSGmIp8IRP6xYghuJhtGl64gOP006VrHNug2";
  static String stripeLiveKey = "";

  static String stripeSecretKey =
      "sk_test_51Iy9mmSHUZtgmXhRc7FGXiRrT2wlIQSbY2Ny85kIcFnm5xg4lhC1meTIjofJ8dIJhQyTSRRidbGC1Y8dSSEEc2Mj00IvkUE7f6";

  Future<void> init() async {
    Stripe.publishableKey = stripeTestKey;
    await Stripe.instance.applySettings();
  }

  static Future<void> stripeMakePayment(
      {String? amount,
      String? currency,
      String? name,
      String? email,
      String? city,
      String? country,
      String? line1,
      String? line2,
      String? postalCode,
      String? state,
      String? phone,
      required Function success}) async {
    try {
      // 1. Gather customer billing information (ex. email)
      var billingDetails = BillingDetails(
          name: name,
          email: email,
          phone: phone,
          address: Address(
              city: city,
              country: country,
              line1: line1,
              line2: line2,
              postalCode: postalCode,
              state: state));
      paymentIntent =
          await createPaymentIntent(amount ?? "0.0", currency ?? 'INR');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            billingDetails: billingDetails,
            paymentIntentClientSecret: paymentIntent!['client_secret'],
            //Gotten from payment intent
            style: ThemeMode.light,
            merchantDisplayName: 'Ownitoo',
            // Extra params
            // primaryButtonLabel: 'Pay now',
            appearance: const PaymentSheetAppearance(
              colors: PaymentSheetAppearanceColors(
                background: Colors.white,
                primary: AppColor.appColor,
                componentBorder: AppColor.appColor,
              ),
              shapes: PaymentSheetShape(
                borderWidth: 1,
                shadow: PaymentSheetShadowParams(color: AppColor.appColor),
              ),
              primaryButton: PaymentSheetPrimaryButtonAppearance(
                shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
                colors: PaymentSheetPrimaryButtonTheme(
                  light: PaymentSheetPrimaryButtonThemeColors(
                    background: Colors.white,
                    text: AppColor.appColor,
                    border: Colors.white,
                  ),
                ),
              ),
            ),
          ))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet(success);
    } catch (e) {
      errorSnackBar(e.toString());
    }
  }

  static Future<void> stripePayment(
      {required String cardNumber,
      required String cvc,
      required String expiryDate,
      String? amount,
      String? currency,
      List<String>? items,
      String? name,
      String? email,
      String? city,
      String? country,
      String? line1,
      String? line2,
      String? postalCode,
      String? state,
      String? phone,
      required Function success}) async {
    var prAge = expiryDate.split("/");
    var month = prAge[0].trim();
    var year = prAge[1].trim();
    await Stripe.instance.dangerouslyUpdateCardDetails(CardDetails(
      number: cardNumber,
      expirationYear: int.parse(year),
      expirationMonth: int.parse(month),
      cvc: cvc,
    ));

    try {
      // 1. Gather customer billing information (ex. email)
      var billingDetails = BillingDetails(
          name: name,
          email: email,
          phone: phone,
          address: Address(
              city: city,
              country: country,
              line1: line1,
              line2: line2,
              postalCode: postalCode,
              state: state));

      // 2. Create payment method
      final paymentMethod = await Stripe.instance.createPaymentMethod(
          params: PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(
          billingDetails: billingDetails,
        ),
      ));

      // 3. call API to create PaymentIntent
      final paymentIntentResult = await callNoWebhookPayEndpointMethodId(
          useStripeSdk: true,
          paymentMethodId: paymentMethod.id,
          currency: currency ?? "INR", // mocked data
          items: items);

      if (paymentIntentResult['error'] != null) {
        // Error during creating or confirming Intent
        errorSnackBar('Error: ${paymentIntentResult['error']}');
        return;
      }

      if (paymentIntentResult['clientSecret'] != null &&
          paymentIntentResult['requiresAction'] == null) {
        // Payment success

        errorSnackBar('Success!: The payment was confirmed successfully!');
        return;
      }

      if (paymentIntentResult['clientSecret'] != null &&
          paymentIntentResult['requiresAction'] == true) {
        // 4. if payment requires action calling handleNextAction
        final paymentIntent = await Stripe.instance
            .handleNextAction(paymentIntentResult['clientSecret']);

        if (paymentIntent.status == PaymentIntentsStatus.RequiresConfirmation) {
          // 5. Call API to confirm intent
          await confirmIntent(paymentIntent.id);
        } else {
          // Payment success
          errorSnackBar('Error: ${paymentIntentResult['error']}');
        }
      }
    } catch (e) {
      errorSnackBar(e.toString());
    }
  }

  static Future<void> confirmIntent(String paymentIntentId) async {
    final result = await callNoWebhookPayEndpointIntentId(
        paymentIntentId: paymentIntentId);
    if (result['error'] != null) {
      errorSnackBar('Error: ${result['error']}');
    } else {
      errorSnackBar('Success!: The payment was confirmed successfully!');
    }
  }

  static Future<Map<String, dynamic>> callNoWebhookPayEndpointIntentId({
    required String paymentIntentId,
  }) async {
    Map<String, dynamic> data = {'paymentIntentId': paymentIntentId};
    final response = await _dio.post(
      "https://api.stripe.com/v1/charge-card-off-session",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      data: data,
    );
    return response.data;
  }

  static Future<Map<String, dynamic>> callNoWebhookPayEndpointMethodId({
    required bool useStripeSdk,
    required String paymentMethodId,
    required String currency,
    List<String>? items,
  }) async {
    Map<String, dynamic> data = {
      'useStripeSdk': useStripeSdk,
      'paymentMethodId': paymentMethodId,
      'currency': currency,
      'items': items
    };
    final response = await _dio.post(
      "https://api.stripe.com/v1/pay-without-webhooks",
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
      data: data,
    );
    return response.data;
  }

  /// 00008101-0006791A2651001E
  /// iPhone 13,2 / 19H12

  static displayPaymentSheet(Function success) async {
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet(
          options: const PaymentSheetPresentOptions(timeout: 1200000));

      errorSnackBar('Payment successfully completed');
      success();
    } on Exception catch (e) {
      if (e is StripeException) {
        errorSnackBar('Error from Stripe: ${e.error.localizedMessage}');
      } else {
        errorSnackBar('Unforeseen error: $e');
      }
    }
  }

  //create Payment
  static createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await _dio.post(
        "https://api.stripe.com/v1/payment_intents",
        options: Options(
          headers: {
            'Authorization': 'Bearer $stripeSecretKey',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
        ),
        data: body,
      );
      log("response ${response.toString()}");
      return response.data;
    } catch (err) {
      throw Exception(err.toString());
    }
  }

//calculate Amount
  static calculateAmount(String amount) {
    final calculatedAmount = (double.parse(amount)) * 100;
    return calculatedAmount.toStringAsFixed(0);
  }

  //generate token
  static Future<String?> generateStripeToken(
      {required String cardNumber,
      required String? cardHolderName,
      required String expiryDate,
      required String cvv}) async {
    AppLoader.show();
    // This is used to separate month and year
    var prAge = expiryDate.split("/");
    var month = prAge[0].trim();
    var year = prAge[1].trim();

    CardTokenParams cardParams = CardTokenParams(
      type: TokenType.Card,
      name: cardHolderName,
    );

    await Stripe.instance.dangerouslyUpdateCardDetails(CardDetails(
      number: cardNumber,
      cvc: cvv,
      expirationMonth: int.tryParse(month),
      expirationYear: int.tryParse("${(DateTime.now().year ~/ 100)}$year"),
    ));

    try {
      TokenData token = await Stripe.instance.createToken(
        CreateTokenParams.card(params: cardParams),
      );
      AppLoader.hide();
      return token.id;
    } on StripeException catch (e) {
      AppLoader.hide();
      errorSnackBar(e.error.message);
    }
    return null;
  }

  static errorSnackBar(String? message) {
    if (message == null) {
      return;
    }
    Get.closeAllSnackbars();
    Get.snackbar(
      "App Name",
      message,
      padding: const EdgeInsets.only(left: 20, top: 12),
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      backgroundColor: Colors.red,
      borderRadius: 5,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      titleText: const Text(
        "App Name",
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
      messageText: Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(
              width: 12,
            ),
            Flexible(
              child: Text(
                message,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
      duration: const Duration(milliseconds: 2000),
      animationDuration: const Duration(milliseconds: 1000),
    );
  }
}
