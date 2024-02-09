class ProductFavViewModel {
  int? favoriteCount;
  int? viewCount;
  List<FavoriteUserList>? favoriteUserList;
  List<ViewUserList>? viewUserList;

  ProductFavViewModel(
      {this.favoriteCount,
      this.viewCount,
      this.favoriteUserList,
      this.viewUserList});

  ProductFavViewModel.fromJson(Map<String, dynamic> json) {
    favoriteCount = json['favoriteCount'];
    viewCount = json['viewCount'];
    if (json['favoriteUserList'] != null) {
      favoriteUserList = <FavoriteUserList>[];
      json['favoriteUserList'].forEach((v) {
        favoriteUserList!.add(FavoriteUserList.fromJson(v));
      });
    }
    if (json['viewUserList'] != null) {
      viewUserList = <ViewUserList>[];
      json['viewUserList'].forEach((v) {
        viewUserList!.add(ViewUserList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['favoriteCount'] = favoriteCount;
    data['viewCount'] = viewCount;
    if (favoriteUserList != null) {
      data['favoriteUserList'] =
          favoriteUserList!.map((v) => v.toJson()).toList();
    }
    if (viewUserList != null) {
      data['viewUserList'] = viewUserList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FavoriteUserList {
  int? id;
  int? userId;
  int? productId;
  int? productType;
  int? isBid;
  String? startDate;
  String? createdAt;
  String? updatedAt;
  User? user;

  FavoriteUserList(
      {this.id,
      this.userId,
      this.productId,
      this.productType,
      this.isBid,
      this.startDate,
      this.createdAt,
      this.updatedAt,
      this.user});

  FavoriteUserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    productId = json['productId'];
    productType = json['productType'];
    isBid = json['isBid'];
    startDate = json['startDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['productId'] = productId;
    data['productType'] = productType;
    data['isBid'] = isBid;
    data['startDate'] = startDate;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  int? role;
  String? customerId;
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
  Null deletedAt;

  User(
      {this.id,
      this.role,
      this.customerId,
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
      this.updatedAt,
      this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    customerId = json['customerId'];
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
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['role'] = role;
    data['customerId'] = customerId;
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
    data['deletedAt'] = deletedAt;
    return data;
  }
}

class ViewUserList {
  int? id;
  int? userId;
  int? productId;
  String? createdAt;
  String? updatedAt;
  User? user;

  ViewUserList(
      {this.id,
      this.userId,
      this.productId,
      this.createdAt,
      this.updatedAt,
      this.user});

  ViewUserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    productId = json['productId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['productId'] = productId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
