// Importing packages
import 'package:flutter/material.dart';

// Importing Firebase Packages

// Importing Screens
import 'package:location_tracking_2/screens/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = '/welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Live Location Tracking App',
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.pushNamed(context, LoginScreen.id);
              },
              child: Text(
                'Login'
              ),
            )
          ],
        ),
      ),
    );
  }
}
