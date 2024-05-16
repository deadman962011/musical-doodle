// To parse this JSON data, do
//
//     final merchantAvailabilityResponse = merchantAvailabilityResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MerchantAvailabilityResponse merchantAvailabilityResponseFromMap(String str) =>
    MerchantAvailabilityResponse.fromMap(json.decode(str));

String merchantAvailabilityResponseToMap(MerchantAvailabilityResponse data) =>
    json.encode(data.toMap());

class MerchantAvailabilityResponse {
  bool success;
  List<AvailabilityDay> payload;
  String message;

  MerchantAvailabilityResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory MerchantAvailabilityResponse.fromMap(Map<String, dynamic> json) =>
      MerchantAvailabilityResponse(
        success: json["success"],
        payload: List<AvailabilityDay>.from(
            json["payload"].map((x) => AvailabilityDay.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "payload": List<dynamic>.from(payload.map((x) => x.toMap())),
        "message": message,
      };
}

class AvailabilityDay {
  int id;
  String day;
  int status;
  int shopId;
  DateTime createdAt;
  DateTime updatedAt;
  List<AvailabilitySlot> slots;

  AvailabilityDay({
    required this.id,
    required this.day,
    required this.status,
    required this.shopId,
    required this.createdAt,
    required this.updatedAt,
    required this.slots,
  });

  factory AvailabilityDay.fromMap(Map<String, dynamic> json) => AvailabilityDay(
        id: json["id"],
        day: json["day"],
        status: json["status"],
        shopId: json["shop_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        slots: List<AvailabilitySlot>.from(
            json["slots"].map((x) => AvailabilitySlot.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "day": day,
        "status": status,
        "shop_id": shopId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "slots": List<dynamic>.from(slots.map((x) => x.toMap())),
      };
}

class AvailabilitySlot {
  int id;
  dynamic start;
  dynamic end;
  int shopAvailabilityId;
  DateTime createdAt;
  DateTime updatedAt;

  AvailabilitySlot({
    required this.id,
    required this.start,
    required this.end,
    required this.shopAvailabilityId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AvailabilitySlot.fromMap(Map<String, dynamic> json) =>
      AvailabilitySlot(
        id: json["id"],
        start: json["start"],
        end: json["end"],
        shopAvailabilityId: json["shop_availability_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "start": start,
        "end": end,
        "shop_availability_id": shopAvailabilityId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
