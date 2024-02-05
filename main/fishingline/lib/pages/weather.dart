import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishingline/api_models/weather_model_api.dart';
import 'package:fishingline/components/weatherforecast.dart';
import 'package:fishingline/pages/sidebar/contacts.dart';
import 'package:fishingline/pages/sidebar/informations.dart';
import 'package:fishingline/pages/sidebar/settings.dart';
import 'package:fishingline/services/weather_service.dart';
import 'package:fishingline/services/webview/facebook.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _weatherService = WeatherService('96a66d529a57a3ab69b4cd7cfb5cd421');

  final user = FirebaseAuth.instance.currentUser!;
  User? userForProfile = FirebaseAuth.instance.currentUser;

  Weather? _weather;

  void runFacebook() {
    openFacebook(context);
  }

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 8,28,68),
      ),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0),
            ),
          ),
      backgroundColor: const Color.fromARGB(255, 0, 34, 68),
      centerTitle: true,
      iconTheme: const IconThemeData(
      size: 40,
      color: Color.fromARGB(255, 255, 187, 0), //change your color here
      ),
      titleSpacing: 10,
      toolbarHeight: 75,
      leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
      title: Image.asset(
      'lib/images/fishingline_logo.png',
      width: 120,
      ),
      actions: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menü',
          onPressed: (){_scaffoldKey.currentState?.openEndDrawer();}, // Call the void function here
        ),
      ),
      ],
    ),
    endDrawer: Drawer(
        child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/login_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  alignment: Alignment.center,
                  height: 130,
                  child: Image.asset(
                    'lib/images/logo_sidebar.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
    
            Row(
              children: [
    
                SizedBox(width: 10),
    
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 255, 187, 0),
                  backgroundImage: NetworkImage(userForProfile!.photoURL.toString()),
                  radius: 25.0,
                ),
    
                SizedBox(width: 10),
    
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userForProfile!.displayName.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 21,
                          ),
                        ),
                        Text(
                          userForProfile!.email.toString(),
                          style: TextStyle(
                            color: const Color.fromARGB(255, 255, 160, 18),
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
    
            SizedBox(height: 10),
    
            ListTile(
              leading: Icon(Icons.settings, size: 30, color: Color.fromARGB(255, 255, 187, 0),),
              title: Text('Beállítások', style: TextStyle(fontSize: 15, color: Colors.white)),
              onTap: () { 
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts, size: 30, color: Color.fromARGB(255, 255, 187, 0),),
              title: Text('Elérhetőségek', style: TextStyle(fontSize: 15, color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactsSidePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info, size: 30, color: Color.fromARGB(255, 255, 187, 0),),
              title: Text('Információk', style: TextStyle(fontSize: 15, color: Colors.white)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InformationsSidePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.web, size: 30, color: Color.fromARGB(255, 255, 187, 0)),
              title: Text('Weboldal', style: TextStyle(fontSize: 15, color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.facebook, size: 30, color: Color.fromARGB(255, 255, 187, 0),),
              title: Text('Facebook', style: TextStyle(fontSize: 15, color: Colors.white)),
              onTap: () {
                runFacebook();
              },
            ),
            Expanded(
              child: Divider(
                thickness:  0.5,
                color: Color.fromARGB(0, 255, 255, 255)
              ),
            ),
            Text('''
      Fishingline 2023-2024 Verzió: 1.2.8
      Fejlesztette: nikkeisadev.
            ''', style: TextStyle(fontSize: 15, color: Colors.white)),
          ],
        ),
        ),
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
                Lottie.asset(getWeatherAnimation(_weather?.mainCondition), width: 230),
                const SizedBox(height: 0),
                Text(
                  translatedWeatherStatus,
                  style: TextStyle(
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                Divider(
                    thickness: 2,
                    color: const Color.fromARGB(255, 255, 187, 0),
                    indent: 110,
                    endIndent: 110,
                ),
    
                const SizedBox(height: 3),
    
                Text("Dátum, és idő:",
                style: TextStyle(color: Colors.white, fontSize: 13),
                ),
    
                Text(
                    '${DateFormat('HH:mm').format(DateTime.now())}  '
                    '${DateFormat('yyyy.MM.dd').format(DateTime.now())}',
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500), textAlign: TextAlign.center,
                ),
    
                const SizedBox(height: 10),
    
                Text("Jelenlegi tartózkodási helyed:",
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
                      ..strokeWidth = 35
                      ..strokeJoin = StrokeJoin.round
                      ..strokeCap = StrokeCap.round
                      ..style = PaintingStyle.stroke,
                    color: Colors.white,
                  ),
                ),
                
                const SizedBox(height: 25),
                Text("A Jelenlegi hőmérséklet:",
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
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 100,
          shape: const CircularNotchedRectangle(),
          color: const Color.fromARGB(255, 0, 34, 68),
          child: IconTheme(
            data: const IconThemeData(
              color: Color.fromARGB(255, 255, 187, 0)),
            child: Padding(
              padding: const EdgeInsets.all(12.0), 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => WeatherForecastPage()),
                            );
                          },
                          icon: Icon(Icons.cloud, size: 20,),
                          label: Text('Előrejelzés', style: TextStyle(color: Colors.white, fontSize: 20)),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(20, 255, 255, 255),
                          ),
                        ),
                      ),
                      Text(
                        'Az adatok forrása: OpenWeather',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 187, 0),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ),
          ),
        ),   
      ),
    );
  }
}