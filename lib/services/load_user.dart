// Importing Packages
import 'package:location_tracking_2/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Importing Models
import 'package:location_tracking_2/models/user.dart';

// Function to load sign in user's details
Future<void> loadUser(String mobileNumber) async{

  kCurrUser = new User(mobileNumber: mobileNumber);
  await kCurrUser.loadExistence();
  if(kCurrUser.exists){
    await kCurrUser.retrieveDocument();
  }
  else{
    await kCurrUser.createDocument();
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('mobile', mobileNumber);
}
