// To parse this JSON data, do
//
//     final merchantSaveStaffResponse = merchantSaveStaffResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MerchantSaveStaffResponse merchantSaveStaffResponseFromMap(String str) => MerchantSaveStaffResponse.fromMap(json.decode(str));

String merchantSaveStaffResponseToMap(MerchantSaveStaffResponse data) => json.encode(data.toMap());

class MerchantSaveStaffResponse {
    bool success;
    String message;

    MerchantSaveStaffResponse({
        required this.success,
        required this.message,
    });

    factory MerchantSaveStaffResponse.fromMap(Map<String, dynamic> json) => MerchantSaveStaffResponse(
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
    };
}
