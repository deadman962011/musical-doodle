import 'dart:convert';

import 'package:com.mybill.app/models/responses/merchant/offer/merchant_cancel_offer_invoice_response.dart';
import 'package:com.mybill.app/models/responses/merchant/offer/merchant_offer_details_response.dart';
import 'package:com.mybill.app/models/responses/merchant/offer/merchant_offers_response.dart';
import 'package:com.mybill.app/models/responses/merchant/offer/merchant_save_offer_response.dart';
import 'package:com.mybill.app/models/responses/merchant/offer/merchant_save_pay_offer_commission_request_response.dart';
import 'package:com.mybill.app/models/responses/unexpected_error_response.dart';
import 'package:com.mybill.app/models/responses/validation_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:com.mybill.app/app_config.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';

class MerchantOfferRepository {
  Future<dynamic> getMerchantOffersResponse({int page = 1}) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/offer?page=${page}");

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
    AppConfig.alice.onHttpResponse(response, body: null);
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
      @required String nameEn,
      @required String startDate,
      @required String endDate,
      @required String cashbackAmount,
      @required int thumbnailId) async {
    var postBody = jsonEncode({
      "name_ar": name,
      "name_en": nameEn,
      "start_date": startDate,
      "end_date": endDate,
      "cashback_amount": cashbackAmount,
      'offer_thumbnail': thumbnailId
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/offer");
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
    debugPrint(cashbackAmount);
    if (response.statusCode == 201) {
      return merchantSaveOfferResponseFromJson(response.body);
    } else if (response.statusCode == 422) {
      return validationResponseFromJson(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getMerchantOfferDetailsResponse(@required int id) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/offer/${id}");

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
    AppConfig.alice.onHttpResponse(response, body: null);
    // response.body
    if (response.statusCode == 200 && responseBody['success']) {
      return merchantOfferDetailsResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getMerchantOfferPayCommissionResponse(
      @required int offer_id,
      @required String amount,
      @required String sender_name,
      @required String sender_phone,
      @required String deposit_at,
      @required String deposit_bank_account_id,
      @required String attachments,
      @required String notice) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/shop_pay_commission");

    var postBody = jsonEncode({
      "amount": amount,
      "offer_id": offer_id,
      "full_name": sender_name,
      "phone": sender_phone,
      "deposit_at": deposit_at,
      "deposit_bank_account_id": deposit_bank_account_id,
      "attachments": attachments,
      "notice": notice
    });

    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "Authorization": "Bearer ${access_token.$}",
        },
        body: postBody);
    final responseBody = jsonDecode(response.body);
    AppConfig.alice.onHttpResponse(response, body: null);
    // response.body
    // debugPrint(response)
    if (response.statusCode == 200 && responseBody['success']) {
      return merchantSavePayOfferCommissionRequestResponseFromJson(
          response.body);
    } else if (response.statusCode == 422) {
      return validationResponseFromJson(response.body);
    } else {
      return unexpectedErrorResponseFromJson(response.body);
    }
  }

  Future<dynamic> getMerchantCancelOfferInvoice(@required int id,
      @required int invoice_id, @required String cancel_reason) async {
    debugPrint("${id.toString()} ${invoice_id.toString()} ${cancel_reason}");

    Uri url =
        Uri.parse("${AppConfig.BASE_URL}/shop/offer/${id}/cancel_invoice");

    var postBody = jsonEncode({
      "invoice_id": invoice_id,
      "reason": cancel_reason,
    });

    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "Authorization": "Bearer ${access_token.$}",
        },
        body: postBody);
    final responseBody = jsonDecode(response.body);
    AppConfig.alice.onHttpResponse(response, body: null);
    debugPrint(responseBody.toString());
    if (response.statusCode == 200 && responseBody['success']) {
      return merchantCancelOfferInvoiceResponseFromMap(response.body);
    } else {
      return unexpectedErrorResponseFromJson(response.body);
    }
  }
}
