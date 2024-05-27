// To parse this JSON data, do
//
//     final UserOfferInvoiceDetailsResponse = UserOfferInvoiceDetailsResponseFromMap(jsonString);

import 'dart:convert';

import 'package:com.mybill.app/models/responses/user/offer_invoice/user_previous_invoice_response.dart';

UserOfferInvoiceDetailsResponse UserOfferInvoiceDetailsResponseFromMap(
        String str) =>
    UserOfferInvoiceDetailsResponse.fromMap(json.decode(str));

String UserOfferInvoiceDetailsResponseToMap(
        UserOfferInvoiceDetailsResponse data) =>
    json.encode(data.toMap());

class UserOfferInvoiceDetailsResponse {
  bool success;
  OfferInvoiceDetails payload;
  String message;

  UserOfferInvoiceDetailsResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory UserOfferInvoiceDetailsResponse.fromMap(Map<String, dynamic> json) =>
      UserOfferInvoiceDetailsResponse(
        success: json["success"],
        payload: OfferInvoiceDetails.fromMap(json["payload"]),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "success": success,
        "payload": payload,
        "message": message,
      };
}

class OfferInvoiceDetails {
  int id;
  String amount;
  String vat;
  String created_at;
  String state;
  OfferInvoiceDetailsShop shop;

  OfferInvoiceDetails(
      {required this.id,
      required this.amount,
      required this.vat,
      required this.created_at,
      required this.state,
      required this.shop});

  factory OfferInvoiceDetails.fromMap(Map<String, dynamic> json) =>
      OfferInvoiceDetails(
          id: json["id"],
          amount: json["amount"],
          vat: json["vat"],
          created_at: json["created_at"],
          state: json['state'],
          shop: OfferInvoiceDetailsShop.fromMap(json["shop"]));

  Map<String, dynamic> toMap() => {
        "id": id,
        "amount": amount,
        "vat": vat,
        "created_at": created_at,
        "shop": shop
      };
}

class OfferInvoiceDetailsShop {
  int id;
  String name;
  String tax_register;

  OfferInvoiceDetailsShop({
    required this.id,
    required this.name,
    required this.tax_register,
  });

  factory OfferInvoiceDetailsShop.fromMap(Map<String, dynamic> json) =>
      OfferInvoiceDetailsShop(
        id: json["id"],
        name: json["name"],
        tax_register: json["tax_register"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "tax_register": tax_register,
      };
}
