import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_count_down/otp_count_down.dart';
import 'package:pinput/pin_put/pin_put.dart';

import '../../constant.dart';
import '../tabs_screen.dart';


class OTPScreen extends StatefulWidget {
  final String type;
  final String phone;
  final String username;
  final String location;
  final String email;
  final String referralCode;
  final DateTime dob;
  final File image;

  OTPScreen({
    @required this.type,
    this.username,
    this.location,
    this.email,
    @required this.phone,
    this.referralCode,
    this.dob,
    this.image,
  });

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _countDown = '';
  OTPCountDown _otpCountDown;
  final int _otpTimeInMS = 1000 * 2 * 60;

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: kSecondaryColor,
    borderRadius: BorderRadius.circular(10.0),
  );


  void _startCountDown() {
    _otpCountDown = OTPCountDown.startOTPTimer(
      timeInMS: _otpTimeInMS,
      currentCountDown: (String countDown) {
        _countDown = countDown;
        setState(() {});
      },
      onFinish: () {
        print("Count down finished!");
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _startCountDown();
  }

  @override
  void dispose() {
    _otpCountDown.cancelTimer();
    _pinPutController.dispose();
    _pinPutFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: mq.height * 0.065,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 45,
                  width: 40,
                  margin: EdgeInsets.only(left: mq.width*0.07),
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
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: mq.height * 0.01,
            ),
            Container(
              color: Colors.orange,
              height: mq.height * 0.15,
              width: mq.width * 0.3,
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
              ),
            ),
            const Text(
              'QUIZEEE',
              style: TextStyle(
                  color: kTextColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SairaStencilOne',
                  decoration: TextDecoration.underline),
            ),
            const Text(
              'ENTER OTP',
              style: TextStyle(
                color: kTextColor,
                fontFamily: 'Bungee',
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: mq.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: PinPut(
                fieldsCount: 6,
                textStyle:
                    const TextStyle(fontSize: 25.0, color: kPrimaryColor,fontFamily: 'Bungee',),
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
            const Text(
              'OTP SENT TO YOUR MOBILE NUMBER',
              style: TextStyle(
                color: kTextColor,
                fontFamily: 'Bungee',
                fontSize: 11.6,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: mq.height * 0.01,
            ),
            RichText(
              text: TextSpan(
                text: "OTP VALID ",
                children: [
                  TextSpan(
                    text: _countDown,
                    style:
                        const TextStyle(color: kSecondaryColor, fontSize: 20),
                  ),
                ],
                style: const TextStyle(color: kTextColor, fontFamily: 'Bungee',fontSize: 11),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: mq.height * 0.05,
            ),
            TextButton(
              child: const Text(
                'RESEND OTP',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Bungee',
                  color: kSecondaryColor,
                ),
              ),
              onPressed: () {


                // re-verify phone

                _startCountDown();
                _pinPutController.clear();
              },
            ),
            SizedBox(
              height: mq.height * 0.1,
            ),
            buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget buildNextButton() {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 68, height: 55),
      child: ElevatedButton(
        onPressed: () {

          Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (context) => TabsScreen()),
                  (route) => false);

        },
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
