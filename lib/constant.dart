import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF00303F); // dark blakish green
const kPrimaryLightColor =
    Color.fromRGBO(254, 180, 35, 1); // Yellow + little orange

const kNotificationColor = Color.fromRGBO(71, 112, 118, 1);

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
const String oneSignalKey = "300d9f0e-1975-4739-bc25-ca0f1dce1c1b";

List<String> states = [
  'Andhra Pradesh',
  'Arunachal Pradesh',
  'Assam',
  'Bihar',
  'Chhattisgarh',
  'Goa',
  'Gujarat',
  'Haryana',
  'Himachal Pradesh',
  'Jharkhand',
  'Karnataka',
  'Kerala',
  'Madhya Pradesh',
  'Maharashtra',
  'Manipur',
  'Meghalaya',
  'Mizoram',
  'Nagaland',
  'Odisha',
  'Punjab',
  'Rajasthan',
  'Sikkim',
  'Tamil Nadu',
  'Telangana',
  'Tripura',
  'Uttar Pradesh',
  'Uttarakhand',
  'West Bengal',
];

List<DropdownMenuItem> stateDropDownList = [
  DropdownMenuItem(
    child: const Text(
      'Andhra Pradesh',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 0,
  ),
  DropdownMenuItem(
    child: const Text(
      'Arunachal Pradesh',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 1,
  ),
  DropdownMenuItem(
    child: const Text(
      'Assam',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 2,
  ),
  DropdownMenuItem(
    child: const Text(
      'Bihar',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 3,
  ),
  DropdownMenuItem(
    child: const Text(
      'Chhattisgarh',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 4,
  ),
  DropdownMenuItem(
    child: const Text(
      'Goa',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 5,
  ),
  DropdownMenuItem(
    child: const Text(
      'Gujarat',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 6,
  ),
  DropdownMenuItem(
    child: const Text(
      'Haryana',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 7,
  ),
  DropdownMenuItem(
    child: const Text(
      'Himachal Pradesh',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 8,
  ),
  DropdownMenuItem(
    child: const Text(
      'Jharkhand',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 9,
  ),
  DropdownMenuItem(
    child: const Text(
      'Karnataka',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 10,
  ),
  DropdownMenuItem(
    child: const Text(
      'Kerala',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 11,
  ),
  DropdownMenuItem(
    child: const Text(
      'Madhya Pradesh',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 12,
  ),
  DropdownMenuItem(
    child: const Text(
      'Maharashtra',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 13,
  ),
  DropdownMenuItem(
    child: const Text(
      'Manipur',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 14,
  ),
  DropdownMenuItem(
    child: const Text(
      'Meghalaya',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 15,
  ),
  DropdownMenuItem(
    child: const Text(
      'Mizoram',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 16,
  ),
  DropdownMenuItem(
    child: const Text(
      'Nagaland',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 17,
  ),
  DropdownMenuItem(
    child: const Text(
      'Odisha',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 18,
  ),
  DropdownMenuItem(
    child: const Text(
      'Punjab',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 19,
  ),
  DropdownMenuItem(
    child: const Text(
      'Rajasthan',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 20,
  ),
  DropdownMenuItem(
    child: const Text(
      'Sikkim',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 21,
  ),
  DropdownMenuItem(
    child: const Text(
      'Tamil Nadu',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 22,
  ),
  DropdownMenuItem(
    child: const Text(
      'Telangana',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 23,
  ),
  DropdownMenuItem(
    child: const Text(
      'Tripura',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 24,
  ),
  DropdownMenuItem(
    child: const Text(
      'Uttar Pradesh',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 25,
  ),
  DropdownMenuItem(
    child: const Text(
      'Uttarakhand',
      style: const TextStyle(
          fontFamily: 'Nunito',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black),
    ),
    value: 26,
  ),
  DropdownMenuItem(
    child: const Text(
      'West Bengal',
      style: const TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
    ),
    value: 27,
  ),
];

List<DropdownMenuItem> stateDropDownListForEditProfile = [
  DropdownMenuItem(
    child: const Text(
      'Andhra Pradesh',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 0,
  ),
  DropdownMenuItem(
    child: const Text(
      'Arunachal Pradesh',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 1,
  ),
  DropdownMenuItem(
    child: const Text(
      'Assam',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 2,
  ),
  DropdownMenuItem(
    child: const Text(
      'Bihar',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 3,
  ),
  DropdownMenuItem(
    child: const Text(
      'Chhattisgarh',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 4,
  ),
  DropdownMenuItem(
    child: const Text(
      'Goa',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 5,
  ),
  DropdownMenuItem(
    child: const Text(
      'Gujarat',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 6,
  ),
  DropdownMenuItem(
    child: const Text(
      'Haryana',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 7,
  ),
  DropdownMenuItem(
    child: const Text(
      'Himachal Pradesh',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 8,
  ),
  DropdownMenuItem(
    child: const Text(
      'Jharkhand',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 9,
  ),
  DropdownMenuItem(
    child: const Text(
      'Karnataka',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 10,
  ),
  DropdownMenuItem(
    child: const Text(
      'Kerala',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 11,
  ),
  DropdownMenuItem(
    child: const Text(
      'Madhya Pradesh',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 12,
  ),
  DropdownMenuItem(
    child: const Text(
      'Maharashtra',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 13,
  ),
  DropdownMenuItem(
    child: const Text(
      'Manipur',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 14,
  ),
  DropdownMenuItem(
    child: const Text(
      'Meghalaya',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 15,
  ),
  DropdownMenuItem(
    child: const Text(
      'Mizoram',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 16,
  ),
  DropdownMenuItem(
    child: const Text(
      'Nagaland',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 17,
  ),
  DropdownMenuItem(
    child: const Text(
      'Odisha',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 18,
  ),
  DropdownMenuItem(
    child: const Text(
      'Punjab',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 19,
  ),
  DropdownMenuItem(
    child: const Text(
      'Rajasthan',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 20,
  ),
  DropdownMenuItem(
    child: const Text(
      'Sikkim',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 21,
  ),
  DropdownMenuItem(
    child: const Text(
      'Tamil Nadu',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 22,
  ),
  DropdownMenuItem(
    child: const Text(
      'Telangana',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 23,
  ),
  DropdownMenuItem(
    child: const Text(
      'Tripura',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 24,
  ),
  DropdownMenuItem(
    child: const Text(
      'Uttar Pradesh',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 25,
  ),
  DropdownMenuItem(
    child: const Text(
      'Uttarakhand',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 26,
  ),
  DropdownMenuItem(
    child: const Text(
      'West Bengal',
      style: TextStyle(
          color: kPrimaryLightColor,
          fontWeight: FontWeight.bold,
          fontSize: 12.5),
    ),
    value: 27,
  ),
];
