// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

MerchantLoginResponse merchantloginResponseFromJson(String str) => MerchantLoginResponse.fromJson(json.decode(str));

class MerchantLoginResponse {
  MerchantLoginResponse({
    required this.success,
  });

  bool success;

  factory MerchantLoginResponse.fromJson(Map<String, dynamic> json) => MerchantLoginResponse(
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
  };
}

