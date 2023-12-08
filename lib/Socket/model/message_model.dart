class Message {
  int? id;
  int? senderId;
  int? receiverId;
  int? productId;
  String? senderType;
  String? receiverType;
  String? message;
  int? deletedId;
  int? chatConstantId;
  int? readStatus;
  int? messageType;
  int? created;
  int? updated;
  String? createdAt;
  String? updatedAt;
  int? product;

  Message(
      {this.id,
      this.senderId,
      this.receiverId,
      this.productId,
      this.senderType,
      this.receiverType,
      this.message,
      this.deletedId,
      this.chatConstantId,
      this.readStatus,
      this.messageType,
      this.created,
      this.updated,
      this.createdAt,
      this.updatedAt,
      this.product});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    productId = json['productId'];
    senderType = json['senderType'];
    receiverType = json['receiverType'];
    message = json['message'];
    deletedId = json['deletedId'];
    chatConstantId = json['chatConstantId'];
    readStatus = json['readStatus'];
    messageType = json['messageType'];
    created = json['created'];
    updated = json['updated'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['product'] != null && json['product']['id'] != null) {
      product = json['product']['id'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['senderId'] = senderId;
    data['receiverId'] = receiverId;
    data['productId'] = productId;
    data['senderType'] = senderType;
    data['receiverType'] = receiverType;
    data['message'] = message;
    data['deletedId'] = deletedId;
    data['chatConstantId'] = chatConstantId;
    data['readStatus'] = readStatus;
    data['messageType'] = messageType;
    data['created'] = created;
    data['updated'] = updated;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    // if (sender != null) {
    //   data['sender'] = sender!.toJson();
    // }
    // if (receiver != null) {
    //   data['receiver'] = receiver!.toJson();
    // }
    // if (product != null) {
    //   data['product'] = product!.toJson();
    // }
    return data;
  }
}
