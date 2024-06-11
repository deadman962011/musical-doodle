import 'dart:convert';

import 'package:com.mybill.app/app_config.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:com.mybill.app/models/responses/merchant/availability/merchant_availability_response.dart';
import 'package:com.mybill.app/models/responses/merchant/availability/merchant_availability_toggle_day_status_response.dart';
import 'package:com.mybill.app/models/responses/merchant/availability/merchant_availabiliy_add_slot_response.dart';
import 'package:com.mybill.app/models/responses/merchant/merchant_update_contact_response.dart';
import 'package:com.mybill.app/models/responses/merchant/merchant_response.dart';
import 'package:com.mybill.app/models/responses/merchant/merchant_update_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;

class MerchantRepository {
  Future<dynamic> getMerchantResponse() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/");

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
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return merchantResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getMerchantUpdateResponse(
      @required String shop_name_ar, @required String shop_name_en) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/");

    var postBody = jsonEncode(
        {"shop_name_ar": shop_name_ar, "shop_name_en": shop_name_en});

    final response = await http.put(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "Authorization": "Bearer ${access_token.$}",
        },
        body: postBody);
    AppConfig.alice.onHttpResponse(response, body: postBody);
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return merchantUpdateResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getMerchantUpdateContactResponse(@required String email,
      @required String phone, @required String website) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/contact");

    var postBody =
        jsonEncode({"email": email, "phone": phone, "website": website});

    final response = await http.put(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "Authorization": "Bearer ${access_token.$}",
        },
        body: postBody);
    AppConfig.alice.onHttpResponse(response, body: postBody);
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return merchantUpdateContactResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getMerchantAvailabilityResponse() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/availability/");

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
    debugPrint(response.body);
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return merchantAvailabilityResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getMerchantAvailabilityToggleDayResponse(
      @required int id) async {
    var postBody = jsonEncode({
      "shop_availability_id": id,
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/availability/");

    final response = await http.put(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "Authorization": "Bearer ${access_token.$}",
        },
        body: postBody);
    AppConfig.alice.onHttpResponse(response, body: postBody);
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return merchantAvailabilityToggleDayStatusResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getMerchantAvailabilityAddSlotResponse(
      @required int id) async {
    var postBody = jsonEncode({
      "shop_availability_id": id,
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/availability/slot");

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
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return merchantAvailabilityAddSlotResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getMerchantAvailabilityRemoveSlotResponse(
      @required int id) async {
    var postBody = jsonEncode({
      "id": id,
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/availability/slot");

    final response = await http.delete(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "Authorization": "Bearer ${access_token.$}",
        },
        body: postBody);
    AppConfig.alice.onHttpResponse(response, body: postBody);
    debugPrint(response.body);
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return merchantAvailabilityAddSlotResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getMerchantAvailabilityUpdateSlotResponse(
      @required int id, @required String start, @required String end) async {
    var postBody = jsonEncode({"id": id, "start": start, "end": end});

    Uri url = Uri.parse("${AppConfig.BASE_URL}/shop/availability/slot");

    final response = await http.put(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "Authorization": "Bearer ${access_token.$}",
        },
        body: postBody);
    AppConfig.alice.onHttpResponse(response, body: postBody);
    debugPrint(response.body);
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200 && responseBody['success'] == true) {
      return merchantAvailabilityAddSlotResponseFromMap(response.body);
    } else {
      return false;
    }
  }
}
