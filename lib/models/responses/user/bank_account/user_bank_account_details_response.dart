// To parse this JSON data, do
//
//     final userBankAccountDetailsResponse = userBankAccountDetailsResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserBankAccountDetailsResponse userBankAccountDetailsResponseFromMap(
        String str) =>
    UserBankAccountDetailsResponse.fromMap(json.decode(str));

String userBankAccountDetailsResponseToMap(
        UserBankAccountDetailsResponse data) =>
    json.encode(data.toMap());

class UserBankAccountDetailsResponse {
  bool success;
  BankAccount payload;
  String message;

  UserBankAccountDetailsResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory UserBankAccountDetailsResponse.fromMap(Map<String, dynamic> json) =>
      UserBankAccountDetailsResponse(
        success: json["success"],
        payload: BankAccount.fromMap(json["payload"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "payload": payload.toMap(),
        "message": message,
      };
}

class BankAccount {
  int id;
  String bankName;
  String fullName;
  String iban;
  String accountNumber;

  BankAccount({
    required this.id,
    required this.bankName,
    required this.fullName,
    required this.iban,
    required this.accountNumber,
  });

  factory BankAccount.fromMap(Map<String, dynamic> json) => BankAccount(
        id: json["id"],
        bankName: json["bank_name"],
        fullName: json["full_name"],
        iban: json["iban"],
        accountNumber: json["account_number"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "bank_name": bankName,
        "full_name": fullName,
        "iban": iban,
        "account_number": accountNumber,
      };
}
