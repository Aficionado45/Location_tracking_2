// Importing packages
import 'package:flutter/material.dart';
import 'package:location_tracking_2/constants.dart';
import 'package:location_tracking_2/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Importing Firebase Packages
import 'package:firebase_core/firebase_core.dart';

// Importing Screens
import 'package:location_tracking_2/screens/welcome_screen.dart';
import 'package:location_tracking_2/screens/login_screen.dart';
import 'package:location_tracking_2/screens/home_screen.dart';

Future<void> main() async {
  // Initializing Firebase App
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Checking if user previously logged in using SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // kMobileNumber = prefs.getString('mobile');
  var temp = prefs.getString('mobile');
  if(temp != null){
    kCurrUser = new User(mobileNumber: temp);
    kCurrUser.retrieveDocument();
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Location Tracking App 2.0',

      home: (kCurrUser == null) ? WelcomeScreen() : HomeScreen(),
      routes: {
        WelcomeScreen.id : (context) => WelcomeScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        HomeScreen.id : (context) => HomeScreen(),
      },
    );
  }
}
