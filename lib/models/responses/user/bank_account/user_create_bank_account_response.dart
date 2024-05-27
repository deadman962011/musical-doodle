// To parse this JSON data, do
//
//     final userCreateBankAccountsResponse = userCreateBankAccountsResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserCreateBankAccountsResponse userCreateBankAccountsResponseFromMap(
        String str) =>
    UserCreateBankAccountsResponse.fromMap(json.decode(str));

String userCreateBankAccountsResponseToMap(
        UserCreateBankAccountsResponse data) =>
    json.encode(data.toMap());

class UserCreateBankAccountsResponse {
  bool success;
  dynamic payload;
  String message;

  UserCreateBankAccountsResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory UserCreateBankAccountsResponse.fromMap(Map<String, dynamic> json) =>
      UserCreateBankAccountsResponse(
        success: json["success"],
        payload: json["payload"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "payload": payload,
        "message": message,
      };
}
