import 'dart:convert';
import 'package:csh_app/models/responses/user/offer/user_offers_response.dart';
import 'package:csh_app/models/responses/validation_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:csh_app/app_config.dart';
import 'package:csh_app/helpers/shared_value_helper.dart';

class UserOfferRepository {
  Future<dynamic> getUserOffersResponse(
      {int page = 1, required int? category}) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/user/offer?page=${page}&category=${category ?? ''}");

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
        "Accept-Language": app_language.$,
        "Authorization": "Bearer ${access_token.$}",
        "latitude": user_latitude.$,
        "longitude": user_longitude.$
      },
    );
    final responseBody = jsonDecode(response.body);
    debugPrint('${page},${category} , ${response.body}');
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return userOffersResponseFromJson(response.body);
    } else {
      return false;
    }
  }
}
