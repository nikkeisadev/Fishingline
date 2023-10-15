import 'package:fishingline/components/buttonentry.dart';
import 'package:fishingline/components/logintiles.dart';
import 'package:flutter/material.dart';
import '../components/textfield.dart';

class Login extends StatelessWidget{
  Login({super.key});

  //Text controlling section.
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //Logging user in.
  void signIn() {}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: 
          Center(
            child: Column(children: [
              //Logo.
              const SizedBox(height: 50),

              const Icon(
                Icons.lock,
                size: 100,
              ),

              const SizedBox(height: 50),
              //Welcome back text.
              Text(
                'Üdvözöllek a Fishingline applikációjában!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16
                ),
              ),  

              const SizedBox(height: 50),
              
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Elfelejtetted a jelszavadat?',
                      style: TextStyle(color: Colors.grey[600]),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness:  0.5,
                        color: Colors.grey[400]
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'vagy használj',
                        style: TextStyle(
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness:  0.5,
                        color: Colors.grey[400]
                      ),
                    ),
                  ],
              
                ),
              ),

              const SizedBox(height: 25),

              //Registration option.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(
                  'Nincsen fiókod?',
                  style: TextStyle(color: Colors.grey[700]),
                  ),
                const SizedBox(width: 4),
                const Text(
                  'Regisztrálj most!',
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
              ],),
            ],
                  ),
          ),
      ),
    );
  }
}