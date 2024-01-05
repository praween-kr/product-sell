import 'package:oninto_flutter/model/auth/user_info_model.dart';

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
  ChatGroup? group;

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
      this.group});

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
    group = json['group'] != null ? ChatGroup.fromJson(json['group']) : null;
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
    if (group != null) {
      data['group'] = group!.toJson();
    }
    return data;
  }
}

class ChatGroup {
  int? id;
  int? shareId;
  int? groupName;
  int? adminId;
  String? createdAt;
  String? updatedAt;
  UserBasicInfo? user;
  List<GroupUser>? groupUser;

  ChatGroup(
      {this.id,
      this.shareId,
      this.groupName,
      this.adminId,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.groupUser});

  ChatGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shareId = json['shareId'];
    groupName = json['groupName'];
    adminId = json['adminId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    user = json['user'] != null ? UserBasicInfo.fromJson(json['user']) : null;
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
