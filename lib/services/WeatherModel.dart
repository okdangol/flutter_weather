import 'package:flutter_weather/services/ApiHelper.dart';
import 'package:flutter_weather/services/LocationService.dart';

class WeatherModel {
  Future<dynamic> getWeatherByCurrentLocation() async {
    LocationService locationService = LocationService();
    await locationService.getCurrentLocation();

    ApiHelper apiHelper = ApiHelper();
    var resultJson = await apiHelper.getWeatherJsonFromLocation(locationService.latitude, locationService.longitude);

    return resultJson;
  }

  Future<dynamic> getWeatherByCityName(String cityname) async {
    ApiHelper apiHelper = ApiHelper();
    var resultJson = await apiHelper.getWeatherJsonByCityName(cityname);

    return resultJson;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    print('getMessage temp=${temp}');
    if (temp > 25) {
      // return 'It\'s 🍦 time';
      return 'It\'s 아이스크림 time';
    } else if (temp > 20) {
      // return 'Time for shorts and 👕';
      return 'Time for 반바지와 반팔티';
    } else if (temp < 10) {
      // return 'You\'ll need 🧣 and 🧤';
      return 'You\'ll need 목도리와장갑';
    } else {
      // return 'Bring a 🧥 just in case';
      return 'Bring a * just in case';
    }
  }
}
