class SliderItem {
  SliderItem({required this.id, required this.name, required this.slides});

  int id;
  String name;
  List<SlideItem> slides;

  factory SliderItem.fromJson(Map<String, dynamic> json) => SliderItem(
      id: json["id"],
      name: json['name'],
      slides: List<SlideItem>.from(
          json['slides'].map((x) => SlideItem.fromJson(x))));

  Map<String, dynamic> toJson() => {"id": id, "name": name, "slides": slides};
}

class SlideItem {
  SlideItem({
    required this.id,
    required this.image_url,
  });

  int id;
  String image_url;

  factory SlideItem.fromJson(Map<String, dynamic> json) => SlideItem(
        id: json["id"],
        image_url: json['image_url'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": image_url,
      };
}
