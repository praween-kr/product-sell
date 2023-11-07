import 'package:oninto_flutter/model/home/category_model.dart';

class ProductDetails {
  int? id;
  int? isApproved;
  int? status;
  int? isVeg;
  int? type;
  int? taxCategoryId;
  int? vendorId;
  int? categoryId;
  int? subCategoryId;
  int? quantity;
  String? name;
  String? location;
  String? latitude;
  String? longitude;
  String? color;
  String? brand;
  String? productCondition;
  String? sellOption;
  String? price;
  String? boostCode;
  String? startDate;
  String? endDate;
  int? share;
  String? description;
  String? otherDescription;
  String? image;
  String? barcode;
  String? barcodeImage;
  String? sku;
  String? skuImage;
  String? brandName;
  String? mrp;
  String? minimumSellingPrice;
  int? percentageDiscount;
  String? length;
  String? width;
  String? height;
  int? dimensionsUnit;
  String? weight;
  int? weightUnit;
  String? createdAt;
  String? updatedAt;
  double? averageRating;
  int? favorite;
  CategoryModel? category;
  List<ProductImages>? productImages;
  List<void>? productSizes;

  ProductDetails(
      {this.id,
      this.isApproved,
      this.status,
      this.isVeg,
      this.type,
      this.taxCategoryId,
      this.vendorId,
      this.categoryId,
      this.subCategoryId,
      this.quantity,
      this.name,
      this.location,
      this.latitude,
      this.longitude,
      this.color,
      this.brand,
      this.productCondition,
      this.sellOption,
      this.price,
      this.boostCode,
      this.startDate,
      this.endDate,
      this.share,
      this.description,
      this.otherDescription,
      this.image,
      this.barcode,
      this.barcodeImage,
      this.sku,
      this.skuImage,
      this.brandName,
      this.mrp,
      this.minimumSellingPrice,
      this.percentageDiscount,
      this.length,
      this.width,
      this.height,
      this.dimensionsUnit,
      this.weight,
      this.weightUnit,
      this.createdAt,
      this.updatedAt,
      this.averageRating,
      this.favorite,
      this.category,
      this.productImages,
      this.productSizes});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isApproved = json['isApproved'];
    status = json['status'];
    isVeg = json['isVeg'];
    type = json['type'];
    taxCategoryId = json['taxCategoryId'];
    vendorId = json['vendorId'];
    categoryId = json['categoryId'];
    subCategoryId = json['subCategoryId'];
    quantity = json['quantity'];
    name = json['name'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    color = json['color'];
    brand = json['brand'];
    productCondition = json['productCondition'];
    sellOption = json['sellOption'];
    price = json['price'];
    boostCode = json['boostCode'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    share = json['share'];
    description = json['description'];
    otherDescription = json['otherDescription'];
    image = json['image'];
    barcode = json['barcode'];
    barcodeImage = json['barcodeImage'];
    sku = json['sku'];
    skuImage = json['skuImage'];
    brandName = json['brandName'];
    mrp = json['mrp'];
    minimumSellingPrice = json['minimumSellingPrice'];
    percentageDiscount = json['percentageDiscount'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    dimensionsUnit = json['dimensionsUnit'];
    weight = json['weight'];
    weightUnit = json['weightUnit'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    averageRating = json['averageRating'];
    favorite = json['favorite'];
    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(ProductImages.fromJson(v));
      });
    }
    if (json['product_sizes'] != null) {
      productSizes = <Null>[];
      json['product_sizes'].forEach((v) {
        //productSizes!.add(new Null.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isApproved'] = isApproved;
    data['status'] = status;
    data['isVeg'] = isVeg;
    data['type'] = type;
    data['taxCategoryId'] = taxCategoryId;
    data['vendorId'] = vendorId;
    data['categoryId'] = categoryId;
    data['subCategoryId'] = subCategoryId;
    data['quantity'] = quantity;
    data['name'] = name;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['color'] = color;
    data['brand'] = brand;
    data['productCondition'] = productCondition;
    data['sellOption'] = sellOption;
    data['price'] = price;
    data['boostCode'] = boostCode;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['share'] = share;
    data['description'] = description;
    data['otherDescription'] = otherDescription;
    data['image'] = image;
    data['barcode'] = barcode;
    data['barcodeImage'] = barcodeImage;
    data['sku'] = sku;
    data['skuImage'] = skuImage;
    data['brandName'] = brandName;
    data['mrp'] = mrp;
    data['minimumSellingPrice'] = minimumSellingPrice;
    data['percentageDiscount'] = percentageDiscount;
    data['length'] = length;
    data['width'] = width;
    data['height'] = height;
    data['dimensionsUnit'] = dimensionsUnit;
    data['weight'] = weight;
    data['weightUnit'] = weightUnit;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['averageRating'] = averageRating;
    data['favorite'] = favorite;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (productImages != null) {
      data['product_images'] = productImages!.map((v) => v.toJson()).toList();
    }
    if (productSizes != null) {
      // data['product_sizes'] = productSizes!.map((v) => v.toJson()).toList();
    }
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
