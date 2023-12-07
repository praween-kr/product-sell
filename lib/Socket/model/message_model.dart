class MessagesModel {
  List<Message>? mssages;

  MessagesModel({this.mssages});

  MessagesModel.fromJson(Map<String, dynamic> json) {
    if (json['msgs'] != null) {
      mssages = <Message>[];
      json['msgs'].forEach((v) {
        mssages!.add(Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (mssages != null) {
      data['msgs'] = mssages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String? sId;
  String? senderId;
  String? receiverId;
  int? constantId;
  String? message;
  String? thumbnail;
  String? isRead;
  String? type;
  String? deletedBy;
  String? createdAt;
  String? updatedAt;
  int? senderOnline;
  int? iV;

  Message(
      {this.sId,
      this.senderId,
      this.receiverId,
      this.constantId,
      this.message,
      this.thumbnail,
      this.isRead,
      this.type,
      this.deletedBy,
      this.createdAt,
      this.updatedAt,
      this.senderOnline,
      this.iV});

  Message.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    constantId = json['constant_id'];
    message = json['message'];
    thumbnail = json['thumbnail'];
    isRead = json['readStatus'];
    type = json['type'];
    deletedBy = json['deleted_by'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    senderOnline = json['senderOnline'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['constant_id'] = constantId;
    data['message'] = message;
    data['thumbnail'] = thumbnail;
    data['readStatus'] = isRead;
    data['type'] = type;
    data['deleted_by'] = deletedBy;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['senderOnline'] = senderOnline;
    data['__v'] = iV;
    return data;
  }
}
