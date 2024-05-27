// To parse this JSON data, do
//
//     final userOfferInvoiceScanResponse = userOfferInvoiceScanResponseFromMap(jsonString);

import 'dart:convert';

UserOfferInvoiceScanResponse userOfferInvoiceScanResponseFromMap(String str) =>
    UserOfferInvoiceScanResponse.fromMap(json.decode(str));

String userOfferInvoiceScanResponseToMap(UserOfferInvoiceScanResponse data) =>
    json.encode(data.toMap());

class UserOfferInvoiceScanResponse {
  bool success;
  dynamic payload;
  String message;

  UserOfferInvoiceScanResponse({
    required this.success,
    required this.payload,
    required this.message,
  });

  factory UserOfferInvoiceScanResponse.fromMap(Map<String, dynamic> json) =>
      UserOfferInvoiceScanResponse(
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
