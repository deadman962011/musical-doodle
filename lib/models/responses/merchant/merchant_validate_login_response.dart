// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

MerchantValidateLoginResponse merchantValidateloginResponseFromJson(String str) => MerchantValidateLoginResponse.fromJson(json.decode(str));

class MerchantValidateLoginResponse {
  MerchantValidateLoginResponse({
    required this.success,
    required this.payload
  });

  bool success;
  Map<String,dynamic> payload;

  factory MerchantValidateLoginResponse.fromJson(Map<String, dynamic> json) => MerchantValidateLoginResponse(
    success: json["success"],
    payload: json['payload']
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "payload": payload
  };
}

