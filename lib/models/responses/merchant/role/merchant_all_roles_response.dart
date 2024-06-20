// To parse this JSON data, do
//
//     final merchantAllRolesResponse = merchantAllRolesResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MerchantAllRolesResponse merchantAllRolesResponseFromMap(String str) => MerchantAllRolesResponse.fromMap(json.decode(str));

String merchantAllRolesResponseToMap(MerchantAllRolesResponse data) => json.encode(data.toMap());

class MerchantAllRolesResponse {
    bool success;
    List<Payload> payload;
    String message;

    MerchantAllRolesResponse({
        required this.success,
        required this.payload,
        required this.message,
    });

    factory MerchantAllRolesResponse.fromMap(Map<String, dynamic> json) => MerchantAllRolesResponse(
        success: json["success"],
        payload: List<Payload>.from(json["payload"].map((x) => Payload.fromMap(x))),
        message: json["message"],
    );

    Map<String, dynamic> toMap() => {
        "success": success,
        "payload": List<dynamic>.from(payload.map((x) => x.toMap())),
        "message": message,
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
