import 'dart:convert';

class PushNotificationModel {
  String? deviceType;
  String? senderId;
  String? messageType;
  MsgData? data;
  String? sound;
  SenderDetail? senderDetail;
  String? notificationType;
  String? priority;
  String? body;
  String? message;
  String? deviceToken;
  String? productId;
  int? type;

  PushNotificationModel(
      {this.deviceType,
      this.senderId,
      this.messageType,
      this.data,
      this.sound,
      this.senderDetail,
      this.notificationType,
      this.priority,
      this.body,
      this.message,
      this.deviceToken,
      this.productId,
      this.type});

  PushNotificationModel.fromJson(Map<String, dynamic> json) {
    deviceType = json['deviceType'];
    senderId = json['senderId'];
    messageType = json['messageType'];
    data = json['data'] != null
        ? MsgData.fromJson(jsonDecode(json['data']))
        : null;
    sound = json['sound'];
    senderDetail = json['senderDetail'] != null
        ? SenderDetail.fromJson(jsonDecode(json['senderDetail']))
        : null;
    notificationType = json['notificationType'];
    priority = json['priority'];
    body = json['body'];
    message = json['message'];
    deviceToken = json['deviceToken'];
    productId = json['productId'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceType'] = deviceType;
    data['senderId'] = senderId;
    data['messageType'] = messageType;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['sound'] = sound;
    if (senderDetail != null) {
      data['senderDetail'] = senderDetail!.toJson();
    }
    data['notificationType'] = notificationType;
    data['priority'] = priority;
    data['body'] = body;
    data['message'] = message;
    data['deviceToken'] = deviceToken;
    data['productId'] = productId;
    data['type'] = type;
    return data;
  }
}

class MsgData {
  String? thumbnail;
  int? senderId;
  String? receiverId;
  String? productId;
  String? messageType;
  String? message;

  MsgData(
      {this.thumbnail,
      this.senderId,
      this.receiverId,
      this.productId,
      this.messageType,
      this.message});

  MsgData.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    productId = json['productId'];
    messageType = json['messageType'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['thumbnail'] = thumbnail;
    data['senderId'] = senderId;
    data['receiverId'] = receiverId;
    data['productId'] = productId;
    data['messageType'] = messageType;
    data['message'] = message;
    return data;
  }
}

class SenderDetail {
  String? lastName;
  int? notificationStatus;
  int? role;
  int? isOtpVerify;
  String? countryCode;
  int? id;
  String? email;
  String? image;
  String? countryCodePhone;
  int? verified;
  String? firstName;
  String? phone;
  String? location;

  SenderDetail({
    this.lastName,
    this.notificationStatus,
    this.role,
    this.isOtpVerify,
    this.countryCode,
    this.id,
    this.email,
    this.image,
    this.countryCodePhone,
    this.verified,
    this.firstName,
    this.phone,
    this.location,
  });

  SenderDetail.fromJson(Map<String, dynamic> json) {
    lastName = json['lastName'];
    notificationStatus = json['notificationStatus'];
    role = json['role'];
    isOtpVerify = json['is_otp_verify'];
    countryCode = json['countryCode'];
    id = json['id'];
    email = json['email'];
    image = json['image'];
    countryCodePhone = json['countryCodePhone'];
    verified = json['verified'];
    firstName = json['firstName'];
    phone = json['phone'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lastName'] = lastName;
    data['notificationStatus'] = notificationStatus;
    data['role'] = role;
    data['is_otp_verify'] = isOtpVerify;
    data['countryCode'] = countryCode;
    data['id'] = id;
    data['email'] = email;
    data['image'] = image;
    data['countryCodePhone'] = countryCodePhone;
    data['verified'] = verified;
    data['firstName'] = firstName;
    data['phone'] = phone;
    data['location'] = location;
    return data;
  }
}
