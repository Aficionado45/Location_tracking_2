// Importing packages
import 'package:flutter/material.dart';

// Importing Firebase Packages
import 'package:firebase_auth/firebase_auth.dart';

// Importing Screens
import 'package:location_tracking_2/screens/login_screen.dart';

// Function to authenticate and sign in users using mobile number
Future<bool> authenticateUser(String mobileNumber, BuildContext context) async{
  FirebaseAuth auth = FirebaseAuth.instance;
  String otp = '';

  await auth.verifyPhoneNumber(
    phoneNumber: mobileNumber,
    timeout: Duration(seconds: 120),
    // Called when auto detects OTP and is successful
    verificationCompleted: (PhoneAuthCredential credential) async{
      await auth.signInWithCredential(credential).then((value) {
        return true;
      }).catchError((err) {
        print(err.toString());
        return false;
      });
    },
    // Called when error
    verificationFailed: (FirebaseAuthException authException){
      print(authException.message);
      return false;
    },
    // Called when OTP Code is sent to mobile number
    codeSent: (String verificationId, [int resendToken]) async{
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text(
            'Enter OTP Code',
          ),
          content: Column(
            children: [
              TextField(
                onChanged: (val){
                  otp = val;
                },
              ),
            ],
          ),
          actions: [
            FlatButton(
              child: Text(
                'LOGIN',
              ),
              onPressed: () async{
                PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp);
                await auth.signInWithCredential(credential).then((value) {
                  return true;
                }).catchError((err) {
                  print(err.toString());
                  return false;
                });
              },
            ),
          ],
        ),
      );
    },
    // Called when OTP expires due to timeout
    codeAutoRetrievalTimeout: (String verificationId){
      print(verificationId);
      print("Timeout");
      Navigator.pushNamed(context, LoginScreen.id);
    },
  );
}