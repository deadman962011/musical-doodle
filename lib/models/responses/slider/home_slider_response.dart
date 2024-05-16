import 'dart:convert';
import 'package:com.mybill.app/models/items/Slider.dart';

HomeSliderResponse homeSliderResponseFromJson(String str) =>
    HomeSliderResponse.fromJson(json.decode(str));

class HomeSliderResponse {
  HomeSliderResponse({
    required this.slider,
    required this.success,
  });

  bool success;
  SliderItem slider;

  factory HomeSliderResponse.fromJson(Map<String, dynamic> json) =>
      HomeSliderResponse(
        success: json["success"],
        slider: SliderItem.fromJson(json['payload']),
      );

  Map<String, dynamic> toJson() => {"success": success, "slider": slider};
}
