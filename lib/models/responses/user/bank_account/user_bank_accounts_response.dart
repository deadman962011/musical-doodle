// To parse this JSON data, do
//
//     final userBankAccountsResponse = userBankAccountsResponseFromMap(jsonString);

import 'dart:convert';

UserBankAccountsResponse userBankAccountsResponseFromMap(String str) =>
    UserBankAccountsResponse.fromMap(json.decode(str));

String userBankAccountsResponseToMap(UserBankAccountsResponse data) =>
    json.encode(data.toMap());

class UserBankAccountsResponse {
  bool success;
  List<BankAccountMini> payload;
  String message;

  UserBankAccountsResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory UserBankAccountsResponse.fromMap(Map<String, dynamic> json) =>
      UserBankAccountsResponse(
        success: json["success"],
        payload: List<BankAccountMini>.from(
            json["payload"].map((x) => BankAccountMini.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "payload": List<dynamic>.from(payload.map((x) => x.toMap())),
        "message": message,
      };
}

class BankAccountMini {
  int id;
  String bankName;

  BankAccountMini({
    required this.id,
    required this.bankName,
  });

  factory BankAccountMini.fromMap(Map<String, dynamic> json) => BankAccountMini(
        id: json["id"],
        bankName: json["bank_name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "bank_name": bankName,
      };
}
