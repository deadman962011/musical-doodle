import 'dart:convert';

import 'package:csh_app/models/responses/merchant/offer/merchant_offers_response.dart';
import 'package:csh_app/models/responses/merchant/offer/merchant_save_offer_response.dart';
import 'package:csh_app/models/responses/validation_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:csh_app/app_config.dart';
import 'package:csh_app/helpers/shared_value_helper.dart';

class MerchantOfferRepository {
  Future<dynamic> getMerchantOffersResponse({int page = 1}) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/offer");

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
        "Accept-Language": app_language.$,
        "Authorization": "Bearer ${access_token.$}",
      },
    );
    debugPrint(response.body.toString());
    // response.body
    if (response.statusCode == 200) {
      return merchantOffersResponseFromJson(response.body);
    } else {
      return false;
    }

//     if (response.statusCode == 200) {
//       return merchantloginResponseFromJson(response.body);
//     } else if (response.statusCode == 422) {
//       return validationResponseFromJson(response.body);
//     } else {
//       return false;
//     }
  }

  Future<dynamic> saveMerchantOfferResponse(
      @required String name,
      @required String start_date,
      @required String end_date,
      @required String cashback_amount) async {
    var post_body = jsonEncode({
      "name": name,
      "start_date": start_date,
      "end_date": end_date,
      "cashback_amount": cashback_amount,
      'offer_thumbnail': '1'
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/offer/");
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "Authorization": "Bearer ${access_token.$}",
        },
        body: post_body);
    debugPrint(response.body);
    debugPrint(cashback_amount);
    if (response.statusCode == 201) {
      return merchantSaveOfferResponseFromJson(response.body);
    } else if (response.statusCode == 422) {
      return validationResponseFromJson(response.body);
    } else {
      return false;
    }
  }
}
