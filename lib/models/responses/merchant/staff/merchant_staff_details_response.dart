// To parse this JSON data, do
//
//     final merchantStaffDetailsResponse = merchantStaffDetailsResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MerchantStaffDetailsResponse merchantStaffDetailsResponseFromMap(String str) =>
    MerchantStaffDetailsResponse.fromMap(json.decode(str));

String merchantStaffDetailsResponseToMap(MerchantStaffDetailsResponse data) =>
    json.encode(data.toMap());

class MerchantStaffDetailsResponse {
  bool success;
  Payload payload;
  String message;

  MerchantStaffDetailsResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory MerchantStaffDetailsResponse.fromMap(Map<String, dynamic> json) =>
      MerchantStaffDetailsResponse(
        success: json["success"],
        payload: Payload.fromMap(json["payload"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "payload": payload.toMap(),
        "message": message,
      };
}

class Payload {
  String name;
  String phone;
  StaffRole role;

  Payload({
    required this.name,
    required this.phone,
    required this.role,
  });

  factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        name: json["name"],
        phone: json["phone"],
        role: StaffRole.fromMap(json["role"]),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "phone": phone,
        "role": role.toMap(),
      };
}

class StaffRole {
  int id;
  String name;

  StaffRole({
    required this.id,
    required this.name,
  });

  factory StaffRole.fromMap(Map<String, dynamic> json) => StaffRole(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
