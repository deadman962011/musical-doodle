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
  String shopNameAr;
  String shopNameEn;
  String? shopContactEmail;
  String? shopContactPhone;
  String? shopContactWebsite;

  Payload({
    required this.id,
    required this.shopNameAr,
    required this.shopNameEn,
    required this.shopContactEmail,
    required this.shopContactPhone,
    required this.shopContactWebsite,
  });

  factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        id: json["id"],
        shopNameAr: json["shop_name_ar"],
        shopNameEn: json["shop_name_en"],
        shopContactEmail: json["shop_contact_email"],
        shopContactPhone: json["shop_contact_phone"],
        shopContactWebsite: json["shop_contact_website"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "shop_name_ar": shopNameAr,
        "shop_name_en": shopNameEn,
        "shop_contact_email": shopContactEmail,
        "shop_contact_phone": shopContactPhone,
        "shop_contact_website": shopContactWebsite
      };
}
