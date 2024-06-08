import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/views/ui/details_screen.dart';
import 'package:untitled1/views/ui/my_home_page.dart';
import 'package:untitled1/views/ui/phone_auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () async {
      var currentUserId = FirebaseAuth.instance.currentUser?.uid;
      var currentUser = await FirebaseDatabase.instance
          .ref()
          .child("users/$currentUserId")
          .get();
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  currentUser.exists ? MyHomePage() : DetailsScreen(),
            ));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PhoneAuthScreen(),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(
          Icons.auto_awesome_mosaic_outlined,
          size: 50,
          color: Colors.lightBlueAccent,
        ),
      ),
    );
  }
}
