// To parse this JSON data, do
//
//     final merchantPermissionsResponse = merchantPermissionsResponseFromMap(jsonString);

import 'dart:convert';

MerchantPermissionsResponse merchantPermissionsResponseFromMap(String str) =>
    MerchantPermissionsResponse.fromMap(json.decode(str));

String merchantPermissionsResponseToMap(MerchantPermissionsResponse data) =>
    json.encode(data.toMap());

class MerchantPermissionsResponse {
  bool success;
  List<MerchantPermission> payload;
  String message;

  MerchantPermissionsResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory MerchantPermissionsResponse.fromMap(Map<String, dynamic> json) =>
      MerchantPermissionsResponse(
        success: json["success"],
        payload: List<MerchantPermission>.from(
            json["payload"].map((x) => MerchantPermission.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "payload": List<dynamic>.from(payload.map((x) => x.toMap())),
        "message": message,
      };
}

class MerchantPermission {
  int id;
  String key;
  String name;

  MerchantPermission({
    required this.id,
    required this.key,
    required this.name,
  });

  factory MerchantPermission.fromMap(Map<String, dynamic> json) =>
      MerchantPermission(
        id: json["id"],
        key: json["key"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "key": key,
        "name": name,
      };
}
