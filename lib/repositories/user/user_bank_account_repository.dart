import 'dart:convert';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/models/responses/user/bank_account/user_bank_account_details_response.dart';
import 'package:com.mybill.app/models/responses/user/bank_account/user_bank_accounts_response.dart';
import 'package:com.mybill.app/models/responses/user/bank_account/user_create_bank_account_response.dart';
import 'package:com.mybill.app/models/responses/validation_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:com.mybill.app/app_config.dart';

class UserBankAccountRepository {
  Future<dynamic> getUserBankAccountsResponse() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/bank_account");

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
    if (response.statusCode == 200) {
      return userBankAccountsResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getUserBankAccountDetailsResponse(@required int id) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/bank_account/${id}");

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
      return userBankAccountDetailsResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getUsercreateBankAccountResponse(
    @required String bankName,
    @required String fullName,
    @required String accountNumver,
    @required String iban,
  ) async {
    var postBody = jsonEncode({
      "bank_name": bankName,
      "full_name": fullName,
      "account_number": accountNumver,
      "iban": iban,
    });
    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/bank_account");

    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "Authorization": "Bearer ${access_token.$}",
        },
        body: postBody);

    AppConfig.alice.onHttpResponse(response, body: postBody);
    final responseBody = jsonDecode(response.body);
    debugPrint(responseBody.toString());
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return userCreateBankAccountsResponseFromMap(response.body);
    } else if (response.statusCode == 422) {
      return validationResponseFromJson(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getUserupdateBankAccountResponse(
    @required int id,
    @required String bankName,
    @required String fullName,
    @required String accountNumver,
    @required String iban,
  ) async {
    var postBody = jsonEncode({
      "bank_name": bankName,
      "full_name": fullName,
      "account_number": accountNumver,
      "iban": iban,
    });
    Uri url =
        Uri.parse("${AppConfig.BASE_URL}/user/bank_account/${id.toString()}");

    final response = await http.put(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "Authorization": "Bearer ${access_token.$}",
        },
        body: postBody);

    AppConfig.alice.onHttpResponse(response, body: postBody);
    final responseBody = jsonDecode(response.body);
    debugPrint(responseBody.toString());
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return userCreateBankAccountsResponseFromMap(response.body);
    } else if (response.statusCode == 422) {
      return validationResponseFromJson(response.body);
    } else {
      return false;
    }
  }
}
