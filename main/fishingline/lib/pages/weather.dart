import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishingline/api_models/weather_model_api.dart';
import 'package:fishingline/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('96a66d529a57a3ab69b4cd7cfb5cd421');
  final user = FirebaseAuth.instance.currentUser!;
  Weather? _weather;

  _fetchWeather() async {

    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }

    catch (e) {
      print(e);
    }
  }

  final String translatedWeatherStatus = '';
  String getWeatherAnimation(String? mainCondition) {
      if (mainCondition == null) return 'lib/animations/Sunny.json';

      switch (mainCondition.toLowerCase()) {
        case 'clouds':
        case 'mist':
        case 'smoke':
        case 'haze':
        case 'dust':
          return 'lib/animations/Cloudy.json';
        case 'fog':
          return 'lib/animations/Fog.json';
        case 'rain':
        case 'driyyle':
        case 'shower rain':
          return 'lib/animations/Rainy.json';
        case 'thunderstorm':
          return 'lib/animations/ThunderStorm.json';
        case 'clear':
          return 'lib/animations/Sunny.json';
        default:
          return 'lib/animations/Sunny.json';

      }
    }
  
  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 34, 68),
        centerTitle: true,
        iconTheme: const IconThemeData(
          size: 40,
          color:Color.fromARGB(255, 255, 187, 0), //change your color here
          ),
        titleSpacing: 10,
        toolbarHeight: 75,
        title: Image.asset(
          'lib/images/fishingline_logo.png',
          width: 120,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Profile',
            onPressed: () {
              // handle the press
            },
          ),
        ],
       
      ),
      body: Container(
              decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/weather_background.png"),
                fit: BoxFit.cover,
              ),
            ),
        child: Center(
          child: Column(
            
            mainAxisAlignment: MainAxisAlignment.center,
            
            children: [
              
              Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

              const SizedBox(height: 10),
              
              Text(
                _weather?.mainCondition ?? "",
                style: TextStyle(
                  color: const Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Divider(
                  thickness: 2,
                  color: const Color.fromARGB(255, 255, 187, 0),
                  indent: 110,
                  endIndent: 110,
              ),

              const SizedBox(height: 10),

              Text("Jelenlegi tartózkodási helye:",
              style: TextStyle(color: Colors.white, fontSize: 13),
              ),

              const SizedBox(height: 20),
              
              Text(
                  _weather?.cityName ?? "Adatok lekérése...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  background: Paint()
                    ..color = const Color.fromARGB(255, 255, 187, 0)
                    ..strokeWidth = 30
                    ..strokeJoin = StrokeJoin.round
                    ..strokeCap = StrokeCap.round
                    ..style = PaintingStyle.stroke,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 25),
              Text("A Jelenlegi hőmérséklet.",
              style: TextStyle(color: Colors.white, fontSize: 15),
              ),

              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${_weather?.temperature.round()}°C',
                      style: TextStyle(fontSize: 40)
                    ),
                    const WidgetSpan(
                      child: Icon(
                        Icons.dew_point, 
                        size: 40,
                        color: const Color.fromARGB(255, 255, 187, 0),
                        ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        height: 130,
        shape: const CircularNotchedRectangle(),
        color: const Color.fromARGB(255, 0, 34, 68),
        child: IconTheme(
          data: const IconThemeData(
            color: Color.fromARGB(255, 255, 187, 0)),
          child: Padding(
            padding: const EdgeInsets.all(10.0), 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'lib/images/mapboxintegration.png',
                  color: Colors.white,
                  width: 200,
                  )
              ],
            )
          ),
        ),
      ),
    );
  }
}