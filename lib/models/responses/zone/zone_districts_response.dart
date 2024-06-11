// To parse this JSON data, do
//
//     final zoneDistrictsResponse = zoneDistrictsResponseFromMap(jsonString);

import 'dart:convert';

ZoneDistrictsResponse zoneDistrictsResponseFromMap(String str) =>
    ZoneDistrictsResponse.fromMap(json.decode(str));

String zoneDistrictsResponseToMap(ZoneDistrictsResponse data) =>
    json.encode(data.toMap());

class ZoneDistrictsResponse {
  bool success;
  List<Payload> payload;

  ZoneDistrictsResponse({
    required this.success,
    required this.payload,
  });

  factory ZoneDistrictsResponse.fromMap(Map<String, dynamic> json) =>
      ZoneDistrictsResponse(
        success: json["success"],
        payload:
            List<Payload>.from(json["payload"].map((x) => Payload.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "payload": List<dynamic>.from(payload.map((x) => x.toMap())),
      };
}

class Payload {
  int id;
  String name;

  Payload({
    required this.id,
    required this.name,
  });

  factory Payload.fromMap(Map<String, dynamic> json) => Payload(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
