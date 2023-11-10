
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishingline/pages/weather.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
        iconTheme: const IconThemeData(
          size: 40,
          color: Color.fromARGB(255, 255, 187, 0), //change your color here
          ),
        titleSpacing: 10,
        toolbarHeight: 75,
        title: Image.asset(
          'lib/images/fishingline_logo.png',
          width: 120,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Profile',
              onPressed: () {
                // handle the press
              },
            ),
          ),
        ],
      ),
      body: 
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/home_background.png"),
                fit: BoxFit.cover,
              )
        ),
        child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: const Color.fromARGB(255, 0, 34, 68),
          ),
          height: 120,
          child: 
            Row(
            children: [
              Lottie.asset(
                "lib/animations/WeatherReport.json",
                width: 100),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Horgászni van kedved?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                    Text('Nézd meg a mai időjárást!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 20),),
                    TextButton(
                      onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WeatherPage()),
                       );
                      },
                      child: 
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: const Color.fromARGB(255, 255, 187, 0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Megtekintés',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              )
                            ),
                          ),
                        ),
                    )
                  ]              
                ),
              )
            ],
          ),
        ),

        const SizedBox(height: 10),
        
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: const Color.fromARGB(255, 0, 34, 68),
          ),
          height: 70,
          child: 
            Row(
            children: [
              Lottie.asset(
                "lib/animations/Checkmark.json",
                width: 100),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Nincsen probléma!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                    Text('Megfelelő az időjárás.', style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 20),),
                    const SizedBox(height: 10),
                  ]              
                ),
              )
            ],
          ),
        ),

      ]
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
                      Icons.cloud,
                      size: 40,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WeatherPage()),
                    );
                  },
                  padding: const EdgeInsets.all(5),
                ),

                const SizedBox(width: 60),

                IconButton(
                    icon: const Icon(
                      Icons.map_rounded,
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