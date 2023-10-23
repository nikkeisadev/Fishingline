import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});

  //User, and Current User values.
  final user = FirebaseAuth.instance.currentUser!;

  //Sign the user out of Fishingline.
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 34, 68),
        centerTitle: true,
        titleSpacing: 10,
        toolbarHeight: 75,
        title: Image.asset(
          'lib/images/fishingline_logo.png',
          width: 120,  
        ),
      ),
      body: 
      Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Logged in with UID: " + user.uid,
                  style: TextStyle(
                  color: Colors.white, 
                  fontWeight: FontWeight.bold
                  ),
              )
            ],
          )
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/home_background.png"),
                fit: BoxFit.cover,
              )
        ),
      ),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 0, 34, 68),
        foregroundColor: const Color.fromARGB(255, 255, 187, 0),
      child: Image.asset(
          'lib/images/add_catch.png',
          width: 70,
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

                IconButton(
                    icon: const Icon(
                      Icons.logout,
                      size: 35,
                  ),
                  onPressed: signUserOut,
                  padding: const EdgeInsets.all(20),
                ),

                IconButton(
                    icon: const Icon(
                      Icons.home,
                      size: 40,
                  ),
                  onPressed: (){},
                  padding: const EdgeInsets.all(5),
                ),

                const SizedBox(width: 60),

                IconButton(
                    icon: const Icon(
                      Icons.settings,
                      size: 40,
                  ),
                  onPressed: (){},
                  padding: const EdgeInsets.all(5),
                ),

                IconButton(
                    icon: const Icon(
                      Icons.person,
                      size: 35,
                  ),
                  onPressed: (){},
                  padding: const EdgeInsets.all(20),
                ),
              ],
            )
          ),
        ),
      ),   
    );
  }
}