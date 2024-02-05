import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishingline/pages/sidebar/contacts.dart';
import 'package:fishingline/pages/sidebar/informations.dart';
import 'package:fishingline/pages/sidebar/settings.dart';
import 'package:fishingline/services/webview/facebook.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/date_symbol_data_local.dart';

class WeatherForecastPage extends StatefulWidget {
  const WeatherForecastPage({Key? key}) : super(key: key);

  @override
  _WeatherForecastPageState createState() => _WeatherForecastPageState();
}

class _WeatherForecastPageState extends State<WeatherForecastPage> {
  final String apiKey = '96a66d529a57a3ab69b4cd7cfb5cd421';
  final String apiUrl = 'https://api.openweathermap.org/data/2.5/forecast?';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Timer? _timer;

  final user = FirebaseAuth.instance.currentUser!;
  User? userForProfile = FirebaseAuth.instance.currentUser;

  List<dynamic> forecastData = [];

  Future<void> getForecastData() async {
    Position position = await getCurrentLocation();
    final response = await http.get(Uri.parse(
        '$apiUrl' + 'lat=${position.latitude}&lon=${position.longitude}&appid=' + apiKey));
    final data = jsonDecode(response.body);
    setState(() {
      forecastData = data['list'];
    });
  }

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    return position;
  }

  @override
  void initState() {
    super.initState();
    getForecastData();
    _timer = Timer.periodic(Duration(seconds: 0), (timer) {
      setState(() {
        userForProfile = FirebaseAuth.instance.currentUser;
      });
    });
  }

  void runFacebook() {
    openFacebook(context);
  }

  String translateWeatherDescription(String description) {
  switch (description) {
    case 'clear sky':
      return 'Tiszta égbolt';
    case 'few clouds':
      return 'Kevés felhő';
    case 'scattered clouds':
      return 'Szétszórt felhő';
    case 'broken clouds':
      return 'Szakadozott felhő';
    case 'overcast clouds':
      return 'Borult felhők';
    case 'mist':
      return 'Köd';
    case 'smoke':
      return 'Füst';
    case 'haze':
      return 'Ködös';
    case 'dust':
      return 'Por';
    case 'fog':
      return 'Köd';
    case 'sand':
      return 'Homok';
    case 'dust':
      return 'Por';
    case 'volcanic ash':
      return 'Vulkáni hamu';
    case 'squalls':
      return 'Széllökések';
    case 'tornado':
      return 'Tornádó'; //Hát bro, ha itt lesz Tornádó, akkor majd lesz ez is. <3
    case 'rain':
      return 'Eső';
    case 'drizzle':
      return 'Szitálás';
    case 'shower rain':
      return 'Zápor';
    case 'thunderstorm':
      return 'Zivatar';
    case 'snow':
      return 'Hó';
    case 'light rain':
      return 'Enyhe eső';
    case 'moderate rain':
      return 'Mérsékelt eső';
    case 'heavy intensity rain':
      return 'Heves eső';
    default:
      print("[FISHINGLINE DEBUG]> Undefinied weather status:" + description);
      return 'Ismeretlen';
  }
}

String capitalizeFirstLetter(String text) {
  return text.substring(0, 1).toUpperCase() + text.substring(1);
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 0, 50, 87),
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
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
      ),
      title: Image.asset(
      'lib/images/fishingline_logo.png',
      width: 120,
      ),
      automaticallyImplyLeading: false, // Remove the default back button
      actions: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: IconButton(
          icon: const Icon(Icons.menu),
          tooltip: 'Menü',
          onPressed: () {
            _scaffoldKey.currentState?.openEndDrawer();
          },
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
        body: forecastData.isEmpty
            ? Container(alignment: Alignment.center,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/images/home_background.png"),
                  fit: BoxFit.cover,
                )
          ),child: Lottie.asset('lib/animations/LoadingAnimation.json', width: 200),)
            : Container(alignment: Alignment.center,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/images/home_background.png"),
                  fit: BoxFit.cover,
                )
          ),
              child: ListView.builder(
      itemCount: forecastData.length,
      itemBuilder: (BuildContext context, int index) {
      final forecast = forecastData[index];
      final dateTime = DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000);
      final hour = '${dateTime.hour.toString().padLeft(2, '0')}:00';
    
      initializeDateFormatting('hu_HU'); // Initialize Hungarian date format
    
      final dayOfWeek = DateFormat('EEEE', 'hu_HU').format(dateTime);
      final capitalizedDayOfWeek = dayOfWeek.replaceRange(0, 1, dayOfWeek[0].toUpperCase());
      final temperature = (forecast['main']['temp'] - 273.15).toInt();
      final description = forecast['weather'][0]['description'];
      final fullDate = DateFormat('MMMM d, yyyy').format(dateTime);
      String weatherForecastAnimation = 'lib/animations/LoadingAnimation.json';
    
      if (description == 'clear sky') {weatherForecastAnimation = 'lib/animations/Sunny.json';}
      if (description == 'scattered clouds' || description == 'broken clouds' || description == 'overcast clouds' || description == 'few clouds') {weatherForecastAnimation = 'lib/animations/Cloudy.json';}
      if (description == 'mist' || description == 'smoke' || description == 'haze' || description == 'dust' || description == 'fog' || description == 'sand' || description == 'dust' || description == 'volcanic ash' || description == 'squalls') {weatherForecastAnimation = 'lib/animations/Fog.json';}
      if (description == 'moderate rain' || description == 'heavy intensity rain' || description == 'light rain' || description == 'rain' || description == 'drizzle' || description == 'shower rain') {weatherForecastAnimation = 'lib/animations/Rainy.json';}
      if (description == 'snow' || description == 'squalls' || description == 'tornado') {weatherForecastAnimation = 'lib/animations/LoadingAnimation.json';}
      if (description == 'thunderstorm') {weatherForecastAnimation = 'lib/animations/ThunderStorm.json';}
    
      return ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              hour,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 25,
              ),
            ),
            SizedBox(width: 10),
            Lottie.asset(
              weatherForecastAnimation, // Replace with your Lottie animation file path
              height: 40,
              width: 40,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$capitalizedDayOfWeek $temperature°C',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 25,
                  ),
                ),
                Text(
                  '$fullDate ${translateWeatherDescription(description)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
      },
    ),
            ),
              bottomNavigationBar: BottomAppBar(
          height: 50,
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
                  Text(
                    'Az adatok forrása: OpenWeather',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 187, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
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

void main() {
  runApp(const MaterialApp(
    home: WeatherForecastPage(),
  ));
}