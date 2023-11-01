import 'category_model.dart';

class HomeModel {
  List<ImageModel>? image;
  List<CategoryModel>? category;
  int? notificationCount;

  HomeModel({this.image, this.category, this.notificationCount});

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['image'] != null) {
      image = <ImageModel>[];
      json['image'].forEach((v) {
        image!.add(ImageModel.fromJson(v));
      });
    }
    if (json['category'] != null) {
      category = <CategoryModel>[];
      json['category'].forEach((v) {
        category!.add(CategoryModel.fromJson(v));
      });
    }
    notificationCount = json['notificationCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (image != null) {
      data['image'] = image!.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    data['notificationCount'] = notificationCount;
    return data;
  }
}

class ImageModel {
  int? id;
  String? image;
  String? createdAt;
  String? updatedAt;

  ImageModel({this.id, this.image, this.createdAt, this.updatedAt});

  ImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
