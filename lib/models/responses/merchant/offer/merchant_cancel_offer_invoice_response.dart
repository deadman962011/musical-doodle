// To parse this JSON data, do
//
//     final merchantCancelOfferInvoiceResponse = merchantCancelOfferInvoiceResponseFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MerchantCancelOfferInvoiceResponse merchantCancelOfferInvoiceResponseFromMap(
        String str) =>
    MerchantCancelOfferInvoiceResponse.fromMap(json.decode(str));

String merchantCancelOfferInvoiceResponseToMap(
        MerchantCancelOfferInvoiceResponse data) =>
    json.encode(data.toMap());

class MerchantCancelOfferInvoiceResponse {
  bool success;
  dynamic payload;
  String message;

  MerchantCancelOfferInvoiceResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory MerchantCancelOfferInvoiceResponse.fromMap(
          Map<String, dynamic> json) =>
      MerchantCancelOfferInvoiceResponse(
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
