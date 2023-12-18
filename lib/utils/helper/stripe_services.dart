import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

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
      String? phone}) async {
    try {
      paymentIntent =
          await createPaymentIntent(amount ?? "", currency ?? 'INR');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
            billingDetails: BillingDetails(
                name: name,
                email: email,
                phone: phone,
                address: Address(
                    city: city,
                    country: country,
                    line1: line1,
                    line2: line2,
                    postalCode: postalCode,
                    state: state)),
            paymentIntentClientSecret: paymentIntent!['client_secret'],
            //Gotten from payment intent
            style: ThemeMode.dark,
            merchantDisplayName: 'Ikay',
            // Extra params
            primaryButtonLabel: 'Pay now',
            applePay: const PaymentSheetApplePay(
              merchantCountryCode: 'DE',
            ),
            googlePay: const PaymentSheetGooglePay(
              merchantCountryCode: 'DE',
              testEnv: true,
            ),
            appearance: const PaymentSheetAppearance(
              colors: PaymentSheetAppearanceColors(
                background: Colors.lightBlue,
                primary: Colors.blue,
                componentBorder: Colors.red,
              ),
              shapes: PaymentSheetShape(
                borderWidth: 4,
                shadow: PaymentSheetShadowParams(color: Colors.red),
              ),
              primaryButton: PaymentSheetPrimaryButtonAppearance(
                shapes: PaymentSheetPrimaryButtonShape(blurRadius: 8),
                colors: PaymentSheetPrimaryButtonTheme(
                  light: PaymentSheetPrimaryButtonThemeColors(
                    background: Color.fromARGB(255, 231, 235, 30),
                    text: Color.fromARGB(255, 235, 92, 30),
                    border: Color.fromARGB(255, 235, 92, 30),
                  ),
                ),
              ),
            ),
          ))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (e) {
      errorSnackBar(e.toString());
    }
  }

  static displayPaymentSheet() async {
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet(
          options: const PaymentSheetPresentOptions(timeout: 1200000));

      errorSnackBar('Payment successfully completed');
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
           // 'Authorization': 'Bearer ${'STRIPE_SECRET'}',
            'Content-Type': 'application/x-www-form-urlencoded'
          },
        ),
        data: body,
      );
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
