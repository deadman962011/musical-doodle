import 'dart:convert';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/models/responses/user/bank_account/user_bank_account_details_response.dart';
import 'package:com.mybill.app/models/responses/user/bank_account/user_bank_accounts_response.dart';
import 'package:com.mybill.app/models/responses/user/bank_account/user_create_bank_account_response.dart';
import 'package:com.mybill.app/models/responses/user/withdraw_balance/user_send_withdraw_balance_request_response.dart';
import 'package:com.mybill.app/models/responses/user/withdraw_balance/user_withdraw_balance_history.dart';
import 'package:com.mybill.app/models/responses/validation_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:com.mybill.app/app_config.dart';
import 'package:one_context/one_context.dart';

class UserWithdrawBalanceRepository {
  Future<dynamic> getUserCreateWithdrawBalanceResponse(
    @required int amount,
    @required int bankAccountId,
  ) async {
    var postBody = jsonEncode({
      "amount": amount,
      "bank_account_id": bankAccountId,
    });
    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/withdraw_balance");

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
      return userSendWithdrawBalanceRequestResponseFromMap(response.body);
    } else if (response.statusCode == 422) {
      return validationResponseFromJson(response.body);
    } else {
      if (OneContext.hasContext) {
        OneContext().showSnackBar(
            builder: (_) => SnackBar(content: Text(responseBody['message'])));
      }
      return false;
    }
  }

  Future<dynamic> getUserWithdrawBalanceHistoryResponse(int page) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/user/withdraw_balance/withdraw_balance_history?page=${page}");

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
        "Accept-Language": app_language.$,
        "Authorization": "Bearer ${access_token.$}",
      },
    );

    AppConfig.alice.onHttpResponse(
      response,
    );
    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200 && responseBody['success'] == true) {
      return userWithdrawBalanceHistoryResponseFromMap(response.body);
    } else {
      if (OneContext.hasContext) {
        OneContext().showSnackBar(
            builder: (_) => SnackBar(content: Text(responseBody['message'])));
      }
      return false;
    }
  }
}
