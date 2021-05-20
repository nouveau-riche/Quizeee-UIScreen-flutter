import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:quizeee_ui/provider/mainPro.dart';

import '../../provider/initialPro.dart';
import '../../widgets/toast.dart';
import '../../constant.dart';
import '../tabs_screen.dart';

class OTPScreen extends StatefulWidget {
  final String otp;
  final String type;
  final String phone;
  final String username;
  final String location;
  final String email;
  final String referralCode;
  final DateTime dob;
  final File image;

  OTPScreen({
    this.otp,
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

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: kSecondaryColor,
    borderRadius: BorderRadius.circular(10.0),
  );

  Timer _timer;
  int _start;

  void startTimer() {
    _start = 140;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
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
                  margin: EdgeInsets.only(left: mq.width * 0.07),
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
                  fontFamily: 'MajorLeagueDuty',
                  decoration: TextDecoration.underline),
            ),
            const Text(
              'ENTER OTP',
              style: TextStyle(
                color: kTextColor,
                fontFamily: 'DebugFreeTrial',
                fontSize: 26,
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
            const Text(
              'OTP SENT TO YOUR MOBILE NUMBER',
              style: TextStyle(
                color: kTextColor,
                fontFamily: 'DebugFreeTrial',
                fontSize: 16,
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
                    text: ' $_start S',
                    style:
                        const TextStyle(color: kSecondaryColor, fontSize: 22),
                  ),
                ],
                style: const TextStyle(
                    color: kTextColor,
                    fontFamily: 'DebugFreeTrial',
                    fontSize: 16),
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
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'DebugFreeTrial',
                  color: kSecondaryColor,
                ),
              ),
              onPressed: () {
                // re-verify phone

                _pinPutController.clear();
                resendOtp();
                startTimer();
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

  Future<void> resendOtp() async {
    var body;
    if (widget.type == "login") {
      if (widget.phone.contains("@")) {
        body = {"email": widget.phone};
      } else {
        body = {"phone": "+91" + widget.phone};
      }
    } else {
      body = {"phone": "+91" + widget.phone};
    }
    final authPro = Provider.of<Auth>(context, listen: false);
    final response = await authPro.sendVerificationOtp(body, false);
    toast(response['msg'], isError: !response['status']);
  }

  Future<void> submitOtp() async {
    final authPro = Provider.of<Auth>(context, listen: false);
    final mainPro = Provider.of<MainPro>(context, listen: false);
    var body;
    var response;
    bool isEmail;
    if (widget.type == "login") {
      // calling login api

      if (widget.phone.contains("@")) {
        isEmail = true;
        body = {"email": widget.phone, "otpCode": _pinPutController.text};
      } else {
        isEmail = false;
        body = {
          "phone": "+91" + widget.phone,
          "otpCode": _pinPutController.text
        };
      }
      if (isEmail) {
        if (_pinPutController.text == widget.otp) {
          response = {"status": true, "msg": "User LoggedIn Successfully"};
          authPro.setLoading(true);

          await authPro.loginUser(body);
          authPro.setLoading(false);
        } else {
          response = {"status": false, "msg": "Otp didn't match"};
        }
      } else {
        authPro.setLoading(true);
        response = await authPro.loginUser(body);
        authPro.setLoading(false);
      }
    } else {
      print(widget.image);
      FormData body;
      if (widget.image != null) {
        var fileContent = widget.image.readAsBytesSync();
        var fileContentBase64 = base64.encode(fileContent);
        body = new FormData.fromMap({
          "username": widget.username,
          "location": widget.location,
          "email": widget.email,
          "phone": "+91" + widget.phone,
          "referralCode": widget.referralCode,
          "dateOfBirth": widget.dob.toIso8601String(),
          "deviceId": "1234",
          "otpCode": _pinPutController.text,
          "profilePic": await MultipartFile.fromFile(widget.image.path,
              filename: 'upload.png')
        });
      } else {
        body = new FormData.fromMap({
          "username": widget.username,
          "location": widget.location,
          "email": widget.email,
          "phone": "+91" + widget.phone,
          "referralCode": widget.referralCode,
          "dateOfBirth": widget.dob.toIso8601String(),
          "deviceId": "1234",
          "otpCode": _pinPutController.text,
          "profilePic": null
        });
      }
      authPro.setLoading(true);

      response = await authPro.signupUser(body);
      authPro.setLoading(false);
    }

    if (response['status']) {
      toast(response['msg'], isError: !response['status']);
      mainPro.clearQuizData();
      mainPro.clearDashBoard();
      Future.delayed(Duration(seconds: 1), () {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => TabMainScreen()),
            (route) => false);
      });
    } else {
      toast(response['msg'], isError: !response['status']);
    }
  }

  Widget buildNextButton() {
    return Consumer<Auth>(
      builder: (con, auth, _) => auth.isLoading
          ? SpinKitWave(color: kSecondaryColor)
          : ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 68, height: 55),
              child: ElevatedButton(
                onPressed: () {
                  submitOtp();
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  primary: kTextColor,
                ),
                child: const Text(
                  'NEXT',
                  style: TextStyle(
                      fontSize: 12.8,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
            ),
    );
  }
}
