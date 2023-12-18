class AddBidsHistory {
  Save? save;
  int? count;
  List<BidsHistory>? history;

  AddBidsHistory({this.save, this.count, this.history});

  AddBidsHistory.fromJson(Map<String, dynamic> json) {
    save = json['save'] != null ? Save.fromJson(json['save']) : null;
    count = json['count'];
    if (json['history'] != null) {
      history = <BidsHistory>[];
      json['history'].forEach((v) {
        history!.add(BidsHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (save != null) {
      data['save'] = save!.toJson();
    }
    data['count'] = count;
    if (history != null) {
      data['history'] = history!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Save {
  int? id;
  int? userId;
  int? productId;
  String? bidPrice;
  int? bidOver;
  String? createdAt;
  String? updatedAt;

  Save(
      {this.id,
      this.userId,
      this.productId,
      this.bidPrice,
      this.bidOver,
      this.createdAt,
      this.updatedAt});

  Save.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    productId = json['productId'];
    bidPrice = json['bidPrice'];
    bidOver = json['bidOver'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['productId'] = productId;
    data['bidPrice'] = bidPrice;
    data['bidOver'] = bidOver;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class BidsHistory {
  int? id;
  int? userId;
  int? productId;
  String? bidPrice;
  int? bidOver;
  String? createdAt;
  String? updatedAt;
  User? user;
  Product? product;

  BidsHistory(
      {this.id,
      this.userId,
      this.productId,
      this.bidPrice,
      this.bidOver,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.product});

  BidsHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    productId = json['productId'];
    bidPrice = json['bidPrice'];
    bidOver = json['bidOver'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['productId'] = productId;
    data['bidPrice'] = bidPrice;
    data['bidOver'] = bidOver;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  int? role;
  int? verified;
  int? checked;
  int? socialType;
  int? deviceType;
  int? status;
  String? deviceToken;
  String? username;
  String? firstName;
  String? lastName;
  String? email;
  String? countryCode;
  String? phone;
  String? countryCodePhone;
  String? location;
  String? latitude;
  String? longitude;
  String? image;
  String? password;
  int? otp;
  int? isOtpVerify;
  int? notificationStatus;
  String? forgotPasswordHash;
  String? socialId;
  String? facebookId;
  String? googleId;
  String? wallet;
  int? commissionType;
  String? specialCommission;
  int? created;
  int? updated;
  String? createdAt;
  String? updatedAt;

  User(
      {this.id,
      this.role,
      this.verified,
      this.checked,
      this.socialType,
      this.deviceType,
      this.status,
      this.deviceToken,
      this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.countryCode,
      this.phone,
      this.countryCodePhone,
      this.location,
      this.latitude,
      this.longitude,
      this.image,
      this.password,
      this.otp,
      this.isOtpVerify,
      this.notificationStatus,
      this.forgotPasswordHash,
      this.socialId,
      this.facebookId,
      this.googleId,
      this.wallet,
      this.commissionType,
      this.specialCommission,
      this.created,
      this.updated,
      this.createdAt,
      this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    verified = json['verified'];
    checked = json['checked'];
    socialType = json['socialType'];
    deviceType = json['deviceType'];
    status = json['status'];
    deviceToken = json['deviceToken'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    countryCode = json['countryCode'];
    phone = json['phone'];
    countryCodePhone = json['countryCodePhone'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    image = json['image'];
    password = json['password'];
    otp = json['otp'];
    isOtpVerify = json['is_otp_verify'];
    notificationStatus = json['notificationStatus'];
    forgotPasswordHash = json['forgotPasswordHash'];
    socialId = json['socialId'];
    facebookId = json['facebookId'];
    googleId = json['googleId'];
    wallet = json['wallet'];
    commissionType = json['commissionType'];
    specialCommission = json['specialCommission'];
    created = json['created'];
    updated = json['updated'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role'] = role;
    data['verified'] = verified;
    data['checked'] = checked;
    data['socialType'] = socialType;
    data['deviceType'] = deviceType;
    data['status'] = status;
    data['deviceToken'] = deviceToken;
    data['username'] = username;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['countryCode'] = countryCode;
    data['phone'] = phone;
    data['countryCodePhone'] = countryCodePhone;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['image'] = image;
    data['password'] = password;
    data['otp'] = otp;
    data['is_otp_verify'] = isOtpVerify;
    data['notificationStatus'] = notificationStatus;
    data['forgotPasswordHash'] = forgotPasswordHash;
    data['socialId'] = socialId;
    data['facebookId'] = facebookId;
    data['googleId'] = googleId;
    data['wallet'] = wallet;
    data['commissionType'] = commissionType;
    data['specialCommission'] = specialCommission;
    data['created'] = created;
    data['updated'] = updated;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Product {
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
  int? isBid;
  String? bidPrice;
  Null bidStartDate;
  Null bidTime;
  String? boostCode;
  String? startDate;
  String? endDate;
  Null share;
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
  int? viewCount;
  int? isFavourite;

  Product(
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
      this.isBid,
      this.bidPrice,
      this.bidStartDate,
      this.bidTime,
      this.boostCode,
      this.startDate,
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
      this.viewCount,
      this.isFavourite});

  Product.fromJson(Map<String, dynamic> json) {
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
    isBid = json['isBid'];
    bidPrice = json['bidPrice'];
    bidStartDate = json['bidStartDate'];
    bidTime = json['bidTime'];
    boostCode = json['boostCode'];
    startDate = json['startDate'];
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
    viewCount = json['viewCount'];
    isFavourite = json['isFavourite'];
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
    data['isBid'] = isBid;
    data['bidPrice'] = bidPrice;
    data['bidStartDate'] = bidStartDate;
    data['bidTime'] = bidTime;
    data['boostCode'] = boostCode;
    data['startDate'] = startDate;
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
    data['viewCount'] = viewCount;
    data['isFavourite'] = isFavourite;
    return data;
  }
}
