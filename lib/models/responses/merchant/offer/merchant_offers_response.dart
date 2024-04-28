import 'dart:convert';

import 'package:csh_app/models/items/Offer.dart';

MerchantOffersResponse merchantOffersResponseFromJson(String str) =>
    MerchantOffersResponse.fromJson(json.decode(str));

class MerchantOffersResponse {
  MerchantOffersResponse({
    required this.offers,
    required this.success,
  });

  List<Offer> offers;
  bool success;

  factory MerchantOffersResponse.fromJson(Map<String, dynamic> json) =>
      MerchantOffersResponse(
        success: json["success"],
        offers: List<Offer>.from(json["payload"].map((x) => Offer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {"success": success, "offers": offers};
}
