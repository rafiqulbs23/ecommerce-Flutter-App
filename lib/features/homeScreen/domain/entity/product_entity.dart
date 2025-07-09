// To parse this JSON data, do
//
//     final productEntity = productEntityFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'product_entity.g.dart';

ProductEntity productEntityFromJson(String str) => ProductEntity.fromJson(json.decode(str));

String productEntityToJson(ProductEntity data) => json.encode(data.toJson());

@JsonSerializable()
class ProductEntity {
  @JsonKey(name: "products")
  List<Product> products;
  @JsonKey(name: "total")
  int total;
  @JsonKey(name: "skip")
  int skip;
  @JsonKey(name: "limit")
  int limit;

  ProductEntity({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json) => _$ProductEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ProductEntityToJson(this);
}

@JsonSerializable()
class Product {
  @JsonKey(name: "id")
  int id;
  @JsonKey(name: "title")
  String title;
  @JsonKey(name: "description")
  String description;
  @JsonKey(name: "category")
  Category category;
  @JsonKey(name: "price")
  double price;
  @JsonKey(name: "discountPercentage")
  double discountPercentage;
  @JsonKey(name: "rating")
  double rating;
  @JsonKey(name: "stock")
  int stock;
  @JsonKey(name: "tags")
  List<String> tags;
  @JsonKey(name: "brand")
  String? brand;
  @JsonKey(name: "sku")
  String sku;
  @JsonKey(name: "weight")
  int weight;
  @JsonKey(name: "dimensions")
  Dimensions dimensions;
  @JsonKey(name: "warrantyInformation")
  String warrantyInformation;
  @JsonKey(name: "shippingInformation")
  String shippingInformation;
  @JsonKey(name: "availabilityStatus")
  AvailabilityStatus availabilityStatus;
  @JsonKey(name: "reviews")
  List<Review> reviews;
  @JsonKey(name: "returnPolicy")
  ReturnPolicy returnPolicy;
  @JsonKey(name: "minimumOrderQuantity")
  int minimumOrderQuantity;
  @JsonKey(name: "meta")
  Meta meta;
  @JsonKey(name: "images")
  List<String> images;
  @JsonKey(name: "thumbnail")
  String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    this.brand,
    required this.sku,
    required this.weight,
    required this.dimensions,
    required this.warrantyInformation,
    required this.shippingInformation,
    required this.availabilityStatus,
    required this.reviews,
    required this.returnPolicy,
    required this.minimumOrderQuantity,
    required this.meta,
    required this.images,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

enum AvailabilityStatus {
  @JsonValue("In Stock")
  IN_STOCK,
  @JsonValue("Low Stock")
  LOW_STOCK
}

final availabilityStatusValues = EnumValues({
  "In Stock": AvailabilityStatus.IN_STOCK,
  "Low Stock": AvailabilityStatus.LOW_STOCK
});

enum Category {
  @JsonValue("beauty")
  BEAUTY,
  @JsonValue("fragrances")
  FRAGRANCES,
  @JsonValue("furniture")
  FURNITURE,
  @JsonValue("groceries")
  GROCERIES
}

final categoryValues = EnumValues({
  "beauty": Category.BEAUTY,
  "fragrances": Category.FRAGRANCES,
  "furniture": Category.FURNITURE,
  "groceries": Category.GROCERIES
});

@JsonSerializable()
class Dimensions {
  @JsonKey(name: "width")
  double width;
  @JsonKey(name: "height")
  double height;
  @JsonKey(name: "depth")
  double depth;

  Dimensions({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory Dimensions.fromJson(Map<String, dynamic> json) => _$DimensionsFromJson(json);

  Map<String, dynamic> toJson() => _$DimensionsToJson(this);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: "createdAt")
  DateTime createdAt;
  @JsonKey(name: "updatedAt")
  DateTime updatedAt;
  @JsonKey(name: "barcode")
  String barcode;
  @JsonKey(name: "qrCode")
  String qrCode;

  Meta({
    required this.createdAt,
    required this.updatedAt,
    required this.barcode,
    required this.qrCode,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

enum ReturnPolicy {
  @JsonValue("No return policy")
  NO_RETURN_POLICY,
  @JsonValue("30 days return policy")
  THE_30_DAYS_RETURN_POLICY,
  @JsonValue("60 days return policy")
  THE_60_DAYS_RETURN_POLICY,
  @JsonValue("7 days return policy")
  THE_7_DAYS_RETURN_POLICY,
  @JsonValue("90 days return policy")
  THE_90_DAYS_RETURN_POLICY
}

final returnPolicyValues = EnumValues({
  "No return policy": ReturnPolicy.NO_RETURN_POLICY,
  "30 days return policy": ReturnPolicy.THE_30_DAYS_RETURN_POLICY,
  "60 days return policy": ReturnPolicy.THE_60_DAYS_RETURN_POLICY,
  "7 days return policy": ReturnPolicy.THE_7_DAYS_RETURN_POLICY,
  "90 days return policy": ReturnPolicy.THE_90_DAYS_RETURN_POLICY
});

@JsonSerializable()
class Review {
  @JsonKey(name: "rating")
  int rating;
  @JsonKey(name: "comment")
  String comment;
  @JsonKey(name: "date")
  DateTime date;
  @JsonKey(name: "reviewerName")
  String reviewerName;
  @JsonKey(name: "reviewerEmail")
  String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
