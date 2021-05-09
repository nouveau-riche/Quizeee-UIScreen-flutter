import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:quizeee_ui/provider/initialPro.dart';
import 'package:quizeee_ui/provider/states.dart';
import '../../provider/initialPro.dart';
import '../../constant.dart';
import '../otp/otp_screen.dart';
import '../signup/signup_screen.dart';
import '../../widgets/toast.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: kPrimaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: mq.height * 0.07,
              ),
              Container(
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
                'LOGIN',
                style: TextStyle(
                  color: kTextColor,
                  fontFamily: 'DebugFreeTrial',
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: mq.height * 0.07,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildCountryCode(mq.width * 0.17),
                  buildPhoneNumberField(mq.width * 0.74),
                ],
              ),
              SizedBox(
                height: mq.height * 0.05,
              ),
              const Text(
                'IF YOU ARE NEW PLAYER',
                style: TextStyle(
                  color: kTextColor,
                  fontFamily: 'RapierZero',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: mq.height * 0.005,
              ),
              TextButton(
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'DebugFreeTrial',
                    fontWeight: FontWeight.w500,
                    color: kSecondaryColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    CupertinoPageRoute(builder: (ctx) => SignUpScreen()),
                  );
                },
              ),
              SizedBox(
                height: mq.height * 0.1,
              ),
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.5),
                  color: kSecondaryColor,
                  border: Border.all(color: kTextColor),
                ),
              ),
              SizedBox(
                height: mq.height * 0.015,
              ),
              RichText(
                text: const TextSpan(
                  text: "By registering, you accept the ",
                  children: [
                    const TextSpan(
                      text: "PRIVACY POLICY & TERMS AND CONDITIONS",
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: 10,
                      ),
                    ),
                  ],
                  style: TextStyle(color: kSecondaryColor, fontSize: 10),
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                'OF QUIZEEE',
                style: TextStyle(
                  fontSize: 10,
                  color: kSecondaryColor,
                ),
              ),
              SizedBox(
                height: mq.height * 0.035,
              ),
              buildNextButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCountryCode(double width) {
    return Container(
      width: width,
      height: 55,
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 20,
            width: 20,
            child: Image.asset('assets/images/flag.png'),
          ),
          const Text(
            '+91',
            style: TextStyle(fontSize: 13.1, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget buildPhoneNumberField(double width) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: width,
      height: 55,
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.black,
        style: const TextStyle(fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
          hintText: 'ENTER MOBILE NUMBER OR EMAIL',
          hintStyle: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              height: 1.5),
          enabledBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.black26),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
        controller: _controller,
      ),
    );
  }

  Widget buildNextButton(BuildContext context) {
    return Consumer<Auth>(
      builder: (con, auth, _) => auth.isLoading
          ? CircularProgressIndicator()
          : ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 68, height: 55),
              child: ElevatedButton(
                onPressed: () {
                  login(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  primary: kTextColor,
                ),
                child: const Text(
                  'NEXT',
                  style: const TextStyle(
                      fontSize: 12.8,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
            ),
    );
  }

  /// add logic for login in this method
  void login(BuildContext context) async {
    bool emailValid = emailValidatorRegExp.hasMatch(_controller.text);

    if (_controller.text.isEmpty ||
        (_controller.text.length != 10 && emailValid == false)) {
      // show toast when user give invalid credentials
      toast('Enter Correct phone or email', isError: true);
    } else {
      var body;
      if (_controller.text.contains("@")) {
        body = {"email": _controller.text};
      } else {
        body = {"phone": "+91" + _controller.text};
      }
      final authPro = Provider.of<Auth>(context, listen: false);
      authPro.setLoading(true);
      final response = await authPro.sendVerificationOtp(body, true);
      authPro.setLoading(false);

      if (response['status']) {
        toast(response['message'], isError: false);
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (ctx) => OTPScreen(
                type: 'login',
                phone: _controller.text,
                otp: response['otp'],
              ),
            ),
          );
        });
      } else {
        toast(response['msg'], isError: true);
      }
    }
  }
}
