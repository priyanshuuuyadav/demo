import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/views/ui/details_screen.dart';

import '../views/ui/otp_verify_screen.dart';

class AuthServices {
  static sendOtp(String number, BuildContext context) {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91$number",
      verificationCompleted: (c) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('otp sending')));
      },
      verificationFailed: (f) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('otp sending Failed')));
      },
      codeSent: (verificationId, forceResendingToken) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('otp sent')));
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => OtpVerificationScreen(otp: verificationId),));
      },
      codeAutoRetrievalTimeout: (v) {},
    );
  }

  static otpVerification(BuildContext context, String otp, String smsCode) {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: otp, smsCode: smsCode);
    FirebaseAuth.instance.signInWithCredential(credential).whenComplete(() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DetailsScreen(),));
    });
  }
}
