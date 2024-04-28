// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

MerchantValidateRegisterResponse merchantValidateRegisterResponseFromJson(String str) =>MerchantValidateRegisterResponse.fromJson(json.decode(str));

class MerchantValidateRegisterResponse {
  MerchantValidateRegisterResponse(
      {required this.success,
       required this.payload
       });

  bool success;
  Map<String,dynamic> payload;

  factory MerchantValidateRegisterResponse.fromJson(
          Map<String, dynamic> json) =>
      MerchantValidateRegisterResponse(
          success: json["success"], payload: json['payload']);

  Map<String, dynamic> toJson() => {"success": success, "payload": payload};
}
