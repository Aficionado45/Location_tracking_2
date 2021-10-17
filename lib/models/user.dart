// Importing packages
import 'package:flutter/foundation.dart';

// Importing Firebase packages
import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  final String mobileNumber;
  bool exists;
  String name = '';

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

  // Retrieves data from user's document in Cloud Firestore
  Future<void> retrieveDocument() async{
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(this.mobileNumber).snapshots().listen((event) {
      this.name = event.get('name');
    });
  }

}