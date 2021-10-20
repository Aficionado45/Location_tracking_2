// Importing packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location_tracking_2/services/share_app.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Importing Screens
import 'package:location_tracking_2/screens/welcome_screen.dart';
import 'package:location_tracking_2/screens/auth/profile_screen.dart';
import 'package:location_tracking_2/constants.dart';
import 'package:location_tracking_2/screens/home/contactpage.dart';

// Importing Services
import 'dart:io';
import 'package:location_tracking_2/services/logout_user.dart';
import 'package:location_tracking_2/services/permissions.dart';

class HomeScreen extends StatefulWidget {
  static const id = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.person,
            ),
            onPressed: () {
              Navigator.pushNamed(context, ProfileScreen.id);
            },
          ),
        ],
        title: Text(
          'Home Screen',
        ),
      ),
      //DRAWER
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(auth.currentUser.phoneNumber),
              ),
              InkWell(
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text("About us"),
                  onTap: () {},
                ),
              ),
              InkWell(
                child: ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                  ),
                  title: Text("Log Out"),
                  onTap: () async {
                    await logoutUser();
                    Navigator.pushNamed(context, WelcomeScreen.id);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final PermissionStatus permissionStatus =
                    await getContactPermission();
                if (permissionStatus == PermissionStatus.granted) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ContactPage()));
                } else {
                  //If permissions have been denied show standard cupertino alert dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => CupertinoAlertDialog(
                      title: Text('Permissions error'),
                      content: Text('Please enable contacts access '
                          'permission in system settings'),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: Text('OK'),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ],
                    ),
                  );
                }
              },
              child: Container(child: Text('Import Contacts')),
            ),
            ElevatedButton(
              child: Text(
                'Invite a Friend',
              ),
              onPressed: () async {
                await shareApp(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
