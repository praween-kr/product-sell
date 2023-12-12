class MessagesModel {
  String? successMessage;
  int? code;
  int? unreadMessageCount;
  List<Message>? messages;

  MessagesModel(
      {this.successMessage, this.code, this.unreadMessageCount, this.messages});

  MessagesModel.fromJson(Map<String, dynamic> json) {
    successMessage = json['success_message'];
    code = json['code'];
    unreadMessageCount = json['unread_message_count'];
    if (json['getdata'] != null) {
      messages = <Message>[];
      json['getdata'].forEach((v) {
        messages!.add(Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success_message'] = successMessage;
    data['code'] = code;
    data['unread_message_count'] = unreadMessageCount;
    if (messages != null) {
      data['getdata'] = messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  int? id;
  int? senderId;
  int? receiverId;
  int? chatConstantId;
  String? message;
  int? readStatus;
  int? messageType;
  int? deletedId;
  String? createdAt;
  String? updatedAt;
  String? messageide;

  Message(
      {this.id,
      this.senderId,
      this.receiverId,
      this.chatConstantId,
      this.message,
      this.readStatus,
      this.messageType,
      this.deletedId,
      this.createdAt,
      this.updatedAt,
      this.messageide});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    chatConstantId = json['chatConstantId'];
    message = json['message'];
    readStatus = json['readStatus'];
    messageType = json['messageType'];
    deletedId = json['deletedId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    messageide = json['messageide'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['senderId'] = senderId;
    data['receiverId'] = receiverId;
    data['chatConstantId'] = chatConstantId;
    data['message'] = message;
    data['readStatus'] = readStatus;
    data['messageType'] = messageType;
    data['deletedId'] = deletedId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['messageide'] = messageide;
    return data;
  }
}
