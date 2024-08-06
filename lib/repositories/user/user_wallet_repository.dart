import 'dart:convert';
import 'package:com.mybill.app/helpers/shared_value_helper.dart'; 
 import 'package:com.mybill.app/models/responses/user/wallet/user_wallet_informations_response.dart';
import 'package:com.mybill.app/models/responses/user/wallet/user_wallet_transactions_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:com.mybill.app/app_config.dart';

class UserWallettRepository {
  Future<dynamic> getUserWalletInforamtionsResponse() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/wallet/");

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
        "Accept-Language": app_language.$,
        "Authorization": "Bearer ${access_token.$}",
      },
    );

    AppConfig.alice.onHttpResponse(response, body: null);
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return userWalletInformationsResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getUserWalletHistoryResponse(@required int id) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/wallet/history");

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
        "Accept-Language": app_language.$,
        "Authorization": "Bearer ${access_token.$}",
      },
    );

    AppConfig.alice.onHttpResponse(response, body: null);
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return userWalletTransactionsResponseFromMap(response.body);
    } else {
      return false;
    }
  }
}
