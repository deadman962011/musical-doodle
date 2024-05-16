// To parse this JSON data, do
//
//     final merchantResponse = merchantResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MerchantResponse merchantResponseFromMap(String str) =>
    MerchantResponse.fromMap(json.decode(str));

String merchantResponseToMap(MerchantResponse data) =>
    json.encode(data.toMap());

class MerchantResponse {
  bool success;
  Payload payload;
  String message;

  MerchantResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory MerchantResponse.fromMap(Map<String, dynamic> json) =>
      MerchantResponse(
        success: json["success"],
        payload: Payload.fromMap(json["payload"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "payload": payload.toMap(),
        "message": message,
      };
}

class Payload {
  int id;
  String shopName;
  String longitude;
  String latitude;
  String address;
  String taxRegister;
  String shopContactEmail;
  String shopContactPhone;
  int featured;
  int status;
  int isDeleted;
  int shopLogo;
  int zoneId;
  DateTime createdAt;
  DateTime updatedAt;
  double distance;
  List<Translation> translations;
  Categories categories;

  Payload({
    required this.id,
    required this.shopName,
    required this.longitude,
    required this.latitude,
    required this.address,
    required this.taxRegister,
    required this.shopContactEmail,
    required this.shopContactPhone,
    required this.featured,
    required this.status,
    required this.isDeleted,
    required this.shopLogo,
    required this.zoneId,
    required this.createdAt,
    required this.updatedAt,
    required this.distance,
    required this.translations,
    required this.categories,
  });

  factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        id: json["id"],
        shopName: json["shop_name"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        address: json["address"],
        taxRegister: json["tax_register"],
        shopContactEmail: json["shop_contact_email"],
        shopContactPhone: json["shop_contact_phone"],
        featured: json["featured"],
        status: json["status"],
        isDeleted: json["isDeleted"],
        shopLogo: json["shop_logo"],
        zoneId: json["zone_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        distance: json["distance"]?.toDouble(),
        translations: List<Translation>.from(
            json["translations"].map((x) => Translation.fromMap(x))),
        categories: Categories.fromMap(json["categories"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "shop_name": shopName,
        "longitude": longitude,
        "latitude": latitude,
        "address": address,
        "tax_register": taxRegister,
        "shop_contact_email": shopContactEmail,
        "shop_contact_phone": shopContactPhone,
        "featured": featured,
        "status": status,
        "isDeleted": isDeleted,
        "shop_logo": shopLogo,
        "zone_id": zoneId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "distance": distance,
        "translations": List<dynamic>.from(translations.map((x) => x.toMap())),
        "categories": categories.toMap(),
      };
}

class Categories {
  int id;
  int categoryId;
  int shopId;
  DateTime createdAt;
  DateTime updatedAt;

  Categories({
    required this.id,
    required this.categoryId,
    required this.shopId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Categories.fromMap(Map<String, dynamic> json) => Categories(
        id: json["id"],
        categoryId: json["category_id"],
        shopId: json["shop_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "category_id": categoryId,
        "shop_id": shopId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Translation {
  int id;
  String key;
  String value;
  String lang;
  int shopId;
  DateTime createdAt;
  DateTime updatedAt;

  Translation({
    required this.id,
    required this.key,
    required this.value,
    required this.lang,
    required this.shopId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Translation.fromMap(Map<String, dynamic> json) => Translation(
        id: json["id"],
        key: json["key"],
        value: json["value"],
        lang: json["lang"],
        shopId: json["shop_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "key": key,
        "value": value,
        "lang": lang,
        "shop_id": shopId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
