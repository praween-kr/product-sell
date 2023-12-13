class NotificationEntity {
  NotificationEntity({
    this.title,
    this.priority,
    this.body,
    this.entityId,
    this.entityName,
    this.dataId,
    this.dataName,
    this.dataEmail,
    this.dataImage,
    this.senderId,
    this.senderImage,
  });

  String? title;
  String? priority;
  String? body;
  String? entityId;
  String? entityName;
  dynamic dataId;
  String? dataName;
  String? dataEmail;
  String? dataImage;
  dynamic type;
  dynamic senderId;
  dynamic senderImage;
  dynamic senderName;

  NotificationEntity.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    priority = json['priority'];
    body = json['body'];
    entityId = json['entityId'];
    entityName = json['entityName'];
    dataId = json['dataId'];
    dataEmail = json['dataEmail'];
    dataImage = json['dataImage'];
    dataName = json['dataName'];
    type = json['notificationType'];
    senderId = json['senderId'];
    senderImage = json['senderImage'];
    senderName = json['senderName'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    void writeNotNull(String key, dynamic value) {
      if (value != null && value.toString().isNotEmpty) {
        data[key] = value;
      }
    }

    writeNotNull('title', title);
    writeNotNull('priority', priority);
    writeNotNull('body', body);
    writeNotNull('entityId', entityId);
    writeNotNull('entityName', entityName);
    writeNotNull('dataId', dataId);
    writeNotNull('dataName', dataName);
    writeNotNull('dataEmail', dataEmail);
    writeNotNull('dataImage', dataImage);
    writeNotNull('notificationType', type);
    writeNotNull('senderId', senderId);
    writeNotNull('senderImage', senderImage);
    writeNotNull('senderName', senderName);

    return data;
  }
}