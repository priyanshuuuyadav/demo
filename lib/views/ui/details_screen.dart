import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled1/controllers/realtime_db.dart';
import 'package:untitled1/models/add_user.dart';
import 'package:untitled1/views/ui/my_home_page.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController email = TextEditingController();
  File? _image;
  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Photo Gallery'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              Navigator.of(context).pop();
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  Future<void> uploadFile() async {
    String fileName = 'images/${FirebaseAuth.instance.currentUser?.uid}.png';
    try {
      final storageRef = FirebaseStorage.instance.ref().child(fileName);
      await storageRef.putFile(_image!);

      String downloadURL = await storageRef.getDownloadURL();

      await RealTimeDBServices.addUser(AddUserModel(
        image: downloadURL,
        email: email.text,
        name: name.text,
        phone: FirebaseAuth.instance.currentUser?.phoneNumber,
      ));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File uploaded successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload file: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  _image == null
                      ? Image.asset(
                    "assets/image/uservip.png",
                    height: Get.height * 0.2,
                    width: Get.width * 0.4,
                  )
                      : CircleAvatar(
                    radius: Get.height * 0.093,
                    backgroundImage: FileImage(
                      _image!,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.teal,),
                      child: IconButton(
                        onPressed: showOptions,
                        icon: Icon(Icons.camera_alt, color: Colors.white,),
                      ),
                    ),)
                ],
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  label: Text("Enter your name"),
                  suffixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: email,
                decoration: const InputDecoration(
                  label: Text("Enter your email"),
                  suffixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: address,
                decoration: const InputDecoration(
                  label: Text("Enter your address"),
                  suffixIcon: Icon(Icons.home),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_image != null) {
                    uploadFile();
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(s)
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
