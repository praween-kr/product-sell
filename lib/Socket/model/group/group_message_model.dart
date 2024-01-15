import 'package:oninto_flutter/model/auth/user_info_model.dart';
import 'package:oninto_flutter/model/home/category_model.dart';

class GroupMessageListModel {
  List<GroupMessage>? list;

  GroupMessageListModel({this.list});

  GroupMessageListModel.fromJson(Map<String, dynamic> json) {
    if (json['chatList'] != null) {
      list = <GroupMessage>[];
      json['chatList'].forEach((v) {
        list!.add(GroupMessage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['chatList'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupMessage {
  int? id;
  int? senderId;
  int? receiverId;
  int? productId;
  int? groupId;
  String? senderType;
  String? receiverType;
  String? message;
  String? thumbnail;
  int? deletedId;
  int? chatConstantId;
  int? readStatus;
  int? messageType;
  int? created;
  int? updated;
  String? createdAt;
  String? updatedAt;
  UserBasicInfo? sender;
  UserBasicInfo? receiver;

  GroupMessage(
      {this.id,
      this.senderId,
      this.receiverId,
      this.productId,
      this.groupId,
      this.senderType,
      this.receiverType,
      this.message,
      this.thumbnail,
      this.deletedId,
      this.chatConstantId,
      this.readStatus,
      this.messageType,
      this.created,
      this.updated,
      this.createdAt,
      this.updatedAt,
      this.sender,
      this.receiver});

  GroupMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    productId = json['productId'];
    groupId = json['groupId'];
    senderType = json['senderType'];
    receiverType = json['receiverType'];
    message = json['message'];
    thumbnail = json['thumbnail'];
    deletedId = json['deletedId'];
    chatConstantId = json['chatConstantId'];
    readStatus = json['readStatus'];
    messageType = json['messageType'];
    created = json['created'];
    updated = json['updated'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    sender =
        json['sender'] != null ? UserBasicInfo.fromJson(json['sender']) : null;
    receiver = json['receiver'] != null
        ? UserBasicInfo.fromJson(json['receiver'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['senderId'] = senderId;
    data['receiverId'] = receiverId;
    data['productId'] = productId;
    data['groupId'] = groupId;
    data['senderType'] = senderType;
    data['receiverType'] = receiverType;
    data['message'] = message;
    data['thumbnail'] = thumbnail;
    data['deletedId'] = deletedId;
    data['chatConstantId'] = chatConstantId;
    data['readStatus'] = readStatus;
    data['messageType'] = messageType;
    data['created'] = created;
    data['updated'] = updated;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    if (receiver != null) {
      data['receiver'] = receiver!.toJson();
    }
    return data;
  }
}

class ChatGroup {
  int? id;
  int? shareId;
  String? groupName;
  int? adminId;
  String? createdAt;
  String? updatedAt;
  UserBasicInfo? user;
  ProductBaseInfo? productBaseInfo;
  List<GroupUser>? groupUser;

  ChatGroup(
      {this.id,
      this.shareId,
      this.groupName,
      this.adminId,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.productBaseInfo,
      this.groupUser});

  ChatGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shareId = json['shareId'];
    // ignore: prefer_null_aware_operators
    groupName = json['groupName'] == null ? null : json['groupName'].toString();
    adminId = json['adminId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? UserBasicInfo.fromJson(json['user']) : null;
    productBaseInfo = json['product'] != null
        ? ProductBaseInfo.fromJson(json['product'])
        : null;
    if (json['groupUser'] != null) {
      groupUser = <GroupUser>[];
      json['groupUser'].forEach((v) {
        groupUser!.add(GroupUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shareId'] = shareId;
    data['groupName'] = groupName;
    data['adminId'] = adminId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (productBaseInfo != null) {
      data['product'] = productBaseInfo!.toJson();
    }
    if (groupUser != null) {
      data['groupUser'] = groupUser!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupUser {
  int? id;
  int? groupId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  UserBasicInfo? user;

  GroupUser(
      {this.id,
      this.groupId,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.user});

  GroupUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupId = json['groupId'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? UserBasicInfo.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['groupId'] = groupId;
    data['userId'] = userId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class ProductBaseInfo {
  int? id;
  String? name;
  String? image;
  String? productImage;
  CategoryModel? category;

  ProductBaseInfo(
      {this.id, this.name, this.image, this.productImage, this.category});

  ProductBaseInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['product_images'] != null) {
      productImage = (json['product_images'] as List).isEmpty
          ? null
          : (json['product_images'] as List).first['image'];
    }
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['category'] = category;
    return data;
  }
}

class PollMessage {
  String? question;
  String? expDate;
  String? expTime;
  List<String>? options;

  PollMessage({this.question, this.expDate, this.expTime, this.options});

  PollMessage.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    expDate = json['exp_date'];
    expTime = json['exp_time'];
    options = json['options'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['exp_date'] = expDate;
    data['exp_time'] = expTime;
    data['options'] = options;
    return data;
  }
}

class ReplayMessage {
  int? replayonMsgid;
  String? replayonMsg;
  String? replayonDatetime;
  String? message;

  ReplayMessage(
      {this.replayonMsgid,
      this.replayonMsg,
      this.replayonDatetime,
      this.message});

  ReplayMessage.fromJson(Map<String, dynamic> json) {
    replayonMsgid = json['replayon_msgid'];
    replayonMsg = json['replayon_msg'];
    replayonDatetime = json['replayon_datetime'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['replayon_msgid'] = replayonMsgid;
    data['replayon_msg'] = replayonMsg;
    data['replayon_datetime'] = replayonDatetime;
    data['message'] = message;
    return data;
  }
}
