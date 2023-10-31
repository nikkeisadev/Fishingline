import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishingline/api_models/weather_model_api.dart';
import 'package:fishingline/services/weather_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  
  //Google Maps API integration.
  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }
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
              
              Lottie.asset(
                'lib/animations/SunnyAndRaining.json',
                ),
              
              const SizedBox(height: 40),

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
        height: 80,
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

                Text(
                  'Tartózkódási helye jelenleg: \n${_weather?.cityName}.',
                  style: TextStyle(fontSize: 20,
                    color: Colors.white,
                  ),
                ),

                IconButton(
                    icon: const Icon(
                      Icons.map,
                      size: 40,

                  ),
                  onPressed: () {},
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}