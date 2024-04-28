class ZoneItem {
  ZoneItem({required this.id, required this.name});

  int id;
  String name;

  factory ZoneItem.fromJson(Map<String, dynamic> json) =>
      ZoneItem(id: json["id"], name: json['name']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
