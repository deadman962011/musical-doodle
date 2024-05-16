// To parse this JSON data, do
//
//     final merchantAvailabilityToggleDayStatusResponse = merchantAvailabilityToggleDayStatusResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MerchantAvailabilityToggleDayStatusResponse merchantAvailabilityToggleDayStatusResponseFromMap(String str) => MerchantAvailabilityToggleDayStatusResponse.fromMap(json.decode(str));

String merchantAvailabilityToggleDayStatusResponseToMap(MerchantAvailabilityToggleDayStatusResponse data) => json.encode(data.toMap());

class MerchantAvailabilityToggleDayStatusResponse {
    bool success;
    dynamic payload;
    String message;

    MerchantAvailabilityToggleDayStatusResponse({
        required this.success,
        required this.payload,
        required this.message,
    });

    factory MerchantAvailabilityToggleDayStatusResponse.fromMap(Map<String, dynamic> json) => MerchantAvailabilityToggleDayStatusResponse(
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
