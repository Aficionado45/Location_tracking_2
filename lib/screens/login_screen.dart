// Importing packages
import 'package:flutter/material.dart';
import 'package:location_tracking_2/constants.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

// Importing Firebase Packages

// Importing Screens
import 'package:location_tracking_2/screens/home_screen.dart';

// Importing Services
import 'package:location_tracking_2/services/authenticate_user.dart';

// Importing Models
import 'package:location_tracking_2/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const id = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  String userMobileNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter your mobile number: '
            ),
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number){
                userMobileNumber = number.phoneNumber;
                print(userMobileNumber);
              },
              selectorConfig: SelectorConfig(
                selectorType: PhoneInputSelectorType.DROPDOWN,
              ),
              initialValue: number,
              keyboardType:
              TextInputType.numberWithOptions(signed: true, decimal: true),
              inputBorder: OutlineInputBorder(),

            ),
            ElevatedButton(
              onPressed: () async{
                // If user successfully authenticated, setting SharedPreference and document in Cloud Firestore (if doesn't exist)
                // if(await authenticateUser(userMobileNumber, context)){
                //   SharedPreferences prefs = await SharedPreferences.getInstance();
                //   prefs.setString('mobile', userMobileNumber);
                //   kCurrUser = new User(mobileNumber: userMobileNumber);
                //   if(!await kCurrUser.checkAndRetrieve()){
                //     kCurrUser.createDocument();
                //   }
                //   Navigator.pushNamed(context, HomeScreen.id);
                // }
                await authenticateUser(userMobileNumber, context);
              },
              child: Text(
                'Get OTP',
              ),
            )
          ],
        ),
      ),
    );
  }
}
