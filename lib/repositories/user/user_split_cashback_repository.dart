import 'dart:convert';

import 'package:com.mybill.app/app_config.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/models/responses/user/split_cashback/user_split_cashback_registered_contacts_response.dart';
import 'package:com.mybill.app/models/responses/user/split_cashback/user_split_cashback_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserSplitCashbackRepository {
  Future<dynamic> getUserSplitCashbackResponse(@required int offer_id,
      @required List user_ids, @required List amount_ids) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/split_cashback/");

    var postBody = jsonEncode({
      "offer_id": offer_id,
      "user_ids": user_ids,
      "cashback_amounts": amount_ids
    });

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
        "Accept-Language": app_language.$,
        "Authorization": "Bearer ${access_token.$}",
      },
      body: postBody,
    );

    AppConfig.alice.onHttpResponse(response, body: null);
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return userSplitCashbackResponseFromMap(response.body);
      // return userWalletInformationsResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getUserSplitCashbackRegisteredContactsResponse(
      @required List phoneNumbers) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/user/split_cashback/get_registered_contacts");

    var postBody = jsonEncode({
      "phone_numbers": phoneNumbers,
    });

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
        "Accept-Language": app_language.$,
        "Authorization": "Bearer ${access_token.$}",
      },
      body: postBody,
    );

    AppConfig.alice.onHttpResponse(response, body: null);
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return userSplitCashbackRegisteredContactsResponseFromJson(response.body);
      // return userWalletInformationsResponseFromMap(response.body);
    } else {
      return false;
    }
  }
}
