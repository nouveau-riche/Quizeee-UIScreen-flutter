import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import './dob_image.dart';
import '../../widgets/toast.dart';
import '../../constant.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  String _username;
  String _location;
  String _email;
  String _phoneNumber;
  String _referralCode;

  final _focusLocation = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPhoneNumber = FocusNode();
  final _focusReferral = FocusNode();

  @override
  void dispose() {
    _focusLocation.dispose();
    _focusEmail.dispose();
    _focusPhoneNumber.dispose();
    _focusReferral.dispose();
    super.dispose();
  }

  void _save() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      bool phoneValidation = _phoneNumber.length == 10;

      bool emailValidation = emailValidatorRegExp.hasMatch(_email);

      if (phoneValidation == false && emailValidation == false) {

        if(_email.length != 0){
          toast('Enter valid email',isError: true);
          return;
        }

        if(_phoneNumber.length != 10){
          toast('Enter valid phone',isError: true);
          return;
        }

        toast('Enter email or phone',isError: true);
        return;
      }

      print(_username);
      print(_location);
      print(_email);
      print(_phoneNumber);
      print(_referralCode);


      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (ctx) => DOBImage(
            username: _username,
            location: _location,
            email: _email,
            phoneNumber: _phoneNumber,
            referralCode: _referralCode,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildUserNameField(),
          buildLocationField(),
          buildEmailField(),
          buildPhoneNumberField(),
          buildReferralCodeField(),
          SizedBox(
            height: mq.height * 0.05,
          ),
          buildNextButton(),
        ],
      ),
    );
  }

  Widget buildUserNameField() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 1, top: 1),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        cursorColor: Colors.black,
        style: const TextStyle(fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
          hintText: 'USER NAME',
          hintStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.8,
              color: Colors.black87),
          border: InputBorder.none,
        ),
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_focusLocation);
        },

        // ignore: missing_return
        validator: (_value) {
          if (_value.isEmpty) {
            return kNameNullError;
          }
        },
        onSaved: (_value) {
          _username = _value;
        },
      ),
    );
  }

  Widget buildLocationField() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 1, top: 1),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        cursorColor: Colors.black,
        style: const TextStyle(fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
          hintText: 'LOCATION',
          hintStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.8,
              color: Colors.black87),
          border: InputBorder.none,
        ),
        textInputAction: TextInputAction.next,
        focusNode: _focusLocation,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_focusEmail);
        },

        // ignore: missing_return
        validator: (_value) {
          if (_value.isEmpty) {
            return kLocationNullError;
          }
        },
        onSaved: (_value) {
          _location = _value;
        },
      ),
    );
  }

  Widget buildEmailField() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 1, top: 1),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        cursorColor: Colors.black,
        style: const TextStyle(fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
          hintText: 'EMAIL ID',
          hintStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.8,
              color: Colors.black87),
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        focusNode: _focusEmail,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_focusPhoneNumber);
        },

        // ignore: missing_return
        // validator: (_value) {
        //   if (_value.isEmpty) {
        //     return kEmailNullError;
        //   }
        //   bool emailValid = emailValidatorRegExp.hasMatch(_value);
        //   if (!emailValid) {
        //     return kInvalidEmailError;
        //   }
        // },
        onSaved: (_value) {
          _email = _value;
        },
      ),
    );
  }

  Widget buildPhoneNumberField() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 1, top: 1),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        style: const TextStyle(fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
          hintText: 'PHONE NUMBER',
          hintStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.8,
              color: Colors.black87),
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.next,
        focusNode: _focusPhoneNumber,
        onFieldSubmitted: (_) {
          FocusScope.of(context).requestFocus(_focusReferral);
        },

        // ignore: missing_return
        // validator: (_value) {
        //   if (_value.isEmpty) {
        //     return kPhoneNumberNullError;
        //   }
        //   if (_value.length != 10) {
        //     return kInvalidPhoneError;
        //   }
        // },
        onSaved: (_value) {
          _phoneNumber = _value;
        },
      ),
    );
  }

  Widget buildReferralCodeField() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 1, top: 1),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        cursorColor: Colors.black,
        style: const TextStyle(fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
          hintText: 'REFERRAL CODE',
          hintStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.8,
              color: Colors.black87),
          border: InputBorder.none,
        ),
        focusNode: _focusReferral,
        textInputAction: TextInputAction.done,
        onSaved: (_value) {
          _referralCode = _value;
        },
      ),
    );
  }

  Widget buildNextButton() {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 68, height: 55),
      child: ElevatedButton(
        onPressed: _save,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          primary: kTextColor,
        ),
        child: const Text(
          'NEXT',
          style: TextStyle(
              fontSize: 12.8, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
    );
  }
}
