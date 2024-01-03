import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishingline/components/buttonentry.dart';
import 'package:fishingline/components/logintiles.dart';
import 'package:fishingline/resources/auth_service.dart';
import 'package:flutter/material.dart';
import '../components/textfield.dart';

class Login extends StatefulWidget{
    //Registration
  final Function()? onTap;
  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Text controlling section.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //Logging user in.
  void signIn() async {
    try {
      if (emailController.text == "") {
        loginErrorDialog("Nem adtál meg email címet, ez szükséges a bejelentkezéshez!", "Nem adtál meg email címet!");
      } else if (passwordController.text == "") {
        loginErrorDialog("Nem adtál meg jelszót, ez szükséges a bejelentkezéshez!", "Nem adtál meg jelszót!");
      } else {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, 
          password: passwordController.text
        );
        print(FirebaseAuth.instance.currentUser?.uid);
      }
    } on FirebaseAuthException catch (e) {
      //Wrong email from user.
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        loginErrorDialog("Helytelen jelszót, vagy email címet adtál meg! Kérlek próbáld újra!", "Hibás jelszó, vagy email cím!");
      } else if (e.code == 'too-many-requests') {
        loginErrorDialog("Sajnos sokszor próbálkoztál helytelen adatokkal belépni! Kérlek próbáld újra később, vagy készíts új jelszót!", "Sok probálkozás!");
      } else if (e.code == 'invalid-email') {
        loginErrorDialog("Az email cím amit beírtál nem megfelelő! A Helyes email cím formátum, példa: ilovefishing@gmail.com.", "Nem megfelelő email cím!");
      } else {
        loginErrorDialog("Error code in application while communicating with server...", "Awkward... ＞﹏＜");
      }
      //Login issue debugger:
    }
  }

  //Wrong email notification.
  void loginErrorDialog(String message, title) {
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
                image: AssetImage("lib/images/login_background.png"),
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

              Image.asset(
                'lib/images/fishingline_logo.png',
                width: 200,
                ),

              const SizedBox(height: 60),
              //Welcome back text.
              const Text(
                'Üdvözöllek! Kérlek jelentkezz be!',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                ),
              ),  

              const Text(
                'Használd email címedet, és jelszavadat!',
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 14,
                ),
              ),  

              const SizedBox(height: 20),
              
              //Email textfield.
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
                text: "Bejelentkezés",
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
                    onTap: () => AuthService().signInWithGoogle(),
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
                  'Nincsen fiókod?',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    ),
                  ),
                const SizedBox(width: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    'Regisztrálj most!',
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