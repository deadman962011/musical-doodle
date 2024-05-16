// To parse this JSON data, do
//
//     final merchantUpdateContactResponse = merchantUpdateContactResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MerchantUpdateContactResponse merchantUpdateContactResponseFromMap(
        String str) =>
    MerchantUpdateContactResponse.fromMap(json.decode(str));

String merchantUpdateContactResponseToMap(MerchantUpdateContactResponse data) =>
    json.encode(data.toMap());

class MerchantUpdateContactResponse {
  bool success;
  dynamic payload;
  String message;

  MerchantUpdateContactResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory MerchantUpdateContactResponse.fromMap(Map<String, dynamic> json) =>
      MerchantUpdateContactResponse(
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
