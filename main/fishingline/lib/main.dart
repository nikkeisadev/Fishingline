import 'package:fishingline/pages/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';
import 'firebase_options.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color.fromARGB(255, 255, 166, 0)),
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Image.asset(
            "lib/images/fishingline_logo.png",
            width: 200,
          ),
          const SizedBox(height: 53),
          Lottie.asset('lib/animations/SplashScreenFish.json', width: 300),
        ],
      ),
      nextScreen: const Auth(),
      backgroundColor: const Color.fromRGBO(13, 50, 87, 1),
      duration: 3000,
      animationDuration: const Duration(seconds: 2),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}