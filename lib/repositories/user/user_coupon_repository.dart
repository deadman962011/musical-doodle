import 'dart:convert';
import 'package:com.mybill.app/custom/toast_component.dart';
import 'package:com.mybill.app/models/responses/user/coupon/user_coupon_details_response.dart';
import 'package:com.mybill.app/models/responses/user/coupon/user_coupon_redeem_history.dart';
import 'package:com.mybill.app/models/responses/user/coupon/user_coupon_redeem_response.dart';
import 'package:com.mybill.app/models/responses/user/coupon/user_coupons_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:com.mybill.app/app_config.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';
import 'package:one_context/one_context.dart';
import 'package:toast/toast.dart';

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

  Future<dynamic> getUserCouponDetailsResponse(@required int id) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/coupon/${id}");

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
    if (response.statusCode == 200) {
      return userCouponDetailsResponseFromMap(response.body);
    } else {
      return false;
    }
  }

  Future<dynamic> getUserRdeemCouponResponse(@required int id,
      @required int variation_id, @required int quantity) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/coupon/${id}/redeem");

    var postBody =
        jsonEncode({"coupon_variation_id": variation_id, 'quantity': quantity});
    final response = await http.post(url,
        headers: {
          'Accept': 'application/json',
          "Content-Type": "application/json",
          "Accept-Language": app_language.$,
          "Authorization": "Bearer ${access_token.$}",
        },
        body: postBody);

    AppConfig.alice.onHttpResponse(response, body: null);
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200 && responseBody['success']) {
      return UserCouponRedeemResponseFromMap(response.body);
    } else {
      OneContext().showSnackBar(
          builder: (_) => SnackBar(content: Text(responseBody['message'])));
      // ToastComponent.showDialog(responseBody['message'], OneContext().context!,
      //     gravity: Toast.bottom, duration: Toast.lengthLong);
      return false;
    }
  }

  Future<dynamic> getUserCouponRedeemHistoyResponse(@required int page) async {
    Uri url =
        Uri.parse("${AppConfig.BASE_URL}/coupon/redeem_history?page=${page}");

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
    if (response.statusCode == 200 && responseBody['success']) {
      return userCouponRedeemHistoryResponseFromMap(response.body);
    } else {
      return false;
    }
  }
}
