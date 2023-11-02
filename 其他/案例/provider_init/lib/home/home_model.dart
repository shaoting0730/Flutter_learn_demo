

// To parse this JSON data, do
//
//     final HomeModel = HomeModelFromJson(jsonString);

import 'dart:convert';

HomeModel HomeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String HomeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  int? id;
  int? memberId;
  int? topicId;
  String? topicType;
  String? createdAt;
  String? updatedAt;
  String? remark;
  Product? product;

  HomeModel({
    this.id,
    this.memberId,
    this.topicId,
    this.topicType,
    this.createdAt,
    this.updatedAt,
    this.remark,
    this.product,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    id: json["id"],
    memberId: json["member_id"],
    topicId: json["topic_id"],
    topicType: json["topic_type"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    remark: json["remark"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "member_id": memberId,
    "topic_id": topicId,
    "topic_type": topicType,
    "created_at": createdAt,
    "remark": remark,
    "updated_at": updatedAt,
    "product": product?.toJson(),
  };
}

class Product {
  int? id;
  String? name;
  String? picture;
  int? star;
  int? transmitNum;
  int? commentNum;
  int? collectNum;
  int? view;
  MinPriceSku? minPriceSku;

  Product({
    this.id,
    this.name,
    this.picture,
    this.star,
    this.transmitNum,
    this.commentNum,
    this.collectNum,
    this.view,
    this.minPriceSku,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    picture: json["picture"],
    star: json["star"],
    transmitNum: json["transmit_num"],
    commentNum: json["comment_num"],
    collectNum: json["collect_num"],
    view: json["view"],
    minPriceSku: json["min_price_sku"] == null ? null : MinPriceSku.fromJson(json["min_price_sku"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "picture": picture,
    "star": star,
    "transmit_num": transmitNum,
    "comment_num": commentNum,
    "collect_num": collectNum,
    "view": view,
    "min_price_sku": minPriceSku?.toJson(),
  };
}

class MinPriceSku {
  int? id;
  int? productId;
  String? price;
  String? marketPrice;
  int? stock;

  MinPriceSku({
    this.id,
    this.productId,
    this.price,
    this.marketPrice,
    this.stock,
  });

  factory MinPriceSku.fromJson(Map<String, dynamic> json) => MinPriceSku(
    id: json["id"],
    productId: json["product_id"],
    price: json["price"],
    marketPrice: json["market_price"],
    stock: json["stock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "price": price,
    "market_price": marketPrice,
    "stock": stock,
  };
}
