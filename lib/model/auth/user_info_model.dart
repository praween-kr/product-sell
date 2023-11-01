class UserInfoModel {
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
  String? image;
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
  String? token;
  String? location;
  String? latitude;
  String? longitude;

  UserInfoModel(
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
      this.image,
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
      this.token,
      this.location,
      this.latitude,
      this.longitude});

  UserInfoModel.fromJson(Map<String, dynamic> json) {
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
    image = json['image'];
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
    token = json['token'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
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
    data['image'] = image;
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
    data['token'] = token;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}
