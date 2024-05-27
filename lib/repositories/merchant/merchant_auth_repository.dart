import 'dart:convert';
import 'package:com.mybill.app/models/responses/merchant/merchant_complete_register_response.dart';
import 'package:com.mybill.app/models/responses/merchant/merchant_login_response.dart';
import 'package:com.mybill.app/models/responses/merchant/merchant_validate_login_response.dart';
// import 'package:com.mybill.app/models/merchant/merchant_validate_login_response.dart';
import 'package:com.mybill.app/models/responses/merchant/merchant_validate_register_response.dart';
import 'package:com.mybill.app/models/responses/validation_response.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:com.mybill.app/app_config.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:flutter/material.dart';

class MerchantAuthRepository {
  Future<dynamic> getMerchantAuthenticateResponse(
      @required String email) async {
    var postBody = jsonEncode({"email": email});

    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/auth");
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
        },
        body: postBody);
    debugPrint(response.body.toString());
    AppConfig.alice.onHttpResponse(response, body: postBody);
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
    var postBody = jsonEncode({"token": token, "action": action});
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
        body: postBody);
    AppConfig.alice.onHttpResponse(response, body: postBody);
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
    @required String shopName,
    @required String shopAddress,
    @required String categoriesIds,
    @required String taxRegister,
    @required String shopAdminName,
    @required String shopAdminPhone,
    @required String shopAdminEmail,
    @required String longitude,
    @required String latitude,
    @required int zoneId,
    String referralCode,
  ) async {
    var postBody = jsonEncode({
      "shop_name": shopName,
      'shop_address': shopAddress,
      "categories_ids": categoriesIds,
      "tax_register": taxRegister,
      "shop_admin_name": shopAdminName,
      "shop_admin_phone": shopAdminPhone,
      "shop_admin_email": shopAdminEmail,
      "longitude": longitude,
      "latitude": latitude,
      "zone_id": zoneId,
      "referral_code": referralCode
    });
    debugPrint(postBody.toString());

    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/auth/register/complete");
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "latitude": user_latitude.$,
          "longitude": user_longitude.$
        },
        body: postBody);
    AppConfig.alice.onHttpResponse(response, body: postBody);
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
