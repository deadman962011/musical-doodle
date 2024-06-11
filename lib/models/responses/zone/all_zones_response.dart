// To parse this JSON data, do
//
//     final allZonesResponse = allZonesResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AllZonesResponse allZonesResponseFromMap(String str) =>
    AllZonesResponse.fromMap(json.decode(str));

String allZonesResponseToMap(AllZonesResponse data) =>
    json.encode(data.toMap());

class AllZonesResponse {
  bool success;
  List<ZoneItem> payload;
  String message;

  AllZonesResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory AllZonesResponse.fromMap(Map<String, dynamic> json) =>
      AllZonesResponse(
        success: json["success"],
        payload: List<ZoneItem>.from(
            json["payload"].map((x) => ZoneItem.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "payload": List<dynamic>.from(payload.map((x) => x.toMap())),
        "message": message,
      };
}

class ZoneItem {
  int id;
  String name;
  Center center;

  ZoneItem({
    required this.id,
    required this.name,
    required this.center,
  });

  factory ZoneItem.fromMap(Map<String, dynamic> json) => ZoneItem(
        id: json["id"],
        name: json["name"],
        center: Center.fromMap(json["center"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "center": center.toMap(),
      };
}

class Center {
  double latitude;
  double longitude;

  Center({
    required this.latitude,
    required this.longitude,
  });

  factory Center.fromMap(Map<String, dynamic> json) => Center(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
