// Importing packages
import 'package:flutter/material.dart';
import 'package:location_tracking_2/constants.dart';

// Importing Screens
import 'package:location_tracking_2/screens/welcome_screen.dart';
import 'package:location_tracking_2/screens/profile_screen.dart';

// Importing Services
import 'package:location_tracking_2/services/logout_user.dart';

class HomeScreen extends StatefulWidget {
  static const id = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.person,
            ),
            onPressed: (){
              Navigator.pushNamed(context, ProfileScreen.id);
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.exit_to_app,
          ),
          onPressed: () async{
            await logoutUser();
            Navigator.pushNamed(context, WelcomeScreen.id);
          },
        ),
        title: Text(
          'Home Screen',
        ),
      ),
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome ${kCurrUser.name}',
            ),
          ],
        ),
      ),
    );
  }
}
