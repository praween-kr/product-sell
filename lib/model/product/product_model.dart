import 'package:oninto_flutter/Socket/model/add_bids_histories.dart';
import 'package:oninto_flutter/model/home/category_model.dart';

import 'product_image_model.dart';

abstract class Product {}

class ProductModel implements Product {
  int? id;
  int? isApproved;
  int? status;
  int? isVeg;
  int? type;
  int? taxCategoryId;
  int? vendorId;
  int? categoryId;
  int? subCategoryId;
  int? quantity;
  String? name;
  String? location;
  String? latitude;
  String? longitude;
  String? color;
  String? brand;
  String? productCondition;
  String? sellOption;
  String? price;
  String? boostCode;
  String? startDate;
  String? bidTime;
  String? endDate;
  int? share;
  String? description;
  String? otherDescription;
  String? image;
  String? barcode;
  String? barcodeImage;
  String? sku;
  String? skuImage;
  String? brandName;
  String? mrp;
  String? minimumSellingPrice;
  int? percentageDiscount;
  String? length;
  String? width;
  String? height;
  int? dimensionsUnit;
  String? weight;
  int? weightUnit;
  String? createdAt;
  String? updatedAt;
  List<ProductImages>? productImages;
  List<ProductSize>? productSizes;
  CategoryModel? category;
  int? isFavourite;
  BidsHistory? lastBidInfo;
  int? productBidCount;
  bool? isSold;

  ProductModel({
    this.id,
    this.isApproved,
    this.status,
    this.isVeg,
    this.type,
    this.taxCategoryId,
    this.vendorId,
    this.categoryId,
    this.subCategoryId,
    this.quantity,
    this.name,
    this.location,
    this.latitude,
    this.longitude,
    this.color,
    this.brand,
    this.productCondition,
    this.sellOption,
    this.price,
    this.boostCode,
    this.startDate,
    this.bidTime,
    this.endDate,
    this.share,
    this.description,
    this.otherDescription,
    this.image,
    this.barcode,
    this.barcodeImage,
    this.sku,
    this.skuImage,
    this.brandName,
    this.mrp,
    this.minimumSellingPrice,
    this.percentageDiscount,
    this.length,
    this.width,
    this.height,
    this.dimensionsUnit,
    this.weight,
    this.weightUnit,
    this.createdAt,
    this.updatedAt,
    this.productImages,
    this.productSizes,
    this.category,
    this.isFavourite,
    this.lastBidInfo,
    this.productBidCount,
    this.isSold,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isApproved = json['isApproved'];
    status = json['status'];
    isVeg = json['isVeg'];
    type = json['type'];
    taxCategoryId = json['taxCategoryId'];
    vendorId = json['vendorId'];
    categoryId = json['categoryId'];
    subCategoryId = json['subCategoryId'];
    quantity = json['quantity'];
    name = json['name'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    color = json['color'];
    brand = json['brand'];
    productCondition = json['productCondition'];
    sellOption = json['sellOption'];
    price = json['price'];
    boostCode = json['boostCode'];
    startDate = json['startDate'];
    bidTime = json['bidTime'];
    endDate = json['endDate'];
    share = json['share'];
    description = json['description'];
    otherDescription = json['otherDescription'];
    image = json['image'];
    barcode = json['barcode'];
    barcodeImage = json['barcodeImage'];
    sku = json['sku'];
    skuImage = json['skuImage'];
    brandName = json['brandName'];
    mrp = json['mrp'];
    minimumSellingPrice = json['minimumSellingPrice'];
    percentageDiscount = json['percentageDiscount'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    dimensionsUnit = json['dimensionsUnit'];
    weight = json['weight'];
    weightUnit = json['weightUnit'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(ProductImages.fromJson(v));
      });
    }
    if (json['product_sizes'] != null) {
      productSizes = <ProductSize>[];
      json['product_sizes'].forEach((v) {
        productSizes!.add(ProductSize.fromJson(v));
      });
    }
    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;
    isFavourite = json['isFavourite'];
    if (json['productBidData'] != null &&
        (json['productBidData'] as List).isNotEmpty) {
      lastBidInfo = (json['productBidData'] as List).first != null
          ? BidsHistory.fromJson((json['productBidData'] as List).first)
          : null;
    }
    productBidCount = json['productBidCount'];
    isSold = json['soldStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isApproved'] = isApproved;
    data['status'] = status;
    data['isVeg'] = isVeg;
    data['type'] = type;
    data['taxCategoryId'] = taxCategoryId;
    data['vendorId'] = vendorId;
    data['categoryId'] = categoryId;
    data['subCategoryId'] = subCategoryId;
    data['quantity'] = quantity;
    data['name'] = name;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['color'] = color;
    data['brand'] = brand;
    data['productCondition'] = productCondition;
    data['sellOption'] = sellOption;
    data['price'] = price;
    data['boostCode'] = boostCode;
    data['startDate'] = startDate;
    data['bidTime'] = bidTime;
    data['endDate'] = endDate;
    data['share'] = share;
    data['description'] = description;
    data['otherDescription'] = otherDescription;
    data['image'] = image;
    data['barcode'] = barcode;
    data['barcodeImage'] = barcodeImage;
    data['sku'] = sku;
    data['skuImage'] = skuImage;
    data['brandName'] = brandName;
    data['mrp'] = mrp;
    data['minimumSellingPrice'] = minimumSellingPrice;
    data['percentageDiscount'] = percentageDiscount;
    data['length'] = length;
    data['width'] = width;
    data['height'] = height;
    data['dimensionsUnit'] = dimensionsUnit;
    data['weight'] = weight;
    data['weightUnit'] = weightUnit;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (productImages != null) {
      data['product_images'] = productImages!.map((v) => v.toJson()).toList();
    }
    if (productSizes != null) {
      data['product_sizes'] = productSizes!.map((e) => e.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['isFavourite'] = isFavourite;
    // if (lastBidInfo != null) {
    //   data['productBidData'] = lastBidInfo!.toJson();
    // }
    data['productBidCount'] = productBidCount;
    data['soldStatus'] = isSold;

    return data;
  }
}

class BuyProductModel implements Product {
  int? id;
  int? isApproved;
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
  ProductModel? product;

  BuyProductModel(
      {this.id,
      this.isApproved,
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
      this.product});

  BuyProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isApproved = json['isApproved'];
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
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isApproved'] = isApproved;
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
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

// Product Size
class ProductSize {
  int? id;
  int? productId;
  String? size;
  String? createdAt;
  String? updatedAt;

  ProductSize(
      {this.id, this.productId, this.size, this.createdAt, this.updatedAt});

  ProductSize.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    size = json['size'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['size'] = size;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
