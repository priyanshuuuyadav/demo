import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/views/ui/home/profile_screen.dart';
import 'package:untitled1/views/ui/phone_auth_screen.dart';

import 'home/home_screen.dart';
import 'home/object_screen.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PhoneAuthScreen(),
                    ));
              },
              icon: Icon(Icons.logout, color: Colors.cyan,))
        ],
      ),
      body: [
        HomeScreen(),
        RazorPayScreen(),
        ProfileScreen()
      ][currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        unselectedItemColor: Colors.lightBlueAccent,
        selectedItemColor: Colors.black26,
        elevation: 0,
        backgroundColor: Colors.teal,
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.data_object_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "")
        ],
      ),
    );
  }
}
