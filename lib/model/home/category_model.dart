class CategoryModel {
  int? id;
  int? categoryId;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;
  CategoryModel? subCategory;

  CategoryModel(
      {this.id,
      this.name,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.subCategory});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    name = json['name'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    subCategory = json['subCategory'] != null
        ? CategoryModel.fromJson(json['subCategory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['categoryId'] = categoryId;
    data['name'] = name;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (subCategory != null) {
      data['subCategory'] = subCategory!.toJson();
    }
    return data;
  }
}
