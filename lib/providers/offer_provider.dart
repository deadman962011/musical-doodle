import 'package:csh_app/models/items/Offer.dart';
import 'package:csh_app/models/responses/merchant/offer/merchant_offers_response.dart';
import 'package:flutter/material.dart';

class OfferProvider with ChangeNotifier {
  late Offer? _firstOffer;

  Offer? get firstOffer => _firstOffer;

  void setFirstOffer(Offer offer) {
    _firstOffer = offer;
    notifyListeners();
  }

  void clearFirstOffer() {
    _firstOffer = null;
    notifyListeners();
  }
}
