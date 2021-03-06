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
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    print('getMessage temp=${temp}');
    if (temp > 25) {
      // return 'It\'s ๐ฆ time';
      return 'It\'s ์์ด์คํฌ๋ฆผ time';
    } else if (temp > 20) {
      // return 'Time for shorts and ๐';
      return 'Time for ๋ฐ๋ฐ์ง์ ๋ฐํํฐ';
    } else if (temp < 10) {
      // return 'You\'ll need ๐งฃ and ๐งค';
      return 'You\'ll need ๋ชฉ๋๋ฆฌ์์ฅ๊ฐ';
    } else {
      // return 'Bring a ๐งฅ just in case';
      return 'Bring a * just in case';
    }
  }
}
