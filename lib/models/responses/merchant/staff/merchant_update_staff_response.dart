// To parse this JSON data, do
//
//     final merchantUpdateStaffResponse = merchantUpdateStaffResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MerchantUpdateStaffResponse merchantUpdateStaffResponseFromMap(String str) => MerchantUpdateStaffResponse.fromMap(json.decode(str));

String merchantUpdateStaffResponseToMap(MerchantUpdateStaffResponse data) => json.encode(data.toMap());

class MerchantUpdateStaffResponse {
    bool success;
    String message;

    MerchantUpdateStaffResponse({
        required this.success,
        required this.message,
    });

    factory MerchantUpdateStaffResponse.fromMap(Map<String, dynamic> json) => MerchantUpdateStaffResponse(
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
    };
}
