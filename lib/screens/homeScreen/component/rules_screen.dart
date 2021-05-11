import 'package:flutter/material.dart';

import '../../../constant.dart';

class RulesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: Container(
          height: 45,
          width: 40,
          margin: EdgeInsets.only(
              left: mq.width * 0.018,
              right: mq.width * 0.018,
              top: 4,
              bottom: 4),
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
        title: Text(
          'RULES FOR GAME',
          style: TextStyle(color: kSecondaryColor),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: mq.height * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Read the instructions carefully',
                style: TextStyle(
                    color: kSecondaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 17),
              ),
            ],
          ),
          SizedBox(
            height: mq.height * 0.06,
          ),
          buildRule('THERE WILL BE TOTAL 10 QUESTIONS'),
          SizedBox(
            height: mq.height * 0.03,
          ),
          buildRule('EACH QUESTION WILL BE GIVEN 10 SECONDS\nTO ANSWER'),
          SizedBox(
            height: mq.height * 0.03,
          ),
          buildRule(
              'YOU HAVE TO SUBMIT YOUR ANSWER ONLY\nWHEN THE WINDOW IS OPEN'),
          SizedBox(
            height: mq.height * 0.03,
          ),
          buildRule('YOU CAN ONLY SUBMIT ONCE'),
          SizedBox(
            height: mq.height * 0.03,
          ),
          buildRule(
              'PAYMENTS WILL BE DIRECTLY CREDITED TO\nTHE WALLET OF THE USER'),
          Spacer(),
          buildStartQuiz(mq, context),
          SizedBox(
            height: mq.height * 0.1,
          ),
        ],
      ),
    );
  }

  Widget buildRule(String rule) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 18,
          width: 18,
          margin: EdgeInsets.only(left: 20, right: 10),
          decoration: BoxDecoration(
            color: kPrimaryLightColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          child: Text(
            rule,
            style: TextStyle(
              fontFamily: 'DebugFreeTrial',
              color: kPrimaryLightColor,
              fontSize: 25,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildStartQuiz(Size mq, BuildContext context) {
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
        onPressed: () {},
        child: Text(
          'START THE QUIZ',
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
