import 'package:oninto_flutter/model/product/product_model.dart';

class MyFavProduct {
  int? id;
  int? userId;
  int? productId;
  String? createdAt;
  String? updatedAt;
  ProductModel? product;

  MyFavProduct(
      {this.id,
      this.userId,
      this.productId,
      this.createdAt,
      this.updatedAt,
      this.product});

  MyFavProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    productId = json['productId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['productId'] = productId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}
