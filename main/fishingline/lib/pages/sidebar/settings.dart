import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishingline/pages/sidebar/contacts.dart';
import 'package:fishingline/pages/sidebar/informations.dart';
import 'package:fishingline/services/webview/facebook.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  bool _notificationsEnabled = true;
  String _selectedLanguage = 'Magyar';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
              title: Text('Beállítások', style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 255, 187, 0))),
              onTap: () {},
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
                  image: AssetImage("lib/images/home_background.png"),
                  fit: BoxFit.cover,
                ),
              ),
          child: ListView(
            children: [
              Center(
                child: Column( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: []
                ),
              ),
              SizedBox(height: 0),
              Container(
                width: 20,
                height: 30,
                color: const Color.fromARGB(255, 0, 34, 68),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.settings, color: Color.fromARGB(255, 255, 187, 0)),
                    const SizedBox(width: 8),
                    Text('Beállítások', style: TextStyle(color: Color.fromARGB(255, 255, 187, 0), fontWeight: FontWeight.w600, fontSize: 17)),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.notifications, color:Color.fromARGB(255, 255, 187, 0), size: 30),
                title: Text('Értesítések', style: TextStyle(color: Colors.white, fontSize: 20)),
                trailing: ElevatedButton.icon(
                  icon: _notificationsEnabled
                      ? Icon(Icons.notifications_active, color: Color.fromARGB(255, 255, 187, 0))
                      : Icon(Icons.notifications_off, color: Color.fromARGB(255, 255, 187, 0)),
                  label: Text(_notificationsEnabled
                      ? 'Bekapcsolva'
                      : 'Kikapcsolva', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    setState(() {
                      _notificationsEnabled = !_notificationsEnabled;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 0, 34, 68),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.language, color: Color.fromARGB(255, 255, 187, 0), size: 30),
                title: Text('Nyelv', style: TextStyle(color: Colors.white, fontSize: 20)),
                subtitle: Text('$_selectedLanguage', style: TextStyle(color: Colors.white)),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: const Color.fromRGBO(13, 50, 87, 1),
                        titleTextStyle: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
                        title: Text('Válassz nyelvet', style: TextStyle(color: Colors.white, fontSize: 25)),
                        content: DropdownButton<String>(
                                dropdownColor: Colors.orange,
                                value: _selectedLanguage,
                                items: <String>['Magyar']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value, style: TextStyle(color: Colors.white)),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    _selectedLanguage = value!;
                                  });
                                },
                              ),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 255, 187, 0),
                            ),
                            child: const Text(
                              "Kiválasztás",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person, color: const Color.fromARGB(255, 255, 187, 0), size: 30),
                title: Text('Profil beállítások', style: TextStyle(color: Colors.white, fontSize: 20)),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // TODO: Add profile settings page.
                },
              ),
              ListTile(
                leading: Icon(Icons.cached, color: Color.fromARGB(255, 255, 187, 0), size: 30),
                title: Text('Gyorsítótár törlése', style: TextStyle(color: Colors.white, fontSize: 20)),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // TODO: Add cache reset functionality.
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}