import 'package:flutter/material.dart';


const kPrimaryColor = Color(0xFF00303F); // dark blakish green
const kPrimaryLightColor = Color.fromRGBO(254, 180, 35, 1); // Yellow + little orange

const kNotificationColor = Color.fromRGBO(71,112,118,1);

const kResultColor = Colors.yellow;

const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFFCAE4DB); // light blue type
const kTextColor = Color(0xFFCDAC81); // skin for text

const kAnimationDuration = Duration(milliseconds: 200);


const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kNameNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kInvalidPhoneError = "Please Enter Valid phone";
const String kLocationNullError = "Please Enter your location";

