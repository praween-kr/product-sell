// class ChatProductUsersList {
//   String? successMessage;
//   int? code;
//   List<Getdata>? getdata;

//   ChatProductUsersList({this.successMessage, this.code, this.getdata});

//   ChatProductUsersList.fromJson(Map<String, dynamic> json) {
//     successMessage = json['success_message'];
//     code = json['code'];
//     if (json['getdata'] != null) {
//       getdata = <Getdata>[];
//       json['getdata'].forEach((v) {
//         getdata!.add(new Getdata.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['success_message'] = this.successMessage;
//     data['code'] = this.code;
//     if (this.getdata != null) {
//       data['getdata'] = this.getdata!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class ChatProductUser {
  int? id;
  int? senderId;
  int? receiverId;
  int? productId;
  int? lastMessageId;
  int? typing;
  int? deletedId;
  int? isInListing;
  String? createdAt;
  String? updatedAt;
  int? unreadCount;
  bool? onlineStatus;
  // LastMessageIds? lastMessageIds;
  Sender? receiver;

  ChatProductUser(
      {this.id,
      this.senderId,
      this.receiverId,
      this.productId,
      this.lastMessageId,
      this.typing,
      this.deletedId,
      this.isInListing,
      this.createdAt,
      this.updatedAt,
      this.unreadCount,
      this.onlineStatus,
      // this.lastMessageIds,
      this.receiver});

  ChatProductUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    productId = json['productId'];
    lastMessageId = json['lastMessageId'];
    typing = json['typing'];
    deletedId = json['deletedId'];
    isInListing = json['is_in_listing'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    unreadCount = json['unreadCount'];
    onlineStatus = json['onlineStatus'];
    // lastMessageIds = json['lastMessageIds'] != null
    //     ? new LastMessageIds.fromJson(json['lastMessageIds'])
    //     : null;
    receiver =
        json['receiver'] != null ? Sender.fromJson(json['receiver']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['senderId'] = senderId;
    data['receiverId'] = receiverId;
    data['productId'] = productId;
    data['lastMessageId'] = lastMessageId;
    data['typing'] = typing;
    data['deletedId'] = deletedId;
    data['is_in_listing'] = isInListing;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['unreadCount'] = unreadCount;
    data['onlineStatus'] = onlineStatus;
    // if (this.lastMessageIds != null) {
    //   data['lastMessageIds'] = this.lastMessageIds!.toJson();
    // }
    if (receiver != null) {
      data['receiver'] = receiver!.toJson();
    }
    return data;
  }
}

class Sender {
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

  Sender(
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

  Sender.fromJson(Map<String, dynamic> json) {
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
