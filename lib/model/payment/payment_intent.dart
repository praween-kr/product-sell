class PaymentIntentModel {
  PaymentIntent? paymentIntent;
  String? ephemeralKey;
  String? customer;
  String? publishableKey;

  PaymentIntentModel(
      {this.paymentIntent,
      this.ephemeralKey,
      this.customer,
      this.publishableKey});

  PaymentIntentModel.fromJson(Map<String, dynamic> json) {
    paymentIntent = json['paymentIntent'] != null
        ? PaymentIntent.fromJson(json['paymentIntent'])
        : null;
    ephemeralKey = json['ephemeralKey'];
    customer = json['customer'];
    publishableKey = json['publishableKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymentIntent != null) {
      data['paymentIntent'] = paymentIntent!.toJson();
    }
    data['ephemeralKey'] = ephemeralKey;
    data['customer'] = customer;
    data['publishableKey'] = publishableKey;
    return data;
  }
}

class PaymentIntent {
  String? id;
  String? object;
  int? amount;
  int? amountCapturable;
  int? amountReceived;
  String? captureMethod;
  String? clientSecret;
  String? confirmationMethod;
  int? created;
  String? currency;
  String? customer;
  bool? livemode;
  List<String>? paymentMethodTypes;
  String? status;

  PaymentIntent({
    this.id,
    this.object,
    this.amount,
    this.amountCapturable,
    this.amountReceived,
    this.captureMethod,
    this.clientSecret,
    this.confirmationMethod,
    this.created,
    this.currency,
    this.customer,
    this.livemode,
    this.paymentMethodTypes,
    this.status,
  });

  PaymentIntent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    amount = json['amount'];
    amountCapturable = json['amount_capturable'];
    amountReceived = json['amount_received'];
    captureMethod = json['capture_method'];
    clientSecret = json['client_secret'];
    confirmationMethod = json['confirmation_method'];
    created = json['created'];
    currency = json['currency'];
    customer = json['customer'];
    livemode = json['livemode'];
    paymentMethodTypes = json['payment_method_types'].cast<String>();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['object'] = object;
    data['amount'] = amount;
    data['amount_capturable'] = amountCapturable;
    data['amount_received'] = amountReceived;
    data['capture_method'] = captureMethod;
    data['client_secret'] = clientSecret;
    data['confirmation_method'] = confirmationMethod;
    data['created'] = created;
    data['currency'] = currency;
    data['customer'] = customer;
    data['livemode'] = livemode;
    data['payment_method_types'] = paymentMethodTypes;
    data['status'] = status;
    return data;
  }
}
