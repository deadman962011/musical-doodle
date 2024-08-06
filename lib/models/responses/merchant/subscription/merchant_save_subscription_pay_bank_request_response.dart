// To parse this JSON data, do
//
//     final merchantSavePaySubscriptionBankRequestResponse = merchantSavePaySubscriptionBankRequestResponseFromJson(jsonString);

import 'dart:convert';

MerchantSavePaySubscriptionBankRequestResponse merchantSavePaySubscriptionBankRequestResponseFromJson(String str) => MerchantSavePaySubscriptionBankRequestResponse.fromJson(json.decode(str));

String merchantSavePaySubscriptionBankRequestResponseToJson(MerchantSavePaySubscriptionBankRequestResponse data) => json.encode(data.toJson());

class MerchantSavePaySubscriptionBankRequestResponse {
    bool success;
    String message;

    MerchantSavePaySubscriptionBankRequestResponse({
        required this.success,
        required this.message,
    });

    factory MerchantSavePaySubscriptionBankRequestResponse.fromJson(Map<String, dynamic> json) => MerchantSavePaySubscriptionBankRequestResponse(
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
    };
}
