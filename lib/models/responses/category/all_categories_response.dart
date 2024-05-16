// // To parse this JSON data, do
// //
// //     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

import 'package:com.mybill.app/models/items/Category.dart';
import 'package:flutter/foundation.dart';

AllCategoriesResponse allCategoriesResponseFromJson(String str) =>
    AllCategoriesResponse.fromJson(json.decode(str));

class AllCategoriesResponse {
  AllCategoriesResponse({required this.success, required this.categories});

  bool success;
  List<CategoryItem> categories;

  factory AllCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      AllCategoriesResponse(
          success: json["success"],
          categories: List<CategoryItem>.from(
              json['payload'].map((x) => CategoryItem.fromJson(x))));
}
