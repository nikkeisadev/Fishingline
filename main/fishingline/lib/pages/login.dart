import 'package:flutter/material.dart';

class Login extends StatelessWidget{
  const Login({super.key});

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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                  ),
                ),
              ),
                  
              //Password textfield.
                  
              //Forgot password.
                  
              //Continue with [options]...
                  
              //Google + Apple sign in options.
                  
              //Registration option.
                  
                  
            ],
                  ),
          ),
      ),
    );
  }
}