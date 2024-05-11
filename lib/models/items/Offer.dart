class Offer {
  Offer(
      {required this.id,
      required this.name,
      required this.state,
      required this.sales,
      required this.commission,
      required this.cashback_amount,
      required this.start_date,
      required this.end_date,
      required this.thumbnail,
      required this.isFavorite,
      required this.days_left,
      required this.shop});

  int id;
  String name;
  String state;
  int sales;
  int commission;
  int cashback_amount;
  String start_date;
  String end_date;
  String thumbnail;
  bool isFavorite;
  int days_left;
  Map<String, dynamic> shop;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
      id: json["id"],
      name: json['name'],
      state: json['state'],
      sales: json['sales'],
      commission: json['commission'],
      cashback_amount: json['cashback_amount'],
      start_date: json['start_date'],
      end_date: json['end_date'],
      thumbnail: json['thumbnail'],
      isFavorite: json['isFavorite'],
      days_left: json['days_left'],
      shop: json['shop']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "start_date": start_date,
        "end_date": end_date,
      };
}
