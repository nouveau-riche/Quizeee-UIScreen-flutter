import 'dart:io';

import 'package:com.quizeee.quizeee/provider/initialPro.dart';
import 'package:com.quizeee.quizeee/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';

class ChangePhone extends StatefulWidget {
  final String phoneNumber;

  ChangePhone({this.phoneNumber});

  @override
  _ChangePhoneState createState() => _ChangePhoneState();
}

class _ChangePhoneState extends State<ChangePhone> {
  final _formKey = GlobalKey<FormState>();
  String _phoneNumber;

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: kSecondaryColor,
    borderRadius: BorderRadius.circular(10.0),
  );

  Future<void> save() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (isOtpSent) {
        saveOtp();
      } else {
        sendOtp();
      }

      /// verify for otp

    }
  }

  void getBack() async {
    final intialPro = Provider.of<Auth>(context, listen: false);
    intialPro.editedPhone = "1234556" ?? widget.phoneNumber;
    intialPro.notifyListeners();
    Navigator.pop(context);
  }

  bool isOtpSent = false;

  Future<void> sendOtp() async {
    final intialPro = Provider.of<Auth>(context, listen: false);
    var body = {"phone": "+91" + _phoneNumber};

    final resp = await intialPro.sendVerificationOtp(body, false);
    toast(resp['msg'], isError: !resp['status']);
    if (resp['status']) {
      isOtpSent = true;
    }
  }

  Future<void> saveOtp() async {
    final intialPro = Provider.of<Auth>(context, listen: false);
    intialPro.phoneOtp = _pinPutController.text;
    getBack();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final iOS = Platform.isIOS;
    return SafeArea(
      top: iOS,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              buildAppBar(context, mq),
              SizedBox(
                height: mq.height * 0.05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone,
                    color: kPrimaryLightColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Edit Phone Number',
                    style: TextStyle(
                      fontSize: 32,
                      color: kPrimaryLightColor,
                      fontFamily: 'DebugFreeTrial',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: mq.height * 0.05,
              ),
              Form(
                key: _formKey,
                child: buildPhoneTextFieldField(mq),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: PinPut(
                  fieldsCount: 6,
                  textStyle: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                  eachFieldWidth: 40.0,
                  eachFieldHeight: 48.0,
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  submittedFieldDecoration: pinPutDecoration,
                  selectedFieldDecoration: pinPutDecoration,
                  followingFieldDecoration: pinPutDecoration,
                  pinAnimationType: PinAnimationType.fade,
                  onSubmit: (pin) {
                    /// build logic for checking otp
                  },
                ),
              ),
              SizedBox(
                height: mq.height * 0.1,
              ),
              buildVerifyButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context, Size mq) {
    return Row(
      children: [
        Container(
          height: 45,
          width: mq.width * 0.12,
          margin: EdgeInsets.only(left: mq.width * 0.05),
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: kPrimaryColor,
            ),
            onPressed: () {
              // Navigator.of(context).pop();
              getBack();
            },
          ),
        ),
      ],
    );
  }

  Widget buildPhoneTextFieldField(Size mq) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: mq.width * 0.05, vertical: mq.height * 0.015),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            kSecondaryColor.withOpacity(0.5),
            kSecondaryColor.withOpacity(0.1)
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          cursorColor: kPrimaryLightColor,
          style: TextStyle(
              color: kPrimaryLightColor,
              fontWeight: FontWeight.bold,
              fontSize: 12.5),
          decoration: InputDecoration(
            hintText: 'EDIT PHONE NUMBER',
            hintStyle: TextStyle(color: kPrimaryLightColor),
            border: InputBorder.none,
          ),
          initialValue: widget.phoneNumber,
          // ignore: missing_return
          validator: (_value) {
            if (_value.isEmpty) {
              return kPhoneNumberNullError;
            }
            if (_value.length != 10) {
              return kInvalidPhoneError;
            }
          },
          onSaved: (_value) {
            _phoneNumber = _value;
          },
        ),
      ),
    );
  }

  Widget buildVerifyButton() {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 68, height: 55),
      child: ElevatedButton(
        onPressed: () {
          save();
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          primary: kPrimaryLightColor,
        ),
        child: const Text(
          'Verify',
          style: TextStyle(
              fontSize: 12.8, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
    );
  }
}
