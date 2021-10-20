// Importing packages
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:location_tracking_2/constants.dart';
import 'package:location_tracking_2/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Importing Firebase Packages
import 'package:firebase_core/firebase_core.dart';

// Importing Screens
import 'package:location_tracking_2/screens/welcome_screen.dart';
import 'package:location_tracking_2/screens/auth/login_screen.dart';
import 'package:location_tracking_2/screens/home/home_screen.dart';
import 'package:location_tracking_2/screens/auth/profile_screen.dart';
import 'package:location_tracking_2/screens/auth/edit_profile_screen.dart';

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
    kCurrUser.downloadProfileImage();
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
      title: 'Location Tracker',

      home: (kCurrUser == null) ? WelcomeScreen() : HomeScreen(),
      routes: {
        WelcomeScreen.id : (context) => WelcomeScreen(),
        LoginScreen.id : (context) => LoginScreen(),
        HomeScreen.id : (context) => HomeScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        EditProfileScreen.id: (context) => EditProfileScreen(),
      },
    );
  }
  @override
  void initState() {
    super.initState();
    initDynamicLinks();
  }
  //INITIALIZING FIREBASE DYNAMIC LINKS
  void initDynamicLinks() async {
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      print(deepLink.path.toString());
      Navigator.pushNamed(context, deepLink.path);
    }

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
          final Uri deepLink = dynamicLink?.link;

          if (deepLink != null) {
            Navigator.pushNamed(context, deepLink.path);
          }

        }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });
  }
}
