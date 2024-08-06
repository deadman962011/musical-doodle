import 'dart:convert';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/models/responses/merchant/role/merchant_save_role_response.dart';
import 'package:com.mybill.app/models/responses/merchant/role/merchant_update_role_response.dart';
import 'package:com.mybill.app/models/responses/merchant/subscription/merchant_save_subscription_pay_bank_request_response.dart';
import 'package:com.mybill.app/models/responses/merchant/subscription/merchant_subscription_plans_response.dart';
import 'package:com.mybill.app/models/responses/unexpected_error_response.dart';
import 'package:com.mybill.app/models/responses/validation_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:com.mybill.app/app_config.dart';

class MerchantSubscriptionRepository {
  Future<dynamic> getAllMerchantSubscriptionPlansResponse() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/shop_subscription/");

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
      return merchantSubscriptionPlansResponseFromJson(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getSaveMerchantSubscriptionRequestResponse(
    @required String senderFullName,
    @required String senderPhoneNumber,
    @required String senderBankName,
    @required String senderBankAccountNumber,
    @required String senderBankIban,
    @required String planId,
    
  ) async {
    var postBody = jsonEncode({
      "sender_full_name": senderFullName,
      "sender_phone_number": senderPhoneNumber,
      "sender_bank_name": senderBankName,
      "sender_bank_account_number": senderBankAccountNumber,
      "sender_bank_iban": senderBankIban,
      "plan_id": planId,
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/shop_subscription/");
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "Authorization": "Bearer ${access_token.$}",
        },
        body: postBody);
    AppConfig.alice.onHttpResponse(response, body: postBody);
    debugPrint(response.body);
    if (response.statusCode == 201) {
      return merchantSavePaySubscriptionBankRequestResponseFromJson(
          response.body);
    } else if (response.statusCode == 422) {
      return validationResponseFromJson(response.body);
    } else {
      return unexpectedErrorResponseFromJson(response.body);
    }
  }

  Future<dynamic> getUpdateMerchantRoleResponse(
    @required String id,
    @required String name,
    @required String nameEn,
    @required String permissions,
  ) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/role/${id}");
    var postBody = jsonEncode({
      "role_name_in_ar": name,
      "role_name_in_en": nameEn,
      "permissions": permissions,
    });

    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "Authorization": "Bearer ${access_token.$}",
        },
        body: postBody);
    AppConfig.alice.onHttpResponse(response, body: postBody);
    debugPrint(response.body);
    if (response.statusCode == 200) {
      return merchantUpdateRoleResponseFromMap(response.body);
    } else if (response.statusCode == 422) {
      return validationResponseFromJson(response.body);
    } else {
      return unexpectedErrorResponseFromJson(response.body);
    }
  }
}
