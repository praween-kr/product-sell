
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['senderId'] = this.senderId;
    data['reciverId'] = this.reciverId;
    data['message'] = this.message;
    data['is_read'] = this.isRead;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
