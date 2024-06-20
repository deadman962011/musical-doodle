// To parse this JSON data, do
//
//     final merchantSaveRoleResponse = merchantSaveRoleResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MerchantSaveRoleResponse merchantSaveRoleResponseFromMap(String str) => MerchantSaveRoleResponse.fromMap(json.decode(str));

String merchantSaveRoleResponseToMap(MerchantSaveRoleResponse data) => json.encode(data.toMap());

class MerchantSaveRoleResponse {
    bool success;
    String message;

    MerchantSaveRoleResponse({
        required this.success,
        required this.message,
    });

    factory MerchantSaveRoleResponse.fromMap(Map<String, dynamic> json) => MerchantSaveRoleResponse(
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
    };
}
