import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/phone_auth.dart';

class OtpVerificationScreen extends StatelessWidget {
  String otp;

  OtpVerificationScreen({super.key, required this.otp});

  TextEditingController smsOtp = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/image/check.png",
              height: Get.height * 0.4,
              width: Get.width * .9,
            ),
            TextFormField(
              controller: smsOtp,
              decoration: const InputDecoration(
                label: Text("Enter your smsOtp"),
                suffixIcon: Icon(Icons.local_attraction_outlined),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  AuthServices.otpVerification(context, otp, smsOtp.text);
                },
                child: const Text('Otp verification'))
          ],
        ),
      ),
    );
  }
}
