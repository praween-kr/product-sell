class AddressModel {
  int? id;
  int? userId;
  String? location;
  String? latitude;
  String? longitude;
  String? street;
  String? houseNo;
  String? landMark;
  String? createdAt;
  String? updatedAt;

  AddressModel(
      {this.id,
      this.userId,
      this.location,
      this.latitude,
      this.longitude,
      this.street,
      this.houseNo,
      this.landMark,
      this.createdAt,
      this.updatedAt});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    street = json['street'];
    houseNo = json['houseNo'];
    landMark = json['landMark'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['street'] = street;
    data['houseNo'] = houseNo;
    data['landMark'] = landMark;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
