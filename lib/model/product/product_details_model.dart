import 'package:oninto_flutter/Socket/model/group/group_message_model.dart';
import 'package:oninto_flutter/model/home/category_model.dart';
import 'package:oninto_flutter/model/product/product_model.dart';
import 'package:oninto_flutter/model/settings/address_model.dart';

import '../auth/user_info_model.dart';
import 'product_image_model.dart';

class ProductDetailsData {
  ProductDetails? details;
  int? favoriteCount;
  int? viewCount;
  ShareTradModel? lastTrad;
  int? lastTradBuyPrice;
  int? availableShare;
  List<ShareTradModel>? myTrads;

  UserTransactionInfo? userTransactionInfo;
  ChatGroup? groupDetail;

  ProductDetailsData(
      {this.details,
      this.favoriteCount,
      this.viewCount,
      this.lastTrad,
      this.lastTradBuyPrice,
      this.availableShare,
      this.myTrads,
      this.groupDetail});

  ProductDetailsData.fromJson(Map<String, dynamic> json) {
    details =
        json['result'] != null ? ProductDetails.fromJson(json['result']) : null;
    favoriteCount = json['favoriteCount'];
    viewCount = json['viewCount'];
    lastTrad = json['lastTrad'] != null
        ? ShareTradModel.fromJson(json['lastTrad'])
        : null;
    lastTradBuyPrice =
        json['lastTradBuyPrice'] == "" ? null : json['lastTradBuyPrice'];
    availableShare = json['availableShare'];
    if (json['loginUserAlreadyBuy'] != null) {
      myTrads = <ShareTradModel>[];
      json['loginUserAlreadyBuy'].forEach((v) {
        myTrads!.add(ShareTradModel.fromJson(v));
      });
    }
    groupDetail = json['groupDetail'] != null
        ? ChatGroup.fromJson(json['groupDetail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (details != null) {
      data['result'] = details!.toJson();
    }
    data['favoriteCount'] = favoriteCount;
    data['viewCount'] = viewCount;
    if (lastTrad != null) {
      data['lastTrad'] = lastTrad!.toJson();
    }
    data['lastTradBuyPrice'] = lastTradBuyPrice;
    data['availableShare'] = availableShare;
    if (myTrads != null) {
      data['loginUserAlreadyBuy'] = myTrads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductDetails {
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
  String? endDate;
  String? bidTime;
  int? share;
  int? totalShare;
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
  double? averageRating;
  int? favorite;
  CategoryModel? category;
  List<ProductImages>? productImages;
  List<ProductSize>? productSizes;
  int? isFavourite;
  UserTransactionInfo? userTransactionInfo;
  List<ShareTradModel>? sharePurchases;
  String? bidPrice;

  ProductDetails(
      {this.id,
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
      this.endDate,
      this.bidTime,
      this.share,
      this.totalShare,
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
      this.averageRating,
      this.favorite,
      this.category,
      this.productImages,
      this.productSizes,
      this.isFavourite,
      this.userTransactionInfo,
      this.sharePurchases,
      this.bidPrice});

  ProductDetails.fromJson(Map<String, dynamic> json) {
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
    endDate = json['endDate'];
    bidTime = json['bidTime'];
    share = json['share'];
    totalShare = json['totalShare'];
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
    averageRating = json['averageRating'];
    favorite = json['favorite'];
    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;
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
    isFavourite = json['isFavourite'];
    userTransactionInfo = json['transactionUserData'] != null
        ? UserTransactionInfo.fromJson(json['transactionUserData'])
        : null;

    if (json['sharePurchases'] != null) {
      sharePurchases = <ShareTradModel>[];
      json['sharePurchases'].forEach((v) {
        sharePurchases!.add(ShareTradModel.fromJson(v));
      });
    }
    bidPrice = json['bidPrice'];
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
    data['endDate'] = endDate;
    data['bidTime'] = bidTime;
    data['share'] = share;
    data['totalShare'] = totalShare;
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
    data['averageRating'] = averageRating;
    data['favorite'] = favorite;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (productImages != null) {
      data['product_images'] = productImages!.map((v) => v.toJson()).toList();
    }
    if (productSizes != null) {
      data['product_sizes'] = productSizes!.map((v) => v.toJson()).toList();
    }
    data['isFavourite'] = isFavourite;
    if (userTransactionInfo != null) {
      data['transactionUserData'] = userTransactionInfo!.toJson();
    }
    if (sharePurchases != null) {
      data['sharePurchases'] = sharePurchases!.map((v) => v.toJson()).toList();
    }
    data['bidPrice'] = bidPrice;
    return data;
  }
}

class UserTransactionInfo {
  int? id;
  int? userId;
  int? productId;
  String? paymentStatus;
  int? shippedProductStatus;
  String? transactionId;
  int? amount;
  int? chargedAmount;
  int? shpingAddressId;
  String? allJSON;
  String? createdAt;
  String? updatedAt;
  UserBasicInfo? userInfo;
  AddressModel? shippingAddress;

  UserTransactionInfo(
      {this.id,
      this.userId,
      this.productId,
      this.paymentStatus,
      this.shippedProductStatus,
      this.transactionId,
      this.amount,
      this.chargedAmount,
      this.shpingAddressId,
      this.shippingAddress,
      this.allJSON,
      this.createdAt,
      this.updatedAt,
      this.userInfo});

  UserTransactionInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    productId = json['productId'];
    paymentStatus = json['payment_status'];
    shippedProductStatus = json['shipped_product_status'];
    transactionId = json['transaction_id'];
    amount = json['amount'];
    chargedAmount = json['chargedAmount'];
    shpingAddressId = json['shpingAddressId'];
    allJSON = json['allJSON'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userInfo =
        json['user'] != null ? UserBasicInfo.fromJson(json['user']) : null;
    shippingAddress = json['userAddress'] != null
        ? AddressModel.fromJson(json['userAddress'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['productId'] = productId;
    data['payment_status'] = paymentStatus;
    data['shipped_product_status'] = shippedProductStatus;
    data['transaction_id'] = transactionId;
    data['amount'] = amount;
    data['chargedAmount'] = chargedAmount;
    data['shpingAddressId'] = shpingAddressId;
    data['allJSON'] = allJSON;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (userInfo != null) {
      data['user'] = userInfo!.toJson();
    }
    if (shippingAddress != null) {
      data['userAddress'] = shippingAddress!.toJson();
    }
    return data;
  }
}

class ShareTradModel {
  int? id;
  int? shareId;
  int? userId;
  int? totalSharePurchase;
  int? perSharePrice;
  int? totalPurchaseSharePrice;
  int? adminSoldShareProfit;
  int? adminSold;
  String? calculation;
  int? adminSoldSharePrice;
  int? totalProfit;
  String? createdAt;
  String? updatedAt;
  UserBasicInfo? user;

  ShareTradModel(
      {this.id,
      this.shareId,
      this.userId,
      this.totalSharePurchase,
      this.perSharePrice,
      this.totalPurchaseSharePrice,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.adminSold,
      this.adminSoldSharePrice,
      this.adminSoldShareProfit,
      this.calculation,
      this.totalProfit});

  ShareTradModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shareId = json['shareId'];
    userId = json['userId'];
    totalSharePurchase = json['totalSharePurchase'];
    perSharePrice = json['perSharePrice'];
    totalPurchaseSharePrice = json['totalPurchaseSharePrice'];

    adminSoldShareProfit = json['adminSoldShareProfit'];
    adminSold = json['adminSold'];
    calculation = json['calculation'];
    adminSoldSharePrice = json['adminSoldSharePrice'];
    totalProfit = json['totalProfit'];

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? UserBasicInfo.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shareId'] = shareId;
    data['userId'] = userId;
    data['totalSharePurchase'] = totalSharePurchase;
    data['perSharePrice'] = perSharePrice;
    data['totalPurchaseSharePrice'] = totalPurchaseSharePrice;
    data['adminSoldShareProfit'] = adminSoldShareProfit;
    data['adminSold'] = adminSold;
    data['calculation'] = calculation;
    data['adminSoldSharePrice'] = adminSoldSharePrice;
    data['totalProfit'] = totalProfit;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
