import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../constant.dart';
import './signup_form.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: mq.height * 0.06,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 45,
                  width: 40,
                  margin: EdgeInsets.only(left: 25),
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
                SizedBox(
                  width: mq.width * 0.18,
                ),
                Container(
                  height: mq.height * 0.15,
                  width: mq.width * 0.3,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            const Text(
              'QUIZEEE',
              style: const TextStyle(
                  color: kTextColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SairaStencilOne',
                  decoration: TextDecoration.underline),
            ),
            const Text(
              'SIGN UP',
              style: TextStyle(
                color: kTextColor,
                fontFamily: 'Bungee',
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: mq.height * 0.03,
            ),
            SignUpForm(),
          ],
        ),
      ),
    );
  }
}
