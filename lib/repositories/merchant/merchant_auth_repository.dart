import 'dart:convert';
import 'package:com.mybill.app/models/responses/merchant/merchant_complete_register_response.dart';
import 'package:com.mybill.app/models/responses/merchant/merchant_login_response.dart';
import 'package:com.mybill.app/models/responses/merchant/merchant_validate_login_response.dart';
// import 'package:com.mybill.app/models/merchant/merchant_validate_login_response.dart';
import 'package:com.mybill.app/models/responses/merchant/merchant_validate_register_response.dart';
import 'package:com.mybill.app/models/responses/merchant/validation/merchant_login_validatiom_response.dart';
import 'package:com.mybill.app/models/responses/validation_response.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:com.mybill.app/app_config.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:flutter/material.dart';

class MerchantAuthRepository {
  Future<dynamic> getMerchantAuthenticateResponse(
      @required String email) async {
    var post_body = jsonEncode({"email": "${email}"});

    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/auth");
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
        },
        body: post_body);
    debugPrint(response.body.toString());

    if (response.statusCode == 200) {
      return merchantloginResponseFromJson(response.body);
    } else if (response.statusCode == 422) {
      return validationResponseFromJson(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getMerchantValidateMagicLinkResponse(
      @required String token, @required String action) async {
    var post_body = jsonEncode({"token": token, "action": action});
    debugPrint(
        '${user_latitude.$}, ${user_longitude.$} -----------------------------------------an at auth repo');
    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/auth/validate");
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "latitude": user_latitude.$,
          "longitude": user_longitude.$
        },
        body: post_body);
    if (response.statusCode == 200) {
      debugPrint(response.body);
      if (action == 'verifyShopLogin') {
        return merchantValidateloginResponseFromJson(response.body);
      } else if (action == 'verifyShopRegister') {
        return merchantValidateRegisterResponseFromJson(response.body);
      }
    } else if (response.statusCode == 422) {
      return validationResponseFromJson(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getMerchantCompleteRegisterResponse(
    @required String shop_name,
    @required String shop_address,
    @required String categories_ids,
    @required String tax_register,
    @required String shop_admin_name,
    @required String shop_admin_phone,
    @required String shop_admin_email,
    @required String longitude,
    @required String latitude,
    @required int zoneId,
    String referral_code,
  ) async {
    var post_body = jsonEncode({
      "shop_name": shop_name,
      'shop_address': shop_address,
      "categories_ids": categories_ids,
      "tax_register": tax_register,
      "shop_admin_name": shop_admin_name,
      "shop_admin_phone": shop_admin_phone,
      "shop_admin_email": shop_admin_email,
      "longitude": longitude,
      "latitude": latitude,
      "zone_id": zoneId,
      "referral_code": referral_code
    });
    debugPrint(post_body.toString());

    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/auth/register/complete");
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "latitude": user_latitude.$,
          "longitude": user_longitude.$
        },
        body: post_body);

    debugPrint(response.body);
    if (response.statusCode == 201) {
      return merchantCompleteRegisterResponseFromJson(response.body);
    } else if (response.statusCode == 422) {
      return validationResponseFromJson(response.body);
    } else {
      return false;
    }
  }
}
