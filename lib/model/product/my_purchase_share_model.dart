class MySharesModel {
  List<MyShare>? sharelistSoldAdmin;
  List<MyShare>? sharelistNotSoldAdmin;

  MySharesModel({this.sharelistSoldAdmin, this.sharelistNotSoldAdmin});

  MySharesModel.fromJson(Map<String, dynamic> json) {
    if (json['sharelistSoldAdmin'] != null) {
      sharelistSoldAdmin = <MyShare>[];
      json['sharelistSoldAdmin'].forEach((v) {
        sharelistSoldAdmin!.add(MyShare.fromJson(v));
      });
    }
    if (json['sharelistNotSoldAdmin'] != null) {
      sharelistNotSoldAdmin = <MyShare>[];
      json['sharelistNotSoldAdmin'].forEach((v) {
        sharelistNotSoldAdmin!.add(MyShare.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sharelistSoldAdmin != null) {
      data['sharelistSoldAdmin'] =
          sharelistSoldAdmin!.map((v) => v.toJson()).toList();
    }
    if (sharelistNotSoldAdmin != null) {
      data['sharelistNotSoldAdmin'] =
          sharelistNotSoldAdmin!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyShare {
  int? shareId;
  String? totalInvestment;
  String? totalProfit;
  String? productImage;
  MyShareBasicInfo? share;

  MyShare(
      {this.shareId,
      this.totalInvestment,
      this.totalProfit,
      this.productImage,
      this.share});

  MyShare.fromJson(Map<String, dynamic> json) {
    shareId = json['shareId'];
    totalInvestment = json['totalInvestment'];
    totalProfit = json['totalProfit'];
    productImage = json['productImage'];
    share = json['product'] != null
        ? MyShareBasicInfo.fromJson(json['product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shareId'] = shareId;
    data['totalInvestment'] = totalInvestment;
    data['totalProfit'] = totalProfit;
    data['productImage'] = productImage;
    if (share != null) {
      data['product'] = share!.toJson();
    }
    return data;
  }
}

class MyShareBasicInfo {
  int? id;
  int? isApproved;
  int? status;
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
  String? brandName;
  String? mrp;
  String? minimumSellingPrice;
  String? createdAt;
  String? updatedAt;
  int? isFavourite;

  MyShareBasicInfo(
      {this.id,
      this.isApproved,
      this.status,
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
      this.brandName,
      this.mrp,
      this.minimumSellingPrice,
      this.createdAt,
      this.updatedAt,
      this.isFavourite});

  MyShareBasicInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isApproved = json['isApproved'];
    status = json['status'];
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
    brandName = json['brandName'];
    mrp = json['mrp'];
    minimumSellingPrice = json['minimumSellingPrice'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isFavourite = json['isFavourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isApproved'] = isApproved;
    data['status'] = status;
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
    data['brandName'] = brandName;
    data['mrp'] = mrp;
    data['minimumSellingPrice'] = minimumSellingPrice;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['isFavourite'] = isFavourite;
    return data;
  }
}
