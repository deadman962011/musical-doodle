// To parse this JSON data, do
//
//     final merchantAvailabilityAddSlotResponse = merchantAvailabilityAddSlotResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MerchantAvailabilityAddSlotResponse merchantAvailabilityAddSlotResponseFromMap(
        String str) =>
    MerchantAvailabilityAddSlotResponse.fromMap(json.decode(str));

String merchantAvailabilityAddSlotResponseToMap(
        MerchantAvailabilityAddSlotResponse data) =>
    json.encode(data.toMap());

class MerchantAvailabilityAddSlotResponse {
  bool success;
  dynamic payload;
  String message;

  MerchantAvailabilityAddSlotResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory MerchantAvailabilityAddSlotResponse.fromMap(
          Map<String, dynamic> json) =>
      MerchantAvailabilityAddSlotResponse(
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
