import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishingline/components/buttonentry.dart';
import 'package:fishingline/components/logintiles.dart';
import 'package:flutter/material.dart';
import '../components/textfield.dart';

class Register extends StatefulWidget{
    //Registration
  final Function()? onTap;
  const Register({super.key, required this.onTap});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Text controlling section.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmedPasswordController = TextEditingController();
  //Logging user up.
  void signUp() async {
    //Loading circle.
    //Try creating the account.
    try {
      //Check if the passwords match.
      if (passwordController.text == confirmedPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, 
          password: passwordController.text
        );
      } else {
        print("The password don't match at all! ");
        registerErrorDialog("A jelszavak amiket megadtál nem egyeznek meg! Próbáld meg újra.", "Nem egyezik meg a jelszavad!");
        //Destroying the Loading animation.
      }
      //Destroying the Loading animation.
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        registerErrorDialog("Az email cím amit beírtál nem megfelelő! A Helyes email cím formátum, példa: ilovefishing@gmail.com.", "Nem megfelelő email cím!");
      } else if (e.code == 'channel-error') {
        registerErrorDialog("Valamit kihagytál, vagy hibásan adtál meg a regisztrációnál! Kérlek próbáld újra.", "Hibás adatok!");
      } else {
        registerErrorDialog("Error code in application while communicating with server...", "Awkward... ＞﹏＜");
      }
      //Login issue debugger:
    }
  }

  //Wrong email notification.
  void registerErrorDialog(String message, title) {
    showDialog<void>(
    context: context, 
    builder: (context) {
      return AlertDialog(
        backgroundColor: const Color.fromRGBO(13, 50, 87, 1),
        title: Text(title),
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
        actions: [
            ElevatedButton(onPressed: () {
            Navigator.of(context).pop();
          }, 
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 160, 18),
          ), 
          child: 
          const Text(
            "Oké!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ),
          ],
          contentTextStyle: const TextStyle(
            fontSize: 20,
          ),
          content: Text(message),
        );
      },
    );
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
              const SizedBox(height: 60),

              Image.asset(
                'lib/images/fishingline_logo.png',
                width: 200,
                ),

              const SizedBox(height: 60),
              //Welcome back text.
              const Text(
                'Regisztrálj be email címeddel!',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                ),
              ),
              
              const Text(
                'Jelszavadat erősítsd meg!',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 14,
                ),
              ),  

              const SizedBox(height: 10),
              
              //Username textfield.
              UserTextField(
                iconName: Icons.email,
                controller: emailController,
                hintText: 'Email cím:',
                obscureText: false, //We don't need to hide the username.
              ),

              const SizedBox(height: 10),
              
              //Password textfield.
              UserTextField(
                iconName: Icons.password,
                controller: passwordController,
                hintText: 'Jelszó:',
                obscureText: true, //We have to hide the password.
              ),

              const SizedBox(height: 10),
              
              //Repeat password textfield.
              UserTextField(
                iconName: Icons.password,
                controller: confirmedPasswordController,
                hintText: 'Ismételd meg jelszavadat:',
                obscureText: true, //We have to hide the password.
              ),

              const SizedBox(height: 25),

              //Continue with [options]...
              ButtonEntry(
                onTap: signUp,
                text: "Regisztrálás",
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Google
                  LoginTiles(
                    onTap: () {},
                    imagePath: 'lib/images/google.png',
                  ),

                  const SizedBox(width: 25),
                  //Apple
                  LoginTiles(
                    onTap: () {},
                    imagePath: 'lib/images/apple.png',
                  ),
                ],
              ),

              const SizedBox(height: 25),

              //Forgot password.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const Text(
                  'Van már fiókod?',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    ),
                  ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Jelentkezz be!',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 200, 18), 
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      ),
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