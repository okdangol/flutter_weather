import 'dart:convert';

import 'package:http/http.dart';

class ApiHelper {
  Future<dynamic> getWeatherJsonFromLocation(double latitude, double longitude) async {
    Uri url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'appid': 'a3eaf29855904a34b0447fbc47592bf2',
      'units': 'metric',
    });

    Response response = await get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  Future<dynamic> getWeatherJsonByCityName(String cityname) async {
    Uri url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
      'q': cityname,
      'appid': 'a3eaf29855904a34b0447fbc47592bf2',
      'units': 'metric',
    });

    Response response = await get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
