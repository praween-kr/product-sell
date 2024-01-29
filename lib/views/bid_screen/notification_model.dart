class NotificationModel {
  int? id;
  int? senderId;
  int? reciverId;
  String? message;
  int? isRead;
  String? createdAt;
  String? updatedAt;

  NotificationModel(
      {this.id,
      this.senderId,
      this.reciverId,
      this.message,
      this.isRead,
      this.createdAt,
      this.updatedAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    reciverId = json['reciverId'];
    message = json['message'];
    isRead = json['is_read'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['senderId'] = senderId;
    data['reciverId'] = reciverId;
    data['message'] = message;
    data['is_read'] = isRead;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
