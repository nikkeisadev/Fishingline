import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class BackendQueryDemo extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final String? uid = FirebaseAuth.instance.currentUser?.uid;

  final DatabaseReference ref =
      FirebaseDatabase(databaseURL: 'https://fishingline-97515.firebasedatabase.app',)
          .reference()
          .child('catches');

  void fetchDataFromFirebase() async {
    print(FirebaseAuth.instance.currentUser);
    try {
      DatabaseEvent event = await ref.once();
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic>? data = snapshot.value as Map<dynamic, dynamic>?;

        if (data != null) {
          data.forEach((key, value) {
            var description = value['description'];
            var date = value['date'];
            var location = value['location'];
            var size = value['size'];
            var userid = value['userid'];
            var weight = value['weight'];

            print(
                '\nCatch for $userid from backend:\n $description \n $location \n $weight \n $size \n $date\n');
          });
        }
      } else {
        print('No documents found in Firebase.');
      }
    } catch (e) {
      print('Error retrieving data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Button Example'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Fetch Data'),
          onPressed: () {
            fetchDataFromFirebase();
          },
        ),
      ),
    );
  }
}