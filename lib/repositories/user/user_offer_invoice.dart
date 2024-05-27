import 'dart:convert';
import 'package:com.mybill.app/models/responses/user/offer_invoice/user_offer_invoice_details_response.dart';
import 'package:com.mybill.app/models/responses/user/offer_invoice/user_offer_invoice_scan_response.dart';
import 'package:com.mybill.app/models/responses/user/offer_invoice/user_previous_invoice_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:com.mybill.app/app_config.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';

class UserOfferInvoiceRepository {
  Future<dynamic> getUserOfferInvoiceScanResponse(
      {required String payload}) async {
    var postBody = jsonEncode({"payload": payload});
    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/offer_invoice/scan");

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
    if (response.statusCode == 200) {
      return userOfferInvoiceScanResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getUserPreviousOffersInvoiceResponse({int page = 1}) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/user/offer_invoice/previous?page=$page");

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
        "Accept-Language": app_language.$,
        "Authorization": "Bearer ${access_token.$}",
      },
    );
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return userPreviousOfferInvoiceResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getUserOfferInvoiceDetailsResponse({required int id}) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/user/offer_invoice/${id}");

    final response = await http.get(url, headers: {
      'Accept': 'application/json',
      "Content-Type": "application/json",
      "Accept-Language": app_language.$,
      "Authorization": "Bearer ${access_token.$}",
    });

    AppConfig.alice.onHttpResponse(response, body: null);
    final responseBody = jsonDecode(response.body);
    debugPrint(responseBody.toString());
    if (response.statusCode == 200) {
      return UserOfferInvoiceDetailsResponseFromMap(response.body);
    } else {
      return false;
    }
  }
}
