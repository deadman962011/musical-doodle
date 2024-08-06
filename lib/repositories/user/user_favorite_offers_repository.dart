import 'dart:convert';
import 'package:com.mybill.app/models/responses/user/offer/user_offers_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:com.mybill.app/app_config.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';

class UserFavoriteOfferRepository {
  Future<dynamic> getUserFavoriteOffersResponse({int page = 1}) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/offer_favorite?=$page");

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

    // response.body
    if (response.statusCode == 200) {
      return userOffersResponseFromJson(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> toggleUserFavoriteOffersResponse(
      {required int offerId}) async {
    var postBody = jsonEncode({"offer_id": "$offerId"});

    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/offer_favorite");

    final response = await http.post(
      url,
      body: postBody,
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
        "Accept-Language": app_language.$,
        "Authorization": "Bearer ${access_token.$}",
      },
    );
    AppConfig.alice.onHttpResponse(response, body: postBody);
    debugPrint(response.body.toString());
    // response.body
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
