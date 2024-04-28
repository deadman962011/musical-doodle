import 'dart:convert';

MerchantSaveOfferResponse merchantSaveOfferResponseFromJson(String str) => MerchantSaveOfferResponse.fromJson(json.decode(str));

class MerchantSaveOfferResponse {
  MerchantSaveOfferResponse({
    required this.success,
  });
  bool success;

  factory MerchantSaveOfferResponse.fromJson(Map<String, dynamic> json) => MerchantSaveOfferResponse(
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
  };
}


