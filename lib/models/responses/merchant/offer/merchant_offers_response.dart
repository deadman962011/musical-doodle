import 'dart:convert';

import 'package:com.mybill.app/models/items/MerchantIOffer.dart';
import 'package:com.mybill.app/models/items/Offer.dart';

MerchantOffersResponse merchantOffersResponseFromJson(String str) =>
    MerchantOffersResponse.fromJson(json.decode(str));

class MerchantOffersResponse {
  MerchantOffersResponse({
    required this.offers,
    required this.success,
  });

  List<MerchantOffer> offers;
  bool success;

  factory MerchantOffersResponse.fromJson(Map<String, dynamic> json) =>
      MerchantOffersResponse(
        success: json["success"],
        offers: List<MerchantOffer>.from(
            json["payload"].map((x) => MerchantOffer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {"success": success, "offers": offers};
}
