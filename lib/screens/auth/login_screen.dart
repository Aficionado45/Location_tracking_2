// Importing packages
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

// Importing Services
import 'package:location_tracking_2/services/login_user.dart';


class LoginScreen extends StatefulWidget {
  static const id = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  PhoneNumber number = PhoneNumber(isoCode: 'US');
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
                await loginUser(userMobileNumber, context);
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
