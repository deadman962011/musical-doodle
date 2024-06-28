// To parse this JSON data, do
//
//     final merchantUpdateRoleResponse = merchantUpdateRoleResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MerchantUpdateRoleResponse merchantUpdateRoleResponseFromMap(String str) => MerchantUpdateRoleResponse.fromMap(json.decode(str));

String merchantUpdateRoleResponseToMap(MerchantUpdateRoleResponse data) => json.encode(data.toMap());

class MerchantUpdateRoleResponse {
    bool success;
    String message;

    MerchantUpdateRoleResponse({
        required this.success,
        required this.message,
    });

    factory MerchantUpdateRoleResponse.fromMap(Map<String, dynamic> json) => MerchantUpdateRoleResponse(
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
    };
}
