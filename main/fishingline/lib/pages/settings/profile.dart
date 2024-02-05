import 'dart:async';
import 'package:fishingline/pages/sidebar/contacts.dart';
import 'package:fishingline/pages/sidebar/informations.dart';
import 'package:fishingline/pages/sidebar/settings.dart';
import 'package:flutter/material.dart';
import 'package:fishingline/services/webview/facebook.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettings();
}

class _ProfileSettings extends State<ProfileSettings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  
  Timer? _timer;
  String imageUrl = " ";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? userForProfile = FirebaseAuth.instance.currentUser;

  Future<void> setPhotoUri(String photoUri) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.updateProfile(photoURL: photoUri);
      setState(() {
        userForProfile = FirebaseAuth.instance.currentUser;
      });
    }
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

  void runFacebook() {
    openFacebook(context);
  }

  void pickUploadImage() async {
    final image = await ImagePicker().pickImage(
      source:
        ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75,
      );

      Reference ref = FirebaseStorage.instance.ref().child(userForProfile!.uid + '.jpg');

      await ref.putFile(File(image!.path));
      ref.getDownloadURL().then((value) {
        print('############################' + value);
        FirebaseAuth.instance.currentUser!.updatePhotoURL(value);
        setState(() {
          userForProfile = FirebaseAuth.instance.currentUser;
        });
      });
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
                MaterialPageRoute(builder: (context) => const InformationsSidePage()),
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
        body: Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/images/home_background.png"),
                  fit: BoxFit.cover,
                )
          ),
          child: Column(
              children:[
                  GestureDetector(
                    onTap: () {
                      pickUploadImage();
                    },
                    child: Center(
                      child: FirebaseAuth.instance.currentUser!.photoURL.toString() == "" ? Container(
                        child: Image.asset('lib/images/default_profile.png', width: 80),
                      ) : Column(
                        children: [
                          CircleAvatar(
                                backgroundColor: const Color.fromARGB(255, 255, 187, 0),
                                backgroundImage: NetworkImage(userForProfile!.photoURL.toString()),
                                radius: 50.0,
                              ),
                              
                        ],
                      )
                    ),
                  ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}