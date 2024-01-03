import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishingline/pages/sidebar/contacts.dart';
import 'package:fishingline/pages/sidebar/settings.dart';
import 'package:flutter/material.dart';
import 'package:fishingline/services/webview/facebook.dart';

class InformationsSidePage extends StatefulWidget {
  const InformationsSidePage({super.key});

  @override
  State<InformationsSidePage> createState() => _InformationsSidePage();
}

class _InformationsSidePage extends State<InformationsSidePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final user = FirebaseAuth.instance.currentUser!;
  User? userForProfile = FirebaseAuth.instance.currentUser;
  
  @override
  void initState() {
    super.initState();
  }

  void runFacebook() {
    openFacebook(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
      padding: const EdgeInsets.all(10.0),
      child: IconButton(
        icon: const Icon(Icons.menu),
        tooltip: 'Menü',
        onPressed: (){_scaffoldKey.currentState?.openEndDrawer();}, // Call the void function here
      ),
    ),
  ],
),
endDrawer: Drawer(
      child: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/images/login_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Column(
            children: [
              const SizedBox(height: 40),
              Container(
                alignment: Alignment.center,
                height: 130,
                child: Image.asset(
                  'lib/images/logo_sidebar.png',
                  width: 200,
                  height: 200,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),

          Row(
            children: [

              SizedBox(width: 10),

              CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 255, 187, 0),
                backgroundImage: NetworkImage(userForProfile!.photoURL.toString()),
                radius: 25.0,
              ),

              SizedBox(width: 10),

              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userForProfile!.displayName.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 21,
                        ),
                      ),
                      Text(
                        userForProfile!.email.toString(),
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 160, 18),
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 10),

          ListTile(
            leading: Icon(Icons.settings, size: 30, color: Color.fromARGB(255, 255, 187, 0),),
            title: Text('Beállítások', style: TextStyle(fontSize: 15, color: Colors.white)),
            onTap: () { 
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.contacts, size: 30, color: Color.fromARGB(255, 255, 187, 0),),
            title: Text('Elérhetőségek', style: TextStyle(fontSize: 15, color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactsSidePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info, size: 30, color: Color.fromARGB(255, 255, 187, 0),),
            title: Text('Információk', style: TextStyle(fontSize: 15, color: Colors.white)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InformationsSidePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.web, size: 30, color: Color.fromARGB(255, 255, 187, 0)),
            title: Text('Weboldal', style: TextStyle(fontSize: 15, color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.facebook, size: 30, color: Color.fromARGB(255, 255, 187, 0),),
            title: Text('Facebook', style: TextStyle(fontSize: 15, color: Colors.white)),
            onTap: () {
              runFacebook();
            },
          ),
          Expanded(
            child: Divider(
              thickness:  0.5,
              color: Color.fromARGB(0, 255, 255, 255)
            ),
          ),
          Text('''
    Fishingline 2023-2024 Verzió: 1.2.8
    Fejlesztette: nikkeisadev.
          ''', style: TextStyle(fontSize: 15, color: Colors.white)),
        ],
      ),
      ),
    ),
      body: Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/images/home_background.png"),
                fit: BoxFit.cover,
              )
        ),
        child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 30,
                  color: const Color.fromARGB(255, 0, 34, 68),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.info, color: Color.fromARGB(255, 255, 187, 0)),
                      const SizedBox(width: 8),
                      Text('Információk', style: TextStyle(color: Color.fromARGB(255, 255, 187, 0), fontWeight: FontWeight.w600, fontSize: 17)),
                    ],
                  ),
                ),
                  SizedBox(height: 15),
            
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Fishingline', style: TextStyle(color: Color.fromARGB(255, 255, 187, 0), fontSize: 23, fontWeight: FontWeight.w500),
                    ),
                  ),
            
                  SizedBox(height: 15),
            
                  Text('''A Fishingline egy naplóalkalmazás horgászok számára. Lehetővé teszi, hogy fogásaidat elmentsd, és azokat megoszd másokkal. Lehetőséget biztosít a megfelelő horgászhely megtalálásához, és hasznos információkkal is ellátja a felhasználót.''', style: TextStyle(color: Colors.white, fontSize: 18)),
                  
                  SizedBox(height: 30),
            
                   Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Adatvédelmi nyilatkozat', style: TextStyle(color: Color.fromARGB(255, 255, 187, 0), fontSize: 23, fontWeight: FontWeight.w500),
                    ),
                  ),
            
                  SizedBox(height: 15),
            
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('''A Fishingline egy naplóalkalmazás horgászok számára. Ez az adatvédelmi nyilatkozat magyarázza, hogyan gyűjtjük, használjuk és osztjuk meg a személyes adatait, amikor használja az alkalmazásunkat.

Az általunk gyűjtött információk
                    
Amikor a Fishingline-t használja, az alábbi típusú személyes adatokat gyűjthetjük:
Fiók információk: Amikor létrehoz egy fiókot, gyűjthetjük a nevét, e-mail címét és jelszavát.
Napló információk: Amikor a Fishingline-t használja a horgászati ​​utazások naplózására, gyűjthetünk információkat az utazás helyéről, dátumáról, időjárásáról és a halakról, amelyeket az utazás során fogott.
Eszköz információk: Gyűjthetünk információkat az eszközről, amellyel a Fishingline-hoz hozzáfér, ideértve az eszköz típusát, operációs rendszerét és IP-címét.
Hogyan használjuk az információit
Az általunk gyűjtött személyes adatokat az Fishingline biztosítására és javítására, Önnel való kommunikációra és az élmény személyre szabására használjuk. Konkrétan az információit a következőkre használhatjuk:
Az Fishingline biztosítása és javítása: Az információit az Fishingline biztosítására és javítására használjuk, ideértve az élmény személyre szabását és az új funkciók kifejlesztését.
Kommunikáció Önnel: Az információit arra használhatjuk, hogy kommunikáljunk Önnel az Fishingline-ról, ideértve az frissítések és értesítések küldését.
Az élmény személyre szabása: Az információit arra használhatjuk, hogy személyre szabjuk az Fishingline élményét, ideértve a horgászhelyek és felszerelések ajánlását.

Információk megosztása
Az Ön személyes adatait nem osztjuk meg harmadik felekkel, kivéve, ha az ebben az Adatvédelmi Nyilatkozatban leírtak szerint vagy az Ön beleegyezésével történik. Konkrétan az információit az alábbiak szerint oszthatjuk meg:
Szolgáltatók: Az információit olyan szolgáltatókkal oszthatjuk meg, akik szolgáltatásokat végeznek helyettünk, például hosting szolgáltatókkal és fizetési feldolgozókkal.
Jogi megfelelés: Az információit megoszthatjuk az alkalmazandó törvények és rendeletek betartása érdekében, hogy válaszoljunk egy előzetes megkeresésre, vagy hogy megvédjük jogainkat.
Az Ön választásai
Választhatja, hogy bizonyos információkat ne adjon meg nekünk, de ez korlátozhatja a Fishingline használatának képességét. 
                    ''', style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                  
                  SizedBox(height: 30),
                  
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Szolgáltatási Feltételek', style: TextStyle(color: Color.fromARGB(255, 255, 187, 0), fontSize: 23, fontWeight: FontWeight.w500),
                    ),
                  ),
                  
                  SizedBox(height: 15),
                  
            
                  Text('''Terms
By accessing this Website, accessible from https://fishingline.app, you are agreeing to be bound by these Website Terms and Conditions of Use and agree that you are responsible for the agreement with any applicable local laws. If you disagree with any of these terms, you are prohibited from accessing this site. The materials contained in this Website are protected by copyright and trade mark law.
            
Use License
Permission is granted to temporarily download one copy of the materials on Fishingline's Website for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title, and under this license you may not:
modify or copy the materials;
use the materials for any commercial purpose or for any public display;
attempt to reverse engineer any software contained on Fishingline's Website;
remove any copyright or other proprietary notations from the materials; or
transferring the materials to another person or "mirror" the materials on any other server.
This will let Fishingline to terminate upon violations of any of these restrictions. Upon termination, your viewing right will also be terminated and you should destroy any downloaded materials in your possession whether it is printed or electronic format. These Terms of Service has been created with the help of the Terms Of Service Generator.
            
Disclaimer
All the materials on Fishingline's Website are provided "as is". Fishingline makes no warranties, may it be expressed or implied, therefore negates all other warranties. Furthermore, Fishingline does not make any representations concerning the accuracy or reliability of the use of the materials on its Website or otherwise relating to such materials or any sites linked to this Website.
            
Limitations
Fishingline or its suppliers will not be hold accountable for any damages that will arise with the use or inability to use the materials on Fishingline's Website, even if Fishingline or an authorize representative of this Website has been notified, orally or written, of the possibility of such damage. Some jurisdiction does not allow limitations on implied warranties or limitations of liability for incidental damages, these limitations may not apply to you.
            
Revisions and Errata
The materials appearing on Fishingline's Website may include technical, typographical, or photographic errors. Fishingline will not promise that any of the materials in this Website are accurate, complete, or current. Fishingline may change the materials contained on its Website at any time without notice. Fishingline does not make any commitment to update the materials.
            
Links
Fishingline has not reviewed all of the sites linked to its Website and is not responsible for the contents of any such linked site. The presence of any link does not imply endorsement by Fishingline of the site. The use of any linked website is at the user's own risk.
            
Site Terms of Use Modifications
Fishingline may revise these Terms of Use for its Website at any time without prior notice. By using this Website, you are agreeing to be bound by the current version of these Terms and Conditions of Use.
            
Your Privacy
Please read our Privacy Policy.
            
Governing Law
Any claim related to Fishingline's Website shall be governed by the laws of hu without regards to its conflict of law provisions.
''', style: TextStyle(color: Colors.white, fontSize: 18)),
                  
                  SizedBox(height: 30),
                  
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Adatok forrása', style: TextStyle(color: Color.fromARGB(255, 255, 187, 0), fontSize: 23, fontWeight: FontWeight.w500),
                    ),
                  ),
                  
                  SizedBox(height: 15),
                  
                  Text('''Időjárás, előrejelzés: OpenWeather, https://openweathermap.org/
Vizállási adatok: www.vizugy.hu
                  ''', style: TextStyle(color: Colors.white, fontSize: 15)),
                  Container(
                    width: double.infinity,
                    height: 100,
                    color: Color.fromARGB(0, 0, 0, 0),
                    child: Image.asset('lib/images/nikkeisadev_logo_transparent.png', width: 200),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}