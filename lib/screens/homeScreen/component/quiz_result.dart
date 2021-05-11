import 'package:flutter/material.dart';

import '../../../constant.dart';

class QuizResult extends StatelessWidget {
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
          'SCORE',
          style: TextStyle(
            color: kSecondaryColor,
            fontFamily: 'DebugFreeTrial',
            fontSize: 40,
          ),
        ),
      ),
      body: Column(
        children: [
          Text(
            'COMPLETED',
            style: TextStyle(
                fontFamily: 'DebugFreeTrial',
                color: kPrimaryLightColor,
                fontSize: 30),
          ),
          Text(
            'SCIENCE QUIZZ',
            style: TextStyle(color: kSecondaryColor, fontSize: 17),
          ),
          Text(
            'Congratulations !!',
            style: TextStyle(
                fontFamily: 'DebugFreeTrial',
                color: kPrimaryLightColor,
                fontSize: 25),
          ),
          Text(
            'You Have Passed The Practice Test',
            style: TextStyle(color: kSecondaryColor, fontSize: 15),
          ),
          Spacer(),
          Text(
            '#3rd',
            style: TextStyle(
                color: kPrimaryLightColor,
                fontSize: 28,
                fontWeight: FontWeight.w600),
          ),
          Text(
            'RANK',
            style: TextStyle(
                color: kPrimaryLightColor,
                fontSize: 28,
                fontWeight: FontWeight.w600),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: kPrimaryLightColor,
                  ),
                  Text(
                    'YOUR SCORE',
                    style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '90/100',
                    style: TextStyle(
                        color: kPrimaryLightColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: kPrimaryLightColor,
                  ),
                  Text(
                    'RESPONSE TIME',
                    style: TextStyle(
                        color: kSecondaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '65sec',
                    style: TextStyle(
                        color: kPrimaryLightColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
          Text(
            'PRIZE WON',
            style: TextStyle(
                color: kSecondaryColor,
                fontSize: 17,
                fontWeight: FontWeight.w600),
          ),
          Text(
            '   Rs. 90/ -',
            style: TextStyle(
                color: kPrimaryLightColor,
                fontSize: 24,
                fontWeight: FontWeight.w600),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildPlayAgain(mq, context),
              buildBackToQuiz(mq, context),
            ],
          ),
          SizedBox(
            height: mq.height * 0.1,
          ),
        ],
      ),
    );
  }

  Widget buildPlayAgain(Size mq, BuildContext context) {
    return SizedBox(
      height: mq.height * 0.058,
      width: mq.width * 0.42,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {},
        child: Text(
          'PLAY AGAIN',
          style: TextStyle(
            color: kPrimaryColor,
            fontFamily: 'DebugFreeTrial',
            fontSize: 30,
          ),
        ),
      ),
    );
  }

  Widget buildBackToQuiz(Size mq, BuildContext context) {
    return SizedBox(
      height: mq.height * 0.058,
      width: mq.width * 0.42,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {},
        child: Text(
          'BACK TO QUIZ',
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
