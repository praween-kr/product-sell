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
