import 'package:com.mybill.app/models/items/MerchantIOffer.dart';
import 'package:flutter/material.dart';

class OfferProvider with ChangeNotifier {
  late MerchantOffer? _firstOffer;

  MerchantOffer? get firstOffer => _firstOffer;

  void setFirstOffer(MerchantOffer offer) {
    _firstOffer = offer;
    notifyListeners();
  }

  void clearFirstOffer() {
    _firstOffer = null;
    notifyListeners();
  }
}
