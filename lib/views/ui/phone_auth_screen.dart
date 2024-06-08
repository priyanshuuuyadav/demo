import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:untitled1/controllers/phone_auth.dart';

class PhoneAuthScreen extends StatelessWidget {
  PhoneAuthScreen({super.key});

  TextEditingController number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/image/phone.png",
              height: Get.height * 0.4,
              width: Get.width * .9,
            ),
            TextFormField(
              controller: number,
              decoration: InputDecoration(
                label: Text("Enter your number"),
                suffixIcon: Icon(Icons.phone),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  AuthServices.sendOtp(number.text, context);
                },
                child: const Text('Send Otp'))
          ],
        ),
      ),
    );
  }
}
