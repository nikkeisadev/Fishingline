import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishingline/api_models/weather_model_api.dart';
import 'package:fishingline/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CallableWeather extends StatefulWidget {
  const CallableWeather({Key? key}) : super(key: key);

  @override
  State<CallableWeather> createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<CallableWeather> {
  final _weatherService = WeatherService('96a66d529a57a3ab69b4cd7cfb5cd421');
  final user = FirebaseAuth.instance.currentUser!;
  Weather? _weather;

  Future<void> _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String translatedWeatherStatus = '';
  String getWeatherAnimation(String? mainCondition) {
      DateTime currentTime = DateTime.now();
      int hour = currentTime.hour;

      if (mainCondition == null) return 'lib/animations/LoadingAnimation.json';

      switch (mainCondition.toLowerCase()) {
        case 'clouds':
        case 'mist':
        case 'smoke':
        case 'haze':
        case 'dust':
          translatedWeatherStatus = "Felhős";
          return 'lib/animations/Cloudy.json';
        case 'fog':
          translatedWeatherStatus = "Köd";
          return 'lib/animations/Fog.json';
        case 'rain':
        case 'driyyle':
        case 'shower rain':
          translatedWeatherStatus = "Esős";
          return 'lib/animations/Rainy.json';
        case 'thunderstorm':
          translatedWeatherStatus = "Vihar";
          return 'lib/animations/ThunderStorm.json';
        case 'clear':
          translatedWeatherStatus = "Tiszta égbolt";
          if (hour >= 19) {return 'lib/animations/Moon.json';}
          else {return 'lib/animations/Sunny.json';}
        default:
          translatedWeatherStatus = "";
          return 'lib/animations/LoadingAnimation.json';
      }
    }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
Widget build(BuildContext context) {
  return Container(
    height: 100,
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(getWeatherAnimation(_weather?.mainCondition), width: 100),
          const SizedBox(width: 80),
          Column(
            children: [
              const SizedBox(height: 20),
              Text(
                translatedWeatherStatus,
                style: const TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 0),
              Text(
                "A Jelenlegi hőmérséklet.",
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${_weather?.temperature.round()}°C',
                      style: const TextStyle(fontSize: 20, color: Color.fromARGB(255, 255, 187, 0)),
                    ),
                    WidgetSpan(
                      child: Icon(
                        Icons.dew_point,
                        size: 20,
                        color: const Color.fromARGB(255, 255, 187, 0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}