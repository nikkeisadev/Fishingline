import 'package:fishingline/components/textfield.dart';
import 'package:fishingline/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationCompleted extends StatefulWidget{
    //Registration
  final Function()? onTap;
  const RegistrationCompleted({super.key, required this.onTap});

  @override
  State<RegistrationCompleted> createState() => _RegistrationCompletedState();
}

class _RegistrationCompletedState extends State<RegistrationCompleted> {

  final clientUserName = TextEditingController(text: '');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? userForProfile = FirebaseAuth.instance.currentUser;

  void getUsername() async {
    print(userForProfile!.uid);
    await userForProfile!.updateProfile(displayName: clientUserName.text);
  }

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
              const SizedBox(height: 40),
              Lottie.asset('lib/animations/Completed.json'),
              const SizedBox(height: 70),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Regisztráltál!',
                    style: TextStyle(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Divider(
                  thickness: 2,
                  color: const Color.fromARGB(255, 255, 187, 0),
                  indent: 80,
                  endIndent: 80,
              ),

              const SizedBox(height: 10),
              
              //Repeat password textfield.
              UserTextField(
                iconName: Icons.account_box,
                controller: clientUserName,
                hintText: 'Felhasználónév: ',
                obscureText: false, //We have to hide the password.
              ),

              const SizedBox(height: 20),

              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text("Sikeresen regisztráltál a Fishinglineba!\nNyomd meg a tovább gombot, és készen is állsz az app használatára!",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
      const SizedBox(height: 20),
      GestureDetector(
      onTap: (){
        getUsername();
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(17),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          image: const DecorationImage(
           image: AssetImage(
           "lib/images/button_background.png"
           ), 
           fit:BoxFit.cover
         ),
         
          color: const Color.fromARGB(255, 255, 187, 0),
          borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Text(
            'Tovább',
            style: const TextStyle(
              color: Colors.white, 
              fontWeight: FontWeight.bold, 
              fontSize: 20
            ),
          ),
        ),
      ),
    ),

            ],
          ),
        ),
      ),
    );
  }
}