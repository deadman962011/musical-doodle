// // To parse this JSON data, do
// //
// //     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

import 'package:com.mybill.app/models/items/Category.dart';
import 'package:com.mybill.app/models/items/Zone.dart';
import 'package:flutter/foundation.dart';

AllZonesResponse allZonesResponseFromJson(String str) =>
    AllZonesResponse.fromJson(json.decode(str));

class AllZonesResponse {
  AllZonesResponse({required this.success, required this.zones});

  bool success;
  List<ZoneItem> zones;

  factory AllZonesResponse.fromJson(Map<String, dynamic> json) =>
      AllZonesResponse(
          success: json["success"],
          zones: List<ZoneItem>.from(
              json['payload'].map((x) => ZoneItem.fromJson(x))));
}
