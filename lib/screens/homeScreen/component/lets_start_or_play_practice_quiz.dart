import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizeee_ui/screens/homeScreen/component/rules_screen.dart';

import '../../../constant.dart';

class LetsStartOrPlayPracticeQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          SizedBox(
            height: mq.height * 0.04,
          ),
          buildAppBar(context, mq.width * 0.045),
          SizedBox(
            height: mq.height * 0.14,
          ),
          Text(
            'LET\'S START',
            style: TextStyle(
                color: kPrimaryLightColor,
                fontSize: 35,
                fontFamily: 'RapierZero'),
          ),
          SizedBox(
            height: mq.height * 0.07,
          ),
          Text(
            'Time remaining',
            style: TextStyle(
                color: kSecondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: mq.height * 0.015,
          ),
          buildQuizTime(mq.height * 0.052, mq.width * 0.45),
          Spacer(),
          buildNextNow(mq, context),
          SizedBox(
            height: mq.height * 0.1,
          ),
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context, double margin) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 45,
          width: 40,
          margin: EdgeInsets.only(left: margin),
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
        Container(
          width: 42,
          margin: EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 7),
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset('assets/images/profile.png'),
          ),
        ),
      ],
    );
  }

  Widget buildQuizTime(double height, double width) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(top: 2),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Center(
        child: Text(
          'time',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildNextNow(Size mq, BuildContext context) {
    return SizedBox(
      height: mq.height * 0.058,
      width: mq.width * 0.55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.of(context)
              .push(CupertinoPageRoute(builder: (ctx) => RulesScreen()));
        },
        child: Text(
          'NEXT',
          style: TextStyle(
            color: kPrimaryColor,
            fontFamily: 'DebugFreeTrial',
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
