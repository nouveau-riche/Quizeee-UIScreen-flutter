import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class CreateQuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(0, 44, 62, 1),
        centerTitle: true,
        title: const Text(
          'QUIZEEE',
          style: TextStyle(
              color: kTextColor,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: 'MajorLeagueDuty',
              decoration: TextDecoration.underline),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: mq.height * 0.02,
            ),
            const Text(
              'CREATE QUIZ',
              style: TextStyle(
                color: kSecondaryColor,
                fontSize: 40,
                fontFamily: 'DebugFreeTrial',
              ),
            ),
            SizedBox(
              height: mq.height * 0.02,
            ),
            Container(
              width: mq.width,
              margin: EdgeInsets.all(20),
              child: Text(
                'Create free quiz & play with your friends & family',
                style: TextStyle(fontSize: 28, color: kPrimaryLightColor),
              ),
            ),
            SizedBox(
              height: mq.height * 0.025,
            ),
            buildCreateNowButton(mq),
            SizedBox(
              height: mq.height * 0.08,
            ),
            Container(
              width: mq.width,
              margin: EdgeInsets.all(20),
              child: const Text(
                'If You Want to become an quizeee master or want to create quiz for your students?\nFor more information please connect with the admin',
                style: TextStyle(fontSize: 24, color: kPrimaryLightColor),
              ),
            ),
            SizedBox(
              height: mq.height * 0.025,
            ),
            buildConnectAdmin(mq),
          ],
        ),
      ),
    );
  }

  Widget buildCreateNowButton(Size mq) {
    return SizedBox(
      height: 46,
      width: mq.width * 0.5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {},
        child: Text(
          'Create Now',
          style: TextStyle(
            color: kPrimaryColor,
            fontFamily: 'DebugFreeTrial',
            fontSize: 28,
          ),
        ),
      ),
    );
  }

  Widget buildConnectAdmin(Size mq) {
    return SizedBox(
      height: 46,
      width: mq.width * 0.5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {},
        child: Text(
          'Connect Admin',
          style: TextStyle(
            color: kPrimaryColor,
            fontFamily: 'DebugFreeTrial',
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}
