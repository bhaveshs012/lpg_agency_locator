import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lpg_agency_locator/views/homeScreen/homescreen.dart';
import 'package:lpg_agency_locator/views/loginScreen/login_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.blue));
          } else if (snapshot.hasData) {
            var _userRef = FirebaseFirestore.instance
                .collection('users')
                .doc(snapshot.data!.uid);
            _userRef.get().then((value) {
              if (!value.exists) {
                _userRef.set({
                  'name': snapshot.data!.displayName,
                  'email': snapshot.data!.email,
                  'id': snapshot.data!.uid,
                  'imageUrl': snapshot.data!.photoURL,
                });
              }
            });
            return const HomeScreen();
          } else if (snapshot.hasError) {
            //implement error screen
            print("error");
            return const Center(child: Text("Error"));
          } else {
            print("user not logged in");
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
