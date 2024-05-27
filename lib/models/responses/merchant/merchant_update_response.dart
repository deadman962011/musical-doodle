// To parse this JSON data, do
//
//     final merchantUpdateResponse = merchantUpdateResponseFromMap(jsonString);

import 'dart:convert';

MerchantUpdateResponse merchantUpdateResponseFromMap(String str) =>
    MerchantUpdateResponse.fromMap(json.decode(str));

String merchantUpdateResponseToMap(MerchantUpdateResponse data) =>
    json.encode(data.toMap());

class MerchantUpdateResponse {
  bool success;
  dynamic payload;
  String message;

  MerchantUpdateResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory MerchantUpdateResponse.fromMap(Map<String, dynamic> json) =>
      MerchantUpdateResponse(
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
