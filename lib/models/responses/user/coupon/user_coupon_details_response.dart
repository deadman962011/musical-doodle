// To parse this JSON data, do
//
//     final userCouponDetailsResponse = userCouponDetailsResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserCouponDetailsResponse userCouponDetailsResponseFromMap(String str) =>
    UserCouponDetailsResponse.fromMap(json.decode(str));

String userCouponDetailsResponseToMap(UserCouponDetailsResponse data) =>
    json.encode(data.toMap());

class UserCouponDetailsResponse {
  bool success;
  CouponDetailsItem payload;
  String message;

  UserCouponDetailsResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory UserCouponDetailsResponse.fromMap(Map<String, dynamic> json) =>
      UserCouponDetailsResponse(
        success: json["success"],
        payload: CouponDetailsItem.fromMap(json["payload"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "payload": payload.toMap(),
        "message": message,
      };
}

class CouponDetailsItem {
  int id;
  String name;
  String description;
  String refundDetails;
  String thumbnail;
  List<CouponVariation> variations;
  String minAmount;
  String maxAmount;
  String expirey_unit;
  int expirey_amount;

  CouponDetailsItem(
      {required this.id,
      required this.name,
      required this.description,
      required this.refundDetails,
      required this.thumbnail,
      required this.variations,
      required this.minAmount,
      required this.maxAmount,
      required this.expirey_unit,
      required this.expirey_amount});

  factory CouponDetailsItem.fromMap(Map<String, dynamic> json) =>
      CouponDetailsItem(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        refundDetails: json["refund_details"],
        variations: List<CouponVariation>.from(
            json["variations"].map((x) => CouponVariation.fromMap(x))),
        thumbnail: json['thumbnail'],
        minAmount: json["min_amount"],
        maxAmount: json["max_amount"],
        expirey_unit: json["expirey_unit"],
        expirey_amount: json["expirey_amount"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "refund_details": refundDetails,
        "variations":
            List<CouponVariation>.from(variations.map((x) => x.toMap())),
        "min_amount": minAmount,
        "max_amount": maxAmount,
      };
}

class CouponVariation {
  int id;
  String amount;
  bool is_active;

  CouponVariation(
      {required this.id, required this.amount, required this.is_active});

  factory CouponVariation.fromMap(Map<String, dynamic> json) => CouponVariation(
        id: json["id"],
        amount: json["amount"],
        is_active: json["is_active"],
      );

  Map<String, dynamic> toMap() =>
      {"id": id, "amount": amount, "is_active": is_active};
}
