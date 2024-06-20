// To parse this JSON data, do
//
//     final userWalletInformationsResponse = userWalletInformationsResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserWalletInformationsResponse userWalletInformationsResponseFromMap(
        String str) =>
    UserWalletInformationsResponse.fromMap(json.decode(str));

String userWalletInformationsResponseToMap(
        UserWalletInformationsResponse data) =>
    json.encode(data.toMap());

class UserWalletInformationsResponse {
  bool success;
  UserWalletInformations payload;
  String message;

  UserWalletInformationsResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory UserWalletInformationsResponse.fromMap(Map<String, dynamic> json) =>
      UserWalletInformationsResponse(
        success: json["success"],
        payload: UserWalletInformations.fromMap(json["payload"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "payload": payload.toMap(),
        "message": message,
      };
}

class UserWalletInformations {
  int pendingBalance;
  int availableBalance;
  int totalBalance;

  UserWalletInformations({
    required this.pendingBalance,
    required this.availableBalance,
    required this.totalBalance,
  });

  factory UserWalletInformations.fromMap(Map<String, dynamic> json) =>
      UserWalletInformations(
        pendingBalance: json["pending_balance"],
        availableBalance: json["available_balance"],
        totalBalance: json["total_balance"],
      );

  Map<String, dynamic> toMap() => {
        "pending_balance": pendingBalance,
        "available_balance": availableBalance,
        "total_balance": totalBalance,
      };
}
