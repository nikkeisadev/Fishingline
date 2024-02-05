import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishingline/pages/sidebar/informations.dart';
import 'package:fishingline/pages/sidebar/settings.dart';
import 'package:fishingline/services/webview/facebook.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactsSidePage extends StatefulWidget {
  const ContactsSidePage({super.key});

  @override
  State<ContactsSidePage> createState() => _ContactsSidePage();
}

class _ContactsSidePage extends State<ContactsSidePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  final user = FirebaseAuth.instance.currentUser!;
  User? userForProfile = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  void runFacebook() {
    openFacebook(context);
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
              leading: Icon(Icons.contacts, size: 30, color: Color.fromARGB(255, 255, 187, 0)),
              title: Text('Elérhetőségek', style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 255, 187, 0))),
              onTap: () {},
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
                  image: AssetImage("lib/images/home_background.png"),
                  fit: BoxFit.cover,
                ),
              ),
          child: Center(
            child: Column( 
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('lib/animations/Contacts.json',width: 230),
                SizedBox(height: 50),
                Text(
                    "Elérhetőségeink",
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
                SizedBox(height: 25),
                Text(
                  'Kérdésed van? Itt elérsz minket!',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 5),
                Divider(
                    thickness: 2,
                    color: const Color.fromARGB(255, 255, 187, 0),
                    indent: 110,
                    endIndent: 110,
                ),
                SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.email, color: Color.fromARGB(255, 255, 187, 0),),
                      SizedBox(width: 10),
                      Text(
                        'info@fishingline.hu',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, color: Color.fromARGB(255, 255, 187, 0),),
                      SizedBox(width: 10),
                      Text(
                        '+36 20 000 0000',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.house, color: Color.fromARGB(255, 255, 187, 0),),
                      SizedBox(width: 10),
                      Text(
                        'Debrecen, Bethlen u. 1-9, 4000',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: const Color.fromARGB(255, 255, 187, 0),
                        indent: 100,
                        endIndent: 10,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Médiák',
                        style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 255, 187, 0), fontWeight: FontWeight.w500),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 2,
                        color: const Color.fromARGB(255, 255, 187, 0),
                        indent: 10,
                        endIndent: 100,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.facebook, color: Color.fromARGB(255, 255, 187, 0)),
                      SizedBox(width: 10),
                      Text(
                        'Fishingline',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesomeIcons.instagram,
                        color: Color.fromARGB(255, 255, 187, 0),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '@fishingline',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 30),
              ],
            ),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '',
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