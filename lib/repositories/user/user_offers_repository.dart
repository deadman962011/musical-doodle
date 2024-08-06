import 'dart:convert';
import 'package:com.mybill.app/models/responses/unexpected_error_response.dart';
import 'package:com.mybill.app/models/responses/user/offer/user_offer_cashback_recived.dart';
import 'package:com.mybill.app/models/responses/user/offer/user_offer_details_response.dart';
import 'package:com.mybill.app/models/responses/user/offer/user_offer_search_response.dart';
import 'package:com.mybill.app/models/responses/user/offer/user_offers_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:com.mybill.app/app_config.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';

class UserOfferRepository {
  Future<dynamic> getUserOffersResponse(
      {int page = 1, required int? category}) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/user/offer?page=$page&category=${category ?? ''}");

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
    debugPrint('$page,$category , ${response.body}');
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return userOffersResponseFromJson(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getUserOfferDetailsResponse({required int id}) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/offer/$id");

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
    AppConfig.alice.onHttpResponse(response, body: null);
    debugPrint(response.body);
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return userOfferDetailsResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getUserOfferCashbackRecivedResponse({required int id}) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/user/offer/$id/offer_cashback_recived");

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
        "Accept-Language": app_language.$,
        "Authorization": "Bearer ${access_token.$}",
      },
    );
    final responseBody = jsonDecode(response.body);
    AppConfig.alice.onHttpResponse(response, body: null);
    debugPrint(response.body);
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return userOfferCashbackRecivedFromJson(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getUserOfferSearchResponse(
      {required String name, required String filter}) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/offer/search");

    var postBody = jsonEncode({
      "name": name,
      "filter": filter,
    });

    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "Authorization": "Bearer ${access_token.$}",
          "latitude": user_latitude.$,
          "longitude": user_longitude.$
        },
        body: postBody);
    final responseBody = jsonDecode(response.body);
    AppConfig.alice.onHttpResponse(response, body: null);
    debugPrint(response.body);
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return userOfferSearchResponseFromMap(response.body);
    } else {
      return unexpectedErrorResponseFromJson(response.body);
    }
  }
}
