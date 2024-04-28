class CategoryItem {
  CategoryItem({required this.id, required this.name, required this.thumbnail});

  int id;
  String name;
  String thumbnail;

  factory CategoryItem.fromJson(Map<String, dynamic> json) => CategoryItem(
      id: json["id"], name: json['name'], thumbnail: json['thumbnail']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "thumbnail": thumbnail,
      };
}
