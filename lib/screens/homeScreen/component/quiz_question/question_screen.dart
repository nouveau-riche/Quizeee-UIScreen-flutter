import 'package:flutter/material.dart';

import '../../../../constant.dart';
import 'timer_animation.dart';

class QuizQuestion extends StatelessWidget {
  final String quizName;
  final String question;
  final List<String> options;

  QuizQuestion({this.quizName, this.question, this.options});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        leading: Container(
          height: 45,
          width: 40,
          margin: EdgeInsets.only(
            left: mq.width * 0.024,
            right: mq.width * 0.024,
            top: 7,
            bottom: 7,
          ),
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
          '$quizName QUIZ',
          style: TextStyle(
            color: kSecondaryColor,
            fontFamily: 'DebugFreeTrial',
            fontSize: 30,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: mq.height * 0.01,
          ),
          buildQuestionNumberIndicator(mq),
          SizedBox(
            height: mq.height * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: mq.width * 0.7,
                child: Center(
                  child: Text(
                    'Q1. Which city is Indian city?',
                    style: TextStyle(
                        color: kPrimaryLightColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: mq.height * 0.04,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) => buildOption('JAIPUR', mq),
              itemCount: 4,
            ),
          ),
          WidgetCircularAnimator(
            // outerColor: kPrimaryLightColor,
            innerColor: kPrimaryLightColor,
            child: Center(
              child: Text(
                '10s',
                style: TextStyle(
                    color: kPrimaryLightColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          SizedBox(
            height: mq.height * 0.1,
          ),
        ],
      ),
    );
  }

  Widget buildQuestionNumberIndicator(Size mq) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 4,
          width: mq.width * 0.88,
          decoration: BoxDecoration(
            color: kSecondaryColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          '1 out of 10',
          style: TextStyle(
              color: kPrimaryLightColor.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildOption(String option, Size mq) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: mq.height * 0.07,
        margin: EdgeInsets.symmetric(
            vertical: mq.height * 0.015, horizontal: mq.width * 0.08),
        decoration: BoxDecoration(
          // add some functionality to add border and change color of text if selected

          border: Border.all(width: 1, color: kPrimaryLightColor),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.grey.withOpacity(0.2),
              Colors.grey.withOpacity(0.1),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Text(
          option,
          style: TextStyle(
            fontSize: 26,

            // if selected change this color to kPrimaryLightColor

            color: kSecondaryColor,
            fontFamily: 'DebugFreeTrial',
          ),
        )),
      ),
    );
  }
}
