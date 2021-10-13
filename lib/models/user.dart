// Importing packages
import 'package:flutter/foundation.dart';

// Importing Firebase packages
import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String mobileNumber;
  String name = '';

  User({@required this.mobileNumber, this.name});

  // Creates and updates documents in Firestore collection 'users' for this user
  Future createDocument(){
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return users.doc(this.mobileNumber).set({
      'name': this.name,
      'mobile': this.mobileNumber,
    }).then((value) {
      print('New document created for user');
    }).catchError((err) {
      print(err.toString());
    });
  }

  // Checks for presence of document in Firestore collection 'users' for this user, and retrieves data
  Future<bool> checkAndRetrieve(){
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(this.mobileNumber).get().then((DocumentSnapshot documentSnapshot) async {
      if(documentSnapshot.exists){
        await users.doc(this.mobileNumber).snapshots().listen((event) {
          this.name = event.get('name');
        });
        return true;
      }
      else{
        return false;
      }
    });
  }

}