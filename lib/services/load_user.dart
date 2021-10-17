// Importing Packages
import 'package:location_tracking_2/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Importing Models
import 'package:location_tracking_2/models/user.dart';

// Importing Services
import 'package:location_tracking_2/services/copy_image_file.dart';

// Function to load sign in user's details
Future<void> loadUser(String mobileNumber) async{

  kCurrUser = new User(mobileNumber: mobileNumber);
  await kCurrUser.loadExistence();
  if(kCurrUser.exists){
    await kCurrUser.retrieveDocument();
    await kCurrUser.downloadProfileImage();
    await kCurrUser.uploadProfileImage();
  }
  else{
    await kCurrUser.createAndUpdateDocument();
    await copyImageFile('profile.png', '${kCurrUser.mobileNumber}/profile.png');
    await kCurrUser.downloadProfileImage();
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('mobile', mobileNumber);
}
