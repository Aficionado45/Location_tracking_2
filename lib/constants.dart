// Importing Packages
import 'package:location_tracking_2/main.dart';

// Importing Models
import 'package:location_tracking_2/models/user.dart';

// Current logged in user (by default null)
var kMobileNumber;
User kCurrUser;

// Path of profile image to be displayed
String kProfileImagePath;

// Content to share for invite a friend
String kShareSubject = 'Friend Invite';
String kShareText = 'Hey! I invite you to join Live Location Tracking App. Join now using this link https://locationtrackerapp.page.link/register-now';