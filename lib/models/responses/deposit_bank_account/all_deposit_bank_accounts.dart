// To parse this JSON data, do
//
//     final allDepoistBankAccountsResponse = allDepoistBankAccountsResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AllDepoistBankAccountsResponse allDepoistBankAccountsResponseFromMap(
        String str) =>
    AllDepoistBankAccountsResponse.fromMap(json.decode(str));

String allDepoistBankAccountsResponseToMap(
        AllDepoistBankAccountsResponse data) =>
    json.encode(data.toMap());

class AllDepoistBankAccountsResponse {
  bool success;
  List<DepositBankAccount> payload;

  AllDepoistBankAccountsResponse({
    required this.success,
    required this.payload,
  });

  factory AllDepoistBankAccountsResponse.fromMap(Map<String, dynamic> json) =>
      AllDepoistBankAccountsResponse(
        success: json["success"],
        payload: List<DepositBankAccount>.from(
            json["payload"].map((x) => DepositBankAccount.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "payload": List<DepositBankAccount>.from(payload.map((x) => x.toMap())),
      };
}

class DepositBankAccount {
  int id;
  String bankName;
  String fullName;
  String iban;
  String accountNumber;

  DepositBankAccount({
    required this.id,
    required this.bankName,
    required this.fullName,
    required this.iban,
    required this.accountNumber,
  });

  factory DepositBankAccount.fromMap(Map<String, dynamic> json) =>
      DepositBankAccount(
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
