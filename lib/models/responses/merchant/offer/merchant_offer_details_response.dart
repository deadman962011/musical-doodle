import 'dart:convert';

MerchantOfferDetailsResponse merchantOfferDetailsResponseFromJson(String str) => MerchantOfferDetailsResponse.fromJson(json.decode(str));

class MerchantOfferDetailsResponse {
  MerchantOfferDetailsResponse({
    required this.offer,
    required this.success,
  });

  OfferWithDetails offer;
  bool success;

  factory MerchantOfferDetailsResponse.fromJson(Map<String, dynamic> json) => MerchantOfferDetailsResponse(
    success: json["success"],
    offer: json['payload'],
  );
  // OfferWithDetails.from(json["payload"].map((x) => Offer.fromJson(x)))

  Map<String, dynamic> toJson() => {
    "success": success,
    "offer":offer

  };
}



class OfferWithDetails {
  OfferWithDetails({
    required this.id,
    required this.name,
    required this.state,
    required this.sales,
    required this.commission,
    required this.start_date,
    required this.end_date, 
    
  });

  int id;
  String name;
  String state;
  int commission;
  String start_date;
  String end_date;
  List<OfferSale> sales;

  factory OfferWithDetails.fromJson(Map<String, dynamic> json) => OfferWithDetails(
    id: json["id"],
    name: json['name'],
    state:json['state'],
    sales:json['sales'],
    commission:json['commission'],
    start_date: json['start_date'],
    end_date: json['end_date'], 
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "name": name,
    "start_date":start_date,
    "end_date":end_date,
    "commission":commission,
    "state":state,
    "sales":sales,


  };
}


class OfferSale {
  OfferSale({
    required this.id,
    required this.name,
    
  });

  int id;
  String name; 

  factory OfferSale.fromJson(Map<String, dynamic> json) => OfferSale(
    id: json["id"],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "name": name,

  };
}