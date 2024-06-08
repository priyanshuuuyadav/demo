import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/controllers/realtime_db.dart';
import 'package:untitled1/models/add_user.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<DatabaseEvent>(
        stream: FirebaseDatabase.instance
            .ref()
            .child("users/${FirebaseAuth.instance.currentUser?.uid}")
            .onValue,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data?.snapshot.value != null) {
            Map<String, dynamic> data =
                Map<String, dynamic>.from(snapshot.data!.snapshot.value as Map);
            AddUserModel userData = AddUserModel.fromJson(data);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(userData.image ?? ""),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Id: ${FirebaseAuth.instance.currentUser?.uid}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Name: ${userData.name}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Email: ${userData.email}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Phone: ${userData.phone}',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return showUpdateDialog(
                            addUserModel: userData,
                            context: context,
                          );
                        },
                      );
                    },
                    child: Text("Update"),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text("No user data available"));
          }
        },
      ),
    );
  }

  Widget showUpdateDialog(
      {required AddUserModel addUserModel, required BuildContext context}) {
    name.text = addUserModel.name ?? "";
    email.text = addUserModel.email ?? "";
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        AlertDialog(
          content: Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10),
                  TextFormField(
                    controller: name,
                    decoration: const InputDecoration(
                      label: Text("Enter your name"),
                      icon: Icon(Icons.person),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      label: Text("Enter your email"),
                      icon: Icon(Icons.email),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      AddUserModel data = AddUserModel(
                        phone: addUserModel.phone,
                        email: email.text,
                        image: addUserModel.image,
                        name: name.text,
                      );
                      await RealTimeDBServices.updateUser(data);
                      Navigator.pop(context);
                      // setState(() {});
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
