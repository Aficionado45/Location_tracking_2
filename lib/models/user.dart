// Importing packages
import 'package:flutter/foundation.dart';
import 'package:location_tracking_2/constants.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

// Importing Firebase packages
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String mobileNumber; // User's Mobile Number
  String name = ' '; // User's Name
  bool exists; // Variable to check if user's document exists in Cloud Firestore

  User({@required this.mobileNumber, this.name});

  // Checks if user's document is present in Cloud Firestore and updates 'exists' property
  Future loadExistence() async{
    await FirebaseFirestore.instance.collection('users').doc(this.mobileNumber).get()
        .then((DocumentSnapshot documentSnapshot){
          if(documentSnapshot.exists){
            exists = true;
          }
          else{
            exists = false;
          }
    });
  }

  // Creates and updates documents in Firestore collection 'users' for this user
  Future createAndUpdateDocument(){
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users.doc(this.mobileNumber).set({
      'name': this.name,
      'mobile': this.mobileNumber,
    }).then((value) {
      print('New document created / updated for user');
    }).catchError((err) {
      print(err.toString());
    });
  }

  // Retrieves data from user's document in Cloud Firestore
  Future retrieveDocument() async{
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(this.mobileNumber).snapshots().listen((event) {
      this.name = event.get('name');
    });
  }

  // Downloads current user's profile image from Firebase Storage
  Future downloadProfileImage() async{
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    kProfileImagePath = '${appDocDirectory.path}/profile.png';
    File profileImage = File(kProfileImagePath);
    try{
      await FirebaseStorage.instance
          .ref('${this.mobileNumber}/profile.png')
          .writeToFile(profileImage);
    } on FirebaseException catch(err){
      print(err);
    }
  }

  // Uploads current profile image to Firebase Storage
  Future uploadProfileImage() async{
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    kProfileImagePath = '${appDocDirectory.path}/profile.png';
    File profileImage = File(kProfileImagePath);
    try{
      await FirebaseStorage.instance
          .ref('${this.mobileNumber}/profile.png')
          .putFile(profileImage);
    } on FirebaseException catch(err){
      print(err);
    }
  }

}