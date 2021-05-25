import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:quizeee_ui/provider/mainPro.dart';
import 'package:quizeee_ui/screens/homeScreen/component/quiz_question/question_screen.dart';

import '../../../constant.dart';
import 'quiz_practice/practiceQuestion_screen.dart';

class RulesScreen extends StatefulWidget {
  final bool isPracticeQuiz;

  const RulesScreen({Key key, @required this.isPracticeQuiz}) : super(key: key);
  @override
  _RulesScreenState createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  int timmer = 5;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    Timer.periodic(Duration(seconds: 1), (_timer) {
      if (timmer == 0) {
        _timer.cancel();
        navigateToQuiz();
      } else {
        setState(() => timmer -= 1);
      }
    });
  }

  navigateToQuiz() {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    mainPro.clearQuizData();
    if (widget.isPracticeQuiz) {
      mainPro.intializeAnswersListPractice();

      Navigator.of(context)
          .push(CupertinoPageRoute(builder: (ctx) => PracticeQuizQuestion()));
    } else {
      mainPro.intializeAnswersList();

      Navigator.of(context)
          .push(CupertinoPageRoute(builder: (ctx) => QuizQuestion()));
    }
  }

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
              bottom: 7),
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
          buildRule('THERE WILL BE TOTAL 10 QUESTIONS', mq),
          SizedBox(
            height: mq.height * 0.03,
          ),
          buildRule('EACH QUESTION WILL BE GIVEN 10 SECONDS TO ANSWER', mq),
          SizedBox(
            height: mq.height * 0.03,
          ),
          buildRule(
              'YOU HAVE TO SUBMIT YOUR ANSWER ONLY WHEN THE WINDOW IS OPEN',
              mq),
          SizedBox(
            height: mq.height * 0.03,
          ),
          buildRule('YOU CAN ONLY SUBMIT ONCE', mq),
          SizedBox(
            height: mq.height * 0.03,
          ),
          buildRule(
              'PAYMENTS WILL BE DIRECTLY CREDITED TO THE WALLET OF THE USER',
              mq),
          Spacer(),
          buildStartQuiz(mq, context),
          SizedBox(
            height: mq.height * 0.1,
          ),
        ],
      ),
    );
  }

  Widget buildRule(String rule, Size mq) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 14,
          width: 14,
          margin: EdgeInsets.only(left: 20, right: 10),
          decoration: BoxDecoration(
            color: kPrimaryLightColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Container(
          width: mq.width * 0.8,
          child: Text(
            rule,
            style: TextStyle(
              fontFamily: 'DebugFreeTrial',
              color: kPrimaryLightColor,
              fontSize: 22,
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
          'QUIZ STARTS IN $timmer',
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
