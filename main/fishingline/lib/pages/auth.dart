import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishingline/pages/home.dart';
import 'package:fishingline/pages/loginregister.dart';
import 'package:flutter/material.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream:  FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          //When the user is logged in.
          if (snapshot.hasData){
            return HomeScreen();
          }
          //When the user don't logged in.
          else {
            return const LoginOrRegister();
          }
          
        }
      )
    );
  }
}