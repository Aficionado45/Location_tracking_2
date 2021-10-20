// Importing Packages
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:location_tracking_2/constants.dart';

// Importing Screens
import 'package:location_tracking_2/screens/auth/edit_profile_screen.dart';

// Importing Services
import 'package:location_tracking_2/services/share_app.dart';

class ProfileScreen extends StatefulWidget {
  static const id = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Profile',
        ),
      ),
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hey ${kCurrUser.name}',
            ),
            Text(
              kCurrUser.mobileNumber,
            ),
            CircleAvatar(
              child: Image(
                image: FileImage(
                  File(kProfileImagePath),
                ),
              ),
              radius: 100,
            ),
            ElevatedButton(
              child: Text(
                'Edit Profile',
              ),
              onPressed: (){
                setState(() {
                  Navigator.pushNamed(context, EditProfileScreen.id);
                });
              },
            ),

          ],
        ),
      ),
    );
  }
}
