class DashboardInfo {
  List<SharePurchaseCount>? sharePurchaseCount;
  List<BidProductCount>? bidProductCount;
  List<FixedProductCount>? fixedProductCount;
  List<TotalShareProfilt>? totalShareProfilt;
  SellershareSold? sellershareSold;
  BidProductSellCount? bidProductSellCount;
  FixedProductSellCount? fixedProductSellCount;

  DashboardInfo(
      {this.sharePurchaseCount,
      this.bidProductCount,
      this.fixedProductCount,
      this.totalShareProfilt,
      this.sellershareSold,
      this.bidProductSellCount,
      this.fixedProductSellCount});

  DashboardInfo.fromJson(Map<String, dynamic> json) {
    if (json['sharePurchaseCount'] != null) {
      sharePurchaseCount = <SharePurchaseCount>[];
      json['sharePurchaseCount'].forEach((v) {
        sharePurchaseCount!.add(SharePurchaseCount.fromJson(v));
      });
    }
    if (json['bidProductCount'] != null) {
      bidProductCount = <BidProductCount>[];
      json['bidProductCount'].forEach((v) {
        bidProductCount!.add(BidProductCount.fromJson(v));
      });
    }
    if (json['fixedProductCount'] != null) {
      fixedProductCount = <FixedProductCount>[];
      json['fixedProductCount'].forEach((v) {
        fixedProductCount!.add(FixedProductCount.fromJson(v));
      });
    }
    if (json['totalShareProfilt'] != null) {
      totalShareProfilt = <TotalShareProfilt>[];
      json['totalShareProfilt'].forEach((v) {
        totalShareProfilt!.add(TotalShareProfilt.fromJson(v));
      });
    }
    sellershareSold = json['sellershareSold'] != null
        ? SellershareSold.fromJson(json['sellershareSold'])
        : null;
    bidProductSellCount = json['bidProductSellCount'] != null
        ? BidProductSellCount.fromJson(json['bidProductSellCount'])
        : null;
    fixedProductSellCount = json['fixedProductSellCount'] != null
        ? FixedProductSellCount.fromJson(json['fixedProductSellCount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sharePurchaseCount != null) {
      data['sharePurchaseCount'] =
          sharePurchaseCount!.map((v) => v.toJson()).toList();
    }
    if (bidProductCount != null) {
      data['bidProductCount'] =
          bidProductCount!.map((v) => v.toJson()).toList();
    }
    if (fixedProductCount != null) {
      data['fixedProductCount'] =
          fixedProductCount!.map((v) => v.toJson()).toList();
    }
    if (totalShareProfilt != null) {
      data['totalShareProfilt'] =
          totalShareProfilt!.map((v) => v.toJson()).toList();
    }
    if (sellershareSold != null) {
      data['sellershareSold'] = sellershareSold!.toJson();
    }
    if (bidProductSellCount != null) {
      data['bidProductSellCount'] = bidProductSellCount!.toJson();
    }
    if (fixedProductSellCount != null) {
      data['fixedProductSellCount'] = fixedProductSellCount!.toJson();
    }
    return data;
  }
}

class SharePurchaseCount {
  int? productId;
  String? totalShares;
  String? totalAmount;

  SharePurchaseCount({this.productId, this.totalShares, this.totalAmount});

  SharePurchaseCount.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    totalShares = json['totalShares'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['totalShares'] = totalShares;
    data['totalAmount'] = totalAmount;
    return data;
  }
}

class BidProductCount {
  int? productId;
  String? totalAmount;

  BidProductCount({this.productId, this.totalAmount});

  BidProductCount.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['totalAmount'] = totalAmount;
    return data;
  }
}

class SellershareSold {
  int? totalShareSold;
  int? totalShare;

  SellershareSold({this.totalShareSold, this.totalShare});

  SellershareSold.fromJson(Map<String, dynamic> json) {
    totalShareSold = json['totalShareSold'];
    totalShare = json['totalShare'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalShareSold'] = totalShareSold;
    data['totalShare'] = totalShare;
    return data;
  }
}

class BidProductSellCount {
  int? bidProductSellCount;
  int? totalbidProduct;

  BidProductSellCount({this.bidProductSellCount, this.totalbidProduct});

  BidProductSellCount.fromJson(Map<String, dynamic> json) {
    bidProductSellCount = json['bidProductSellCount'];
    totalbidProduct = json['totalbidProduct'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bidProductSellCount'] = bidProductSellCount;
    data['totalbidProduct'] = totalbidProduct;
    return data;
  }
}

class FixedProductSellCount {
  int? fixedProductSellCount;
  int? totalfixed;

  FixedProductSellCount({this.fixedProductSellCount, this.totalfixed});

  FixedProductSellCount.fromJson(Map<String, dynamic> json) {
    fixedProductSellCount = json['fixedProductSellCount'];
    totalfixed = json['totalfixed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fixedProductSellCount'] = fixedProductSellCount;
    data['totalfixed'] = totalfixed;
    return data;
  }
}

class FixedProductCount {
  int? productId;
  String? totalAmount;

  FixedProductCount({this.productId, this.totalAmount});

  FixedProductCount.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = productId;
    data['totalAmount'] = totalAmount;
    return data;
  }
}

class TotalShareProfilt {
  String? totalProfit;

  TotalShareProfilt({this.totalProfit});

  TotalShareProfilt.fromJson(Map<String, dynamic> json) {
    totalProfit = json['totalProfit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalProfit'] = totalProfit;
    return data;
  }
}
