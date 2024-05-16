import 'package:com.mybill.app/models/responses/category/all_categories_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:com.mybill.app/app_config.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';

class CategoryRepository {
  Future<dynamic> getAllCategoriesResponse() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/category");
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
        "Accept-Language": app_language.$,
      },
    );
    if (response.statusCode == 200) {
      return allCategoriesResponseFromJson(response.body);
    } else {
      return false;
    }
  }
}
