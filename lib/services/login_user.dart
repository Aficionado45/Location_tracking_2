// Importing packages
import 'package:flutter/material.dart';

// Importing Firebase Packages
import 'package:firebase_auth/firebase_auth.dart';

// Importing Screens
import 'package:location_tracking_2/screens/login_screen.dart';
import 'package:location_tracking_2/screens/home_screen.dart';

// Importing Services
import 'package:location_tracking_2/services/load_user.dart';

// Function to sign in users using mobile number
Future<bool> loginUser(String mobileNumber, BuildContext context) async{
  FirebaseAuth auth = FirebaseAuth.instance;
  String otp = '';

  await auth.verifyPhoneNumber(
    phoneNumber: mobileNumber,
    timeout: Duration(seconds: 120),
    // Called when auto detects OTP and is successful
    verificationCompleted: (PhoneAuthCredential credential) async{
      await auth.signInWithCredential(credential).then((value) async{
        await loadUser(mobileNumber);
        Navigator.pushNamed(context, HomeScreen.id);
      }).catchError((err) {
        print(err.toString());
      });
    },
    // Called when error
    verificationFailed: (FirebaseAuthException authException){
      print(authException.message);
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
                keyboardType: TextInputType.number,
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
                await auth.signInWithCredential(credential).then((value) async{
                  await loadUser(mobileNumber);
                  Navigator.pushNamed(context, HomeScreen.id);
                }).catchError((err) {
                  print(err.toString());
                });
              },
            ),
          ],
        ),
      );
    },
    // Called when OTP expires due to timeout
    codeAutoRetrievalTimeout: (String verificationId){
      if(auth.currentUser.uid.isNotEmpty) {
        print(verificationId);
        print("Timeout");
        Navigator.pushNamed(context, LoginScreen.id);
      }
    },
  );

}