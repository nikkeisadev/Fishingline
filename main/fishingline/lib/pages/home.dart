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
      body: Container(
        child: Text(
          "Logged in as: " + user.uid,
          style: TextStyle(color: Colors.white),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 0, 34, 68),
        foregroundColor: const Color.fromARGB(255, 255, 187, 0),
      child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: const Color.fromARGB(255, 0, 34, 68),
        child: IconTheme(
          data: const IconThemeData(
            color: const Color.fromARGB(255, 255, 187, 0)),
          child: Padding(
            padding: const EdgeInsets.all(12.0), 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                IconButton(
                    icon: const Icon(
                      Icons.logout,
                      size: 30,
                  ),
                  onPressed: signUserOut,
                ),

                IconButton(
                    icon: const Icon(
                      Icons.home,
                      size: 30,
                  ),
                  onPressed: (){},
                ),

                IconButton(
                    icon: const Icon(
                      Icons.settings,
                      size: 30,
                  ),
                  onPressed: (){},
                ),

                IconButton(
                    icon: const Icon(
                      Icons.person,
                      size: 30,
                  ),
                  onPressed: (){},
                ),
              ],
            )
          ),
        ),
      ),   
    );
  }
}