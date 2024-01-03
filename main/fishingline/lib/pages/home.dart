import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishingline/components/bar_graph/bargraph.dart';
import 'package:fishingline/components/callableweather.dart';
import 'package:fishingline/pages/newsrss.dart';
import 'package:fishingline/pages/settings/profile.dart';
import 'package:fishingline/pages/sidebar/contacts.dart';
import 'package:fishingline/pages/sidebar/informations.dart';
import 'package:fishingline/pages/sidebar/settings.dart';
import 'package:fishingline/pages/waterlevelrss.dart';
import 'package:fishingline/pages/weather.dart';
import 'package:fishingline/services/webview/facebook.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  FirebaseDatabase database = FirebaseDatabase.instance;
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //Time to refresh online data.
  Timer? _timer;

  //Activity values for line chart.
  List<double> monthlySummary = 
  [
    10, 
    12, 
    13, 
    11, 
    20, 
    13, 
    7, 
    8, 
    10, 
    13, 
    12, 
    8
  ];

  //User, and Current User values.
  final user = FirebaseAuth.instance.currentUser!;
  User? userForProfile = FirebaseAuth.instance.currentUser;

  //Sign the user out of Fishingline.
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void runFacebook() {
    openFacebook(context);
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 0), (timer) {
      setState(() {
        userForProfile = FirebaseAuth.instance.currentUser;
      });
    });
  }

  void globalErrorDialog(BuildContext context, String message, String title) {
  showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color.fromRGBO(13, 50, 87, 1),
        title: Text(title),
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 160, 18),
            ),
            child: const Text(
              "Vissza",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              signUserOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 160, 18),
            ),
            child: const Text(
              "Kijelentkezés",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ],
        contentTextStyle: const TextStyle(
          fontSize: 20,
        ),
        content: Text(message),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    void globalEmptyFunctionDialog(BuildContext context, String message, String title) {
      showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color.fromRGBO(13, 50, 87, 1),
            title: Text(title),
            titleTextStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 160, 18),
                ),
                child: const Text(
                  "Vissza",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ],
            contentTextStyle: const TextStyle(
              fontSize: 20,
            ),
            content: Text(message),
          );
        },
      );
    }
    double sumCatches = monthlySummary.fold(0, (previous, current) => previous + current);
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
      title: Image.asset(
      'lib/images/fishingline_logo.png',
      width: 120,
      ),
      leading: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Kijelentkezés',
            onPressed: () {
              globalErrorDialog(
                context,
                'Biztosan ki szeretnél jelentkezni a profilodból?',
                'Kijelentkezés',
              );
            },
          ),
        ),
      ],
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
        body: 
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/images/home_background.png"),
                  fit: BoxFit.cover,
                )
          ),
          child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.0),
              color: const Color.fromARGB(255, 0, 34, 68),
              image: DecorationImage(
                image: AssetImage('lib/images/button_background.png'),
                fit: BoxFit.cover,
              ),
            ),
            height: 80,
            child: 
              Row(
              children: [
                const SizedBox(width: 20),
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 255, 187, 0),
                  backgroundImage: NetworkImage(userForProfile!.photoURL.toString()),
                  radius: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileSettings()),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userForProfile!.displayName.toString() + ' 🎣',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                          ),
                        ),
                        Text(
                          'Statisztikák, és profil beállítások.',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
    
          const SizedBox(height: 10),
          
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: const Color.fromARGB(255, 0, 34, 68),
              ),
              height: 330,
              child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                    "Kifogások aktivitása",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    background: Paint()
                      ..color = const Color.fromARGB(255, 255, 187, 0)
                      ..strokeWidth = 25
                      ..strokeJoin = StrokeJoin.round
                      ..strokeCap = StrokeCap.round
                      ..style = PaintingStyle.stroke,
                    color: Colors.white,
                  ),
                ),
                    SizedBox(
                    height: 200,
                    child: 
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: BarGraphActivity(monthlySummary: monthlySummary),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:50.0),
                    child: Divider(
                    thickness: 2,
                    color: const Color.fromARGB(255, 255, 187, 0),
                  ),
                ),
                  Text('Az összes fogásod eddig: ''$sumCatches', style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 255, 187, 0), fontWeight: FontWeight.w500)),
                  Text('Az egész éves aktivitásod a halak kifogásában.', style: TextStyle(fontSize: 16, color: Colors.white,)),
                  Text('Koppints a részletesebb infókért!', style: TextStyle(fontSize: 16, color: Colors.white)) ,
                ],
              )
            ),
          ),
    
          const SizedBox(height: 10),
    
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: const Color.fromARGB(255, 0, 34, 68),
                image: DecorationImage(
                  image: AssetImage("lib/images/weather_bar_background.png"),
                  fit: BoxFit.cover,
                )
              ),
              height: 100,
              child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CallableWeather()
                  ],
              )
            ),
          ),
        ]
      ),
        ),
        extendBody: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.large(
          onPressed: () {
            globalEmptyFunctionDialog(context, 'Sajnos még nem tudsz fogásokat tárolni az alkalmazásban.', 'Nem elérhető funkció!');
          },
          backgroundColor: const Color.fromARGB(255, 0, 34, 68),
          foregroundColor: const Color.fromARGB(255, 255, 187, 0),
        child: Icon(Icons.add, size: 60,)
        ),
        bottomNavigationBar: BottomAppBar(
          height: 80,
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
    
                  IconButton(
                      icon: const Icon(
                        Icons.newspaper,
                        size: 35,
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RSSNews()),
                      );
                    },
                    padding: const EdgeInsets.all(5),
                  ),
    
                  IconButton(
                      icon: const Icon(
                        Icons.cloud,
                        size: 40,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WeatherPage()),
                      );
                    },
                    padding: const EdgeInsets.all(5),
                  ),
    
                  const SizedBox(width: 60),
    
                  IconButton(
                      icon: const Icon(
                        Icons.map_rounded,
                        size: 40,
                    ),
                    onPressed: (){
                      globalEmptyFunctionDialog(context, 'Sajnos a térkép még egy nem elérhető funkció az applikációban.', 'Nem elérhető funkció!');
                    },
                    padding: const EdgeInsets.all(5),
                  ),
    
                  IconButton(
                      icon: const Icon(
                        Icons.water,
                        size: 35,
                    ),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RSSWater()),
                      );
                    },
                    padding: const EdgeInsets.all(5),
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