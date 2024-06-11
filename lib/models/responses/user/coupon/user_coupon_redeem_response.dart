// To parse this JSON data, do
//
//     final UserCouponRedeemResponse = UserCouponRedeemResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserCouponRedeemResponse UserCouponRedeemResponseFromMap(String str) =>
    UserCouponRedeemResponse.fromMap(json.decode(str));

String UserCouponRedeemResponseToMap(UserCouponRedeemResponse data) =>
    json.encode(data.toMap());

class UserCouponRedeemResponse {
  bool success;
  dynamic payload;
  String message;

  UserCouponRedeemResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory UserCouponRedeemResponse.fromMap(Map<String, dynamic> json) =>
      UserCouponRedeemResponse(
        success: json["success"],
        payload: json["payload"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "payload": payload,
        "message": message,
      };
}
