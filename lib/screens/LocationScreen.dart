import 'package:flutter/material.dart';
import 'package:flutter_weather/screens/CityScreen.dart';
import 'package:flutter_weather/services/WeatherModel.dart';
import 'package:flutter_weather/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherData});

  final weatherData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temperature;
  String weatherIcon;
  String message;

  void _updateUI(dynamic weatherData) {
    WeatherModel weatherModel = WeatherModel();
    temperature = weatherData['main']['temp'].round();
    weatherIcon = weatherModel.getWeatherIcon(weatherData['weather'][0]['id']);
    message = '${weatherModel.getMessage(temperature)} in ${weatherData['name']}';
  }

  @override
  void initState() {
    super.initState();
    _updateUI(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var cityname = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (cityname != null) {
                        WeatherModel weatherModel = WeatherModel();
                        dynamic resultJson = await weatherModel.getWeatherByCityName(cityname);
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return LocationScreen(weatherData: resultJson);
                        }));
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  message,
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// print('현재 온도 ${resultJson['main']['temp']}');
// print('날씨 아이디 ${resultJson['weather'][0]['id']}');
// print('날씨 아이디 ${resultJson['name']}');
