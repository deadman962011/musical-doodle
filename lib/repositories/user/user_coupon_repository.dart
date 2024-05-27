import 'dart:convert';
import 'package:com.mybill.app/models/responses/user/coupon/user_coupons_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:com.mybill.app/app_config.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';

class UserCouponRepository {
  Future<dynamic> getUserCouponsResponse(
      {int page = 1, String category = ''}) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/coupon?page=${page}&category=${category}");

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
    debugPrint(responseBody.toString());
    if (response.statusCode == 200) {
      return userCouponsResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  // Future<dynamic> getUserPreviousOffersInvoiceResponse({int page = 1}) async {
  //   Uri url = Uri.parse(
  //       "${AppConfig.BASE_URL}/user/offer_invoice/previous?page=$page");

  //   final response = await http.get(
  //     url,
  //     headers: {
  //       'Accept': 'application/json',
  //       "Content-Type": "application/json",
  //       "Accept-Language": app_language.$,
  //       "Authorization": "Bearer ${access_token.$}",
  //     },
  //   );
  //   final responseBody = jsonDecode(response.body);
  //   if (response.statusCode == 200 && responseBody['success'] == true) {
  //     return userPreviousOfferInvoiceResponseFromMap(response.body);
  //   } else {
  //     return false;
  //   }
  // }

  // Future<dynamic> getUserOfferInvoiceDetailsResponse({required int id}) async {
  //   Uri url = Uri.parse("${AppConfig.BASE_URL}/user/offer_invoice/${id}");

  //   final response = await http.get(url, headers: {
  //     'Accept': 'application/json',
  //     "Content-Type": "application/json",
  //     "Accept-Language": app_language.$,
  //     "Authorization": "Bearer ${access_token.$}",
  //   });

  //   AppConfig.alice.onHttpResponse(response, body: null);
  //   final responseBody = jsonDecode(response.body);
  //   debugPrint(responseBody.toString());
  //   if (response.statusCode == 200) {
  //     return UserOfferInvoiceDetailsResponseFromMap(response.body);
  //   } else {
  //     return false;
  //   }
  // }
}
