// To parse this JSON data, do
//
//     final merchantSavePayOfferCommissionRequestResponse = merchantSavePayOfferCommissionRequestResponseFromJson(jsonString);

import 'dart:convert';

MerchantSavePayOfferCommissionRequestResponse
    merchantSavePayOfferCommissionRequestResponseFromJson(String str) =>
        MerchantSavePayOfferCommissionRequestResponse.fromJson(
            json.decode(str));

String merchantSavePayOfferCommissionRequestResponseToJson(
        MerchantSavePayOfferCommissionRequestResponse data) =>
    json.encode(data.toJson());

class MerchantSavePayOfferCommissionRequestResponse {
  bool success;
  String message;

  MerchantSavePayOfferCommissionRequestResponse({
    required this.success,
    required this.message,
  });

  factory MerchantSavePayOfferCommissionRequestResponse.fromJson(
          Map<String, dynamic> json) =>
      MerchantSavePayOfferCommissionRequestResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
