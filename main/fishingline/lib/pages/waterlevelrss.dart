import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishingline/pages/sidebar/contacts.dart';
import 'package:fishingline/pages/sidebar/informations.dart';
import 'package:fishingline/pages/sidebar/settings.dart';
import 'package:fishingline/services/webview/facebook.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dart_rss/dart_rss.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(RSSWater());
}

class RSSWater extends StatefulWidget {
  @override
  _RSSWaterState createState() => _RSSWaterState();
}

class _RSSWaterState extends State<RSSWater> {
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Widget> _screens = [
    RSSReaderWidget(),
    Placeholder(), // Replace with your other screens
    Placeholder(), // Replace with your other screens
  ];

  final user = FirebaseAuth.instance.currentUser!;
  User? userForProfile = FirebaseAuth.instance.currentUser;

  void runFacebook() {
    openFacebook(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 8,20,44),
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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/login_background_2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: _screens[_currentIndex],
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Az adatok forrása: www.vizugy.hu',
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

class RSSReaderWidget extends StatefulWidget {
  @override
  _RSSReaderWidgetState createState() => _RSSReaderWidgetState();
}

class _RSSReaderWidgetState extends State<RSSReaderWidget> {
  RssFeed? _rssFeed;

  @override
  void initState() {
    super.initState();
    fetchFeeds();
  }

  void fetchFeeds() async {
    final client = http.Client();

    // RSS feed
    final rssResponse =
        await client.get(Uri.parse('https://www.vizugy.hu/rss/?type=1'));
    final rssBodyString = rssResponse.body;

    final channel = RssFeed.parse(rssBodyString);
    setState(() {
      _rssFeed = channel;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_rssFeed == null) {
      return Center(child: Lottie.asset('lib/animations/LoadingAnimation.json', width: 200),);
    }

    return ListView.builder(
  itemCount: _rssFeed!.items.length,
  itemBuilder: (BuildContext context, int index) {
    final item = _rssFeed!.items[index];

    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(85, 0, 0, 0),
        borderRadius: BorderRadius.circular(0),
      ),
      child: ListTile(
        title: Text(item.title!, style: TextStyle(color: Colors.white, fontSize: 20)),
        subtitle: Text(item.pubDate!, style: TextStyle(color: Colors.white)),
      ),
    );
  },
);
  }
}