import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:provider/provider.dart';
import 'package:quizeee_ui/provider/mainPro.dart';
import 'package:quizeee_ui/screens/homeScreen/component/rules_screen.dart';
import 'package:quizeee_ui/widgets/toast.dart';

import '../../../constant.dart';

class LetsStartOrPlayPracticeQuiz extends StatelessWidget {
  final dynamic data;

  const LetsStartOrPlayPracticeQuiz({Key key, @required this.data})
      : super(key: key);

  Future<void> setData(BuildContext context) async {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    mainPro.showCountDownTimer = false;
    mainPro.quizStarted = false;
    DateTime startDate = data.startDate;
    if (startDate.isAfter(DateTime.now())) {
      // show LETS START

      mainPro.switchToCountDown(false);
      mainPro.switchQuizStarted(true);
    } else {
      // show WILL START AT
      final difference = DateTime.now().difference(startDate).inMinutes;
      if (difference <= 60) {
        // show countDownTimer
        mainPro.switchToCountDown(true);
        mainPro.switchQuizStarted(false);
      } else {
        // show dateTime in format
        mainPro.switchToCountDown(false);
        mainPro.switchQuizStarted(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: FutureBuilder(
        future: setData(context),
        builder: (
          con,
          snap,
        ) =>
            Consumer<MainPro>(
          builder: (con, mainPro, _) => Column(
            children: [
              SizedBox(
                height: mq.height * 0.04,
              ),
              buildAppBar(context, mq.width * 0.045),
              SizedBox(
                height: mq.height * 0.14,
              ),
              Text(
                mainPro.quizStarted ? 'LET\'S START' : "YOU ARE EARLY",
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
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: mq.height * 0.015,
              ),
              Container(
                height: mq.height * 0.052,
                width: mq.width * 0.45,
                margin: EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Center(
                  child: mainPro.showCountDownTimer
                      ? CountdownTimer(
                          endTime: DateTime.parse(data.startDate)
                              .millisecondsSinceEpoch,
                          onEnd: () {
                            mainPro.saveDataForQuestions(data);
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (ctx) => RulesScreen()));
                          },
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ))
                      : Text(
                          '${mainPro.formatDate(data.startDate)}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              Spacer(),
              SizedBox(
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
                    if (mainPro.quizStarted) {
                      mainPro.saveDataForQuestions(data);
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (ctx) => RulesScreen()));
                    } else {
                      toast("Navigate to practive quiz", isError: false);
                    }
                  },
                  child: Text(
                    mainPro.quizStarted ? 'NEXT' : "PRACTICE QUIZ",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontFamily: 'DebugFreeTrial',
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: mq.height * 0.07,
              ),
            ],
          ),
        ),
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
            child: Image.asset('assets/images/rules.png'),
          ),
        ),
      ],
    );
  }

  // Widget buildQuizTime(double height, double width,MainPro mainPro) {
  //   return
  // }

  // Widget buildNextNow(Size mq, BuildContext context,MainPro mainPro) {
  //   return ;
  // }
}
