import 'dart:convert';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/models/responses/merchant/role/merchant_all_roles_response.dart';
import 'package:com.mybill.app/models/responses/merchant/role/merchant_permissions_response.dart';
import 'package:com.mybill.app/models/responses/merchant/role/merchant_role_response.dart';
import 'package:com.mybill.app/models/responses/merchant/role/merchant_save_role_response.dart';
import 'package:com.mybill.app/models/responses/user/bank_account/user_bank_account_details_response.dart';
import 'package:com.mybill.app/models/responses/user/bank_account/user_bank_accounts_response.dart';
import 'package:com.mybill.app/models/responses/user/bank_account/user_create_bank_account_response.dart';
import 'package:com.mybill.app/models/responses/validation_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:com.mybill.app/app_config.dart';

class MerchantRoleRepository {
  Future<dynamic> getAllMerchantRolesResponse() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/role/all");

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
      return merchantAllRolesResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getMerchantRolesResponse({int page = 1}) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/role?page=${page}");

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
      return merchantRoleResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getMerchantRolesPermissionsResponse({int page = 1}) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/role/permissions");

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
      return merchantPermissionsResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getSaveMerchantRoleResponse(
    @required String name,
    @required String nameEn,
    @required String permissions,
  ) async {
    var postBody = jsonEncode({
      "name_ar": name,
      "name_en": nameEn,
      "permissions": permissions,
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/role");
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
      return merchantSaveRoleResponseFromMap(response.body);
    } else if (response.statusCode == 422) {
      return validationResponseFromJson(response.body);
    } else {
      return false;
    }
  }
}
