// To parse this JSON data, do
//
//     final merchantRoleDetailsResponse = merchantRoleDetailsResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MerchantRoleDetailsResponse merchantRoleDetailsResponseFromMap(String str) =>
    MerchantRoleDetailsResponse.fromMap(json.decode(str));

String merchantRoleDetailsResponseToMap(MerchantRoleDetailsResponse data) =>
    json.encode(data.toMap());

class MerchantRoleDetailsResponse {
  bool success;
  RoleDetails payload;
  String message;

  MerchantRoleDetailsResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory MerchantRoleDetailsResponse.fromMap(Map<String, dynamic> json) =>
      MerchantRoleDetailsResponse(
        success: json["success"],
        payload: RoleDetails.fromMap(json["payload"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "payload": payload.toMap(),
        "message": message,
      };
}

class RoleDetails {
  String roleNameInArabic;
  String roleNameInEnglish;
  List<String> permissions;

  RoleDetails({
    required this.roleNameInArabic,
    required this.roleNameInEnglish,
    required this.permissions,
  });

  factory RoleDetails.fromMap(Map<String, dynamic> json) => RoleDetails(
        roleNameInArabic: json["role_name_in_arabic"],
        roleNameInEnglish: json["role_name_in_english"],
        permissions: List<String>.from(json["permissions"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "role_name_in_arabic": roleNameInArabic,
        "role_name_in_english": roleNameInEnglish,
        "permissions": List<dynamic>.from(permissions.map((x) => x)),
      };
}
