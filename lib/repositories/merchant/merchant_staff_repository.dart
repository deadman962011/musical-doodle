import 'dart:convert';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/models/responses/merchant/staff/merchant_save_staff_response.dart';
import 'package:com.mybill.app/models/responses/merchant/staff/merchant_staff_response.dart';
import 'package:com.mybill.app/models/responses/validation_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:com.mybill.app/app_config.dart';

class MerchantStaffRepository {
  Future<dynamic> getMerchantStaffsResponse({int page = 1}) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/staff?page=${page}");

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
      return merchantStaffResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getSaveMerchantStaffResponse(
    @required String name,
    @required String email,
    @required String phone,
    @required String roleId,
  ) async {
    var postBody = jsonEncode({
      "name": name,
      "email": email,
      "phone": phone,
      "role_id": roleId,
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/staff");
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
      return merchantSaveStaffResponseFromMap(response.body);
    } else if (response.statusCode == 422) {
      return validationResponseFromJson(response.body);
    } else {
      return false;
    }
  }
}
