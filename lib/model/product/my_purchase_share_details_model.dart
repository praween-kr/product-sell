class PurchaseShareDetails {
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
  String? price;
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
  String? createdAt;
  String? updatedAt;
  int? updated;
  int? isFavourite;
  List<SharePurchases>? sharePurchases;

  PurchaseShareDetails(
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
      this.price,
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
      this.createdAt,
      this.updatedAt,
      this.updated,
      this.isFavourite,
      this.sharePurchases});

  PurchaseShareDetails.fromJson(Map<String, dynamic> json) {
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
    price = json['price'];
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
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    updated = json['updated'];
    isFavourite = json['isFavourite'];
    if (json['sharePurchases'] != null) {
      sharePurchases = <SharePurchases>[];
      json['sharePurchases'].forEach((v) {
        sharePurchases!.add(SharePurchases.fromJson(v));
      });
    }
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
    data['price'] = price;
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
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['updated'] = updated;
    data['isFavourite'] = isFavourite;
    if (sharePurchases != null) {
      data['sharePurchases'] = sharePurchases!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SharePurchases {
  int? id;
  int? shareId;
  int? userId;
  int? totalSharePurchase;
  int? perSharePrice;
  int? totalPurchaseSharePrice;
  // Null adminSoldShareProfit;
  int? adminSold;
  // Null calculation;
  // Null adminSoldSharePrice;
  // Null totalProfit;
  String? createdAt;
  String? updatedAt;

  SharePurchases(
      {this.id,
      this.shareId,
      this.userId,
      this.totalSharePurchase,
      this.perSharePrice,
      this.totalPurchaseSharePrice,
      // this.adminSoldShareProfit,
      this.adminSold,
      // this.calculation,
      // this.adminSoldSharePrice,
      // this.totalProfit,
      this.createdAt,
      this.updatedAt});

  SharePurchases.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shareId = json['shareId'];
    userId = json['userId'];
    totalSharePurchase = json['totalSharePurchase'];
    perSharePrice = json['perSharePrice'];
    totalPurchaseSharePrice = json['totalPurchaseSharePrice'];
    // adminSoldShareProfit = json['adminSoldShareProfit'];
    adminSold = json['adminSold'];
    // calculation = json['calculation'];
    // adminSoldSharePrice = json['adminSoldSharePrice'];
    // totalProfit = json['totalProfit'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shareId'] = shareId;
    data['userId'] = userId;
    data['totalSharePurchase'] = totalSharePurchase;
    data['perSharePrice'] = perSharePrice;
    data['totalPurchaseSharePrice'] = totalPurchaseSharePrice;
    // data['adminSoldShareProfit'] = adminSoldShareProfit;
    data['adminSold'] = adminSold;
    // data['calculation'] = calculation;
    // data['adminSoldSharePrice'] = adminSoldSharePrice;
    // data['totalProfit'] = totalProfit;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
