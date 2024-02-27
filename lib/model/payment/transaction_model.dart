import 'package:oninto_flutter/model/product/product_model.dart';

import '../settings/address_model.dart';

class TransactionModel {
  int? id;
  int? userId;
  int? productId;
  String? paymentStatus;
  String? transactionId;
  int? amount;
  int? chargedAmount;
  int? shpingAddressId;
  String? allJSON;
  String? createdAt;
  String? updatedAt;
  AddressModel? shippingAddress;
  ProductModel? product;

  TransactionModel(
      {this.id,
      this.userId,
      this.productId,
      this.paymentStatus,
      this.transactionId,
      this.amount,
      this.chargedAmount,
      this.shpingAddressId,
      this.allJSON,
      this.createdAt,
      this.updatedAt,
      this.shippingAddress,
      this.product});

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    productId = json['productId'];
    paymentStatus = json['payment_status'];
    transactionId = json['transaction_id'];
    amount = json['amount'];
    chargedAmount = json['chargedAmount'];
    shpingAddressId = json['shpingAddressId'];
    allJSON = json['allJSON'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    shippingAddress = json['userAddress'] != null
        ? AddressModel.fromJson(json['userAddress'])
        : null;
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['productId'] = productId;
    data['payment_status'] = paymentStatus;
    data['transaction_id'] = transactionId;
    data['amount'] = amount;
    data['chargedAmount'] = chargedAmount;
    data['shpingAddressId'] = shpingAddressId;
    data['allJSON'] = allJSON;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (shippingAddress != null) {
      data['userAddress'] = shippingAddress!.toJson();
    }
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}
