// To parse this JSON data, do
//
//     final userSendWithdrawBalanceRequestResponse = userSendWithdrawBalanceRequestResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserSendWithdrawBalanceRequestResponse
    userSendWithdrawBalanceRequestResponseFromMap(String str) =>
        UserSendWithdrawBalanceRequestResponse.fromMap(json.decode(str));

String userSendWithdrawBalanceRequestResponseToMap(
        UserSendWithdrawBalanceRequestResponse data) =>
    json.encode(data.toMap());

class UserSendWithdrawBalanceRequestResponse {
  bool success;
  String message;

  UserSendWithdrawBalanceRequestResponse({
    required this.success,
    required this.message,
  });

  factory UserSendWithdrawBalanceRequestResponse.fromMap(
          Map<String, dynamic> json) =>
      UserSendWithdrawBalanceRequestResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "message": message,
      };
}
