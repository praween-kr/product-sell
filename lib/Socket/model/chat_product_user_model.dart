class ChatProductUsersModel {
  String? successMessage;
  int? code;
  List<ChatProductUser>? getdata;

  ChatProductUsersModel({this.successMessage, this.code, this.getdata});

  ChatProductUsersModel.fromJson(Map<String, dynamic> json) {
    successMessage = json['success_message'];
    code = json['code'];
    if (json['getdata'] != null) {
      getdata = <ChatProductUser>[];
      json['getdata'].forEach((v) {
        getdata!.add(ChatProductUser.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success_message'] = successMessage;
    data['code'] = code;
    if (getdata != null) {
      data['getdata'] = getdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatProductUser {
  int? id;
  int? senderId;
  int? receiverId;
  int? unreadCount;
  String? createdAt;
  String? updatedAt;
  bool? onlineStatus;
  LastMessageIds? lastMessageIds;
  Receiver? receiver;
  Product? product;

  ChatProductUser(
      {this.id,
      this.senderId,
      this.receiverId,
      this.unreadCount,
      this.createdAt,
      this.updatedAt,
      this.onlineStatus,
      this.lastMessageIds,
      this.receiver,
      this.product});

  ChatProductUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    unreadCount = json['unreadCount'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    onlineStatus = json['onlineStatus'];
    lastMessageIds = json['lastMessageIds'] != null
        ? LastMessageIds.fromJson(json['lastMessageIds'])
        : null;
    receiver =
        json['receiver'] != null ? Receiver.fromJson(json['receiver']) : null;
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['senderId'] = senderId;
    data['receiverId'] = receiverId;
    data['unreadCount'] = unreadCount;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['onlineStatus'] = onlineStatus;
    if (lastMessageIds != null) {
      data['lastMessageIds'] = lastMessageIds!.toJson();
    }
    if (receiver != null) {
      data['receiver'] = receiver!.toJson();
    }
    if (product != null) {
      data['product'] = product!.toJson();
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

class Receiver {
  int? id;
  String? username;
  String? firstName;
  String? lastName;
  String? image;
  String? email;

  Receiver(
      {this.id,
      this.username,
      this.firstName,
      this.lastName,
      this.image,
      this.email});

  Receiver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    image = json['image'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['image'] = image;
    data['email'] = email;
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? image;
  List<ProductImages>? productImages;
  var category;

  Product({this.id, this.name, this.image, this.productImages, this.category});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(ProductImages.fromJson(v));
      });
    }
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    if (productImages != null) {
      data['product_images'] = productImages!.map((v) => v.toJson()).toList();
    }
    data['category'] = category;
    return data;
  }
}

class ProductImages {
  int? id;
  int? productId;
  String? image;
  String? video;
  String? thumbnail;
  String? createdAt;
  String? updatedAt;

  ProductImages(
      {this.id,
      this.productId,
      this.image,
      this.video,
      this.thumbnail,
      this.createdAt,
      this.updatedAt});

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    image = json['image'];
    video = json['video'];
    thumbnail = json['thumbnail'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['image'] = image;
    data['video'] = video;
    data['thumbnail'] = thumbnail;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
