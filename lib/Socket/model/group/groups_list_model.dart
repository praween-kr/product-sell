import 'package:oninto_flutter/Socket/model/group/group_message_model.dart';
import 'package:oninto_flutter/model/auth/user_info_model.dart';

class GroupListModel {
  List<GroupConstant>? list;

  GroupListModel({this.list});

  GroupListModel.fromJson(Map<String, dynamic> json) {
    if (json['constantList'] != null) {
      list = <GroupConstant>[];
      json['constantList'].forEach((v) {
        list!.add(GroupConstant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['constantList'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupConstant {
  int? id;
  int? senderId;
  int? receiverId;
  int? groupId;
  int? productId;
  int? lastMessageId;
  int? typing;
  int? deletedId;
  int? deletedLastMessageId;
  int? isInListing;
  String? createdAt;
  String? updatedAt;
  int? unreadCount;
  bool? onlineStatus;
  int? unreadMessageCount;
  LastMessageIds? lastMessageIds;
  UserBasicInfo? sender;
  ChatGroup? group;

  GroupConstant(
      {this.id,
      this.senderId,
      this.receiverId,
      this.groupId,
      this.productId,
      this.lastMessageId,
      this.typing,
      this.deletedId,
      this.deletedLastMessageId,
      this.isInListing,
      this.createdAt,
      this.updatedAt,
      this.unreadCount,
      this.onlineStatus,
      this.unreadMessageCount,
      this.lastMessageIds,
      this.sender,
      this.group});

  GroupConstant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    groupId = json['groupId'];
    productId = json['productId'];
    lastMessageId = json['lastMessageId'];
    typing = json['typing'];
    deletedId = json['deletedId'];
    deletedLastMessageId = json['deletedLastMessageId'];
    isInListing = json['is_in_listing'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    unreadCount = json['unreadCount'];
    onlineStatus = json['onlineStatus'];
    unreadMessageCount = json['unreadMessageCount'];
    lastMessageIds = json['lastMessageIds'] != null
        ? LastMessageIds.fromJson(json['lastMessageIds'])
        : null;
    sender =
        json['sender'] != null ? UserBasicInfo.fromJson(json['sender']) : null;
    group = json['group'] != null ? ChatGroup.fromJson(json['group']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['senderId'] = senderId;
    data['receiverId'] = receiverId;
    data['groupId'] = groupId;
    data['productId'] = productId;
    data['lastMessageId'] = lastMessageId;
    data['typing'] = typing;
    data['deletedId'] = deletedId;
    data['deletedLastMessageId'] = deletedLastMessageId;
    data['is_in_listing'] = isInListing;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['unreadCount'] = unreadCount;
    data['onlineStatus'] = onlineStatus;
    data['unreadMessageCount'] = unreadMessageCount;
    if (lastMessageIds != null) {
      data['lastMessageIds'] = lastMessageIds!.toJson();
    }
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    if (group != null) {
      data['group'] = group!.toJson();
    }
    return data;
  }
}

class LastMessageIds {
  String? message;

  LastMessageIds({this.message});

  LastMessageIds.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
