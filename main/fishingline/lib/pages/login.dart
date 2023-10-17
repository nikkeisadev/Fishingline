import 'package:fishingline/components/buttonentry.dart';
import 'package:fishingline/components/logintiles.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import '../components/textfield.dart';
import 'package:wave/wave.dart';

class Login extends StatelessWidget{
  Login({super.key});

  //Text controlling section.
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

static const _backgroundColor = Color(0xFFF15BB5);

static const _colors = [
    Color(0xFFFEE440),
    Color(0xFF00BBF9),
];

static const _durations = [
    5000,
    4000,
];

static const _heightPercentages = [
    0.65,
    0.66,
];
  //Logging user in.
  void signIn() {}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromRGBO(13, 50, 87, 1),
      body: Container(
         decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/login_background_2.png"),
                fit: BoxFit.cover,
              )
            ),
        child: 
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              //Logo.
              const SizedBox(height: 50),

              Image.asset(
                'lib/images/fishingline_logo.png',
                width: 200,
                ),

              const SizedBox(height: 60),
              //Welcome back text.
              const Text(
                'Üdvözöllek! Kérlek jelentkez be!',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 18,
                ),
              ),  

              const SizedBox(height: 10),
              
              //Username textfield.
              UserTextField(
                controller: usernameController,
                hintText: 'Felhasználónév, vagy email cím:',
                obscureText: false, //We don't need to hide the username.
              ),

              const SizedBox(height: 10),
              
              //Password textfield.
              UserTextField(
                controller: passwordController,
                hintText: 'Jelszó:',
                obscureText: true, //We have to hide the password.
              ),

              const SizedBox(height: 10),

              //Forgot password.
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Elfelejtetted a jelszavadat?',
                      style: TextStyle(color:Color.fromARGB(255, 255, 255, 255)),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              //Continue with [options]...
              ButtonEntry(
                onTap: signIn,
              ),

              const SizedBox(height: 25),

              //Google + Apple sign in options.
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness:  0.5,
                        color: Color.fromARGB(255, 255, 255, 255)
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'vagy használj',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 200, 18),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness:  0.5,
                        color: Color.fromARGB(255, 255, 255, 255)
                      ),
                    ),
                  ],
              
                ),
              ),

              const SizedBox(height: 25),

              //Registration option.
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Google
                  LoginTiles(
                    imagePath: 'lib/images/google.png',
                  ),

                  SizedBox(width: 25),
                  //Apple
                  LoginTiles(
                    imagePath: 'lib/images/apple.png',
                  ),
                ],
              ),

              const SizedBox(height: 25),

              //Forgot password.
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(
                  'Nincsen fiókod?',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    ),
                  ),
                SizedBox(width: 4),
                Text(
                  'Regisztrálj most!',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 200, 18), 
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    ),
                  ),
              ],),
            ],
                  ),
          ),
      ),
    );
  }
}