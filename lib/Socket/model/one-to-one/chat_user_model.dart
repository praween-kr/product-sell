// class ChatUsersModel {
//   List<ChatUser>? users;

//   ChatUsersModel({this.users});

//   ChatUsersModel.fromJson(Map<String, dynamic> json) {
//     if (json['users'] != null) {
//       users = <ChatUser>[];
//       json['users'].forEach((v) {
//         users!.add(ChatUser.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (users != null) {
//       data['users'] = users!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class ChatUser {
//   int? unreadCount;
//   String? sId;
//   String? senderId;
//   String? receiverId;
//   int? constantId;
//   String? message;
//   String? thumbnail;
//   String? isRead;
//   String? type;
//   String? deletedBy;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//   List<ChatUserInfo>? userInfo;
//   List<ChatUserInfo>? sender;
//   String? reciverOnline;

//   ChatUser(
//       {this.unreadCount,
//       this.sId,
//       this.senderId,
//       this.receiverId,
//       this.constantId,
//       this.message,
//       this.thumbnail,
//       this.isRead,
//       this.type,
//       this.deletedBy,
//       this.createdAt,
//       this.updatedAt,
//       this.iV,
//       this.userInfo,
//       this.sender,
//       this.reciverOnline});

//   ChatUser.fromJson(Map<String, dynamic> json) {
//     unreadCount = json['unread_count'];
//     sId = json['_id'];
//     senderId = json['sender_id'];
//     receiverId = json['receiver_id'];
//     constantId = json['constant_id'];
//     message = json['message'];
//     thumbnail = json['thumbnail'];
//     isRead = json['is_read'];
//     type = json['type'];
//     deletedBy = json['deleted_by'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//     if (json['receiver'] != null) {
//       userInfo = <ChatUserInfo>[];
//       json['receiver'].forEach((v) {
//         userInfo!.add(ChatUserInfo.fromJson(v));
//       });
//     }
//     if (json['sender'] != null) {
//       sender = <ChatUserInfo>[];
//       json['sender'].forEach((v) {
//         sender!.add(ChatUserInfo.fromJson(v));
//       });
//     }
//     reciverOnline =
//         ((json['senderOnlineStatus'] ?? [0]) as List).first.toString();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['unread_count'] = unreadCount;
//     data['_id'] = sId;
//     data['sender_id'] = senderId;
//     data['receiver_id'] = receiverId;
//     data['constant_id'] = constantId;
//     data['message'] = message;
//     data['thumbnail'] = thumbnail;
//     data['is_read'] = isRead;
//     data['type'] = type;
//     data['deleted_by'] = deletedBy;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//     if (userInfo != null) {
//       data['receiver'] = userInfo!.map((v) => v.toJson()).toList();
//     }
//     if (sender != null) {
//       data['sender'] = sender!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class ChatUserInfo {
//   String? sId;
//   String? firstname;
//   String? lastname;
//   String? email;
//   int? countryCode;
//   int? phone;
//   String? image;
//   String? bio;
//   int? status;
//   String? deviceToken;
//   int? deviceType;
//   int? otpverify;
//   String? loginTime;
//   String? stripeCustomer;
//   String? role;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;

//   ChatUserInfo(
//       {this.sId,
//       this.firstname,
//       this.lastname,
//       this.email,
//       this.countryCode,
//       this.phone,
//       this.image,
//       this.bio,
//       this.status,
//       this.deviceToken,
//       this.deviceType,
//       this.otpverify,
//       this.loginTime,
//       this.stripeCustomer,
//       this.role,
//       this.createdAt,
//       this.updatedAt,
//       this.iV});

//   ChatUserInfo.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     firstname = json['firstname'];
//     lastname = json['lastname'];
//     email = json['email'];
//     countryCode = json['country_code'];
//     phone = json['phone'];
//     image = json['image'];
//     bio = json['bio'];
//     status = json['status'];
//     deviceToken = json['device_token'];
//     deviceType = json['device_type'];
//     otpverify = json['otpverify'];
//     loginTime = json['loginTime'];
//     stripeCustomer = json['stripe_customer'];
//     role = json['role'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['firstname'] = firstname;
//     data['lastname'] = lastname;
//     data['email'] = email;
//     data['country_code'] = countryCode;
//     data['phone'] = phone;
//     data['image'] = image;
//     data['bio'] = bio;
//     data['status'] = status;
//     data['device_token'] = deviceToken;
//     data['device_type'] = deviceType;
//     data['otpverify'] = otpverify;
//     data['loginTime'] = loginTime;
//     data['stripe_customer'] = stripeCustomer;
//     data['role'] = role;
//     data['createdAt'] = createdAt;
//     data['updatedAt'] = updatedAt;
//     data['__v'] = iV;
//     return data;
//   }
// }
