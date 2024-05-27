import 'package:com.mybill.app/models/responses/slider/home_slider_response.dart';
import 'package:http/http.dart' as http;
import 'package:com.mybill.app/app_config.dart';
import 'package:com.mybill.app/helpers/shared_value_helper.dart';

class SliderRepository {
  Future<dynamic> getUserHomeSliderResponse() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/slider/home");
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        "Content-Type": "application/json",
        "Accept-Language": app_language.$,
      },
    );
    AppConfig.alice.onHttpResponse(response, body: null);
    if (response.statusCode == 200) {
      return homeSliderResponseFromJson(response.body);
    } else {
      return false;
    }
  }
}
