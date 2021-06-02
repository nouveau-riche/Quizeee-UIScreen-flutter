import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:provider/provider.dart';
import 'package:quizeee_ui/provider/mainPro.dart';
import 'package:quizeee_ui/screens/homeScreen/component/rules_screen.dart';
import 'package:quizeee_ui/widgets/centerLoader.dart';
import 'package:quizeee_ui/widgets/toast.dart';

import '../../../constant.dart';
import '../../tabs_screen.dart';

class LetsStartOrPlayPracticeQuiz extends StatelessWidget {
  final dynamic data;

  const LetsStartOrPlayPracticeQuiz({Key key, @required this.data})
      : super(key: key);

  Future<void> setData(BuildContext context) async {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    mainPro.showCountDownTimer = false;
    mainPro.quizStarted = false;
    DateTime startDate =
        DateTime.fromMillisecondsSinceEpoch(int.parse(data.startDate));
    final difference = startDate.difference(DateTime.now()).inDays;
    if (difference <= 1) {
      // show countDownTimer
      mainPro.switchToCountDown(true);
      mainPro.switchQuizStarted(false);
    } else {
      // show dateTime in format
      mainPro.switchToCountDown(false);
      mainPro.switchQuizStarted(false);
    }
    // }
  }

  Future<void> playPracticeQuiz(BuildContext context) async {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    mainPro.changeLoadingState(true);
    final resp =
        await mainPro.getPracticeQuiz(data.questions.length, "Science");
    mainPro.changeLoadingState(false);

    if (!resp['status']) {
      toast(resp['message'], isError: true);
    } else {
      mainPro.saveDataForQuestions(data);
      mainPro.saveDataForPracQuestions(mainPro.pracQuiz);
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(
            builder: (ctx) => RulesScreen(
                  isPracticeQuiz: true,
                )));
      });
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
          builder: (con, mainPro, _) => Stack(
            children: [
              Column(
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
                              endTime: int.parse(data.startDate),
                              // endTime: DateTime.now()
                              //     .add(Duration(seconds: 10))
                              //     .millisecondsSinceEpoch,
                              onEnd: () {
                                mainPro.switchQuizStarted(true);
                                mainPro.saveDataForQuestions(data);
                                toast("Let's begin...", isError: false);
                                Future.delayed(Duration(seconds: 1), () {
                                  Navigator.of(context)
                                      .pushReplacement(CupertinoPageRoute(
                                          builder: (ctx) => RulesScreen(
                                                isPracticeQuiz: false,
                                              )));
                                });
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
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (ctx) => RulesScreen(
                                    isPracticeQuiz: false,
                                  )));
                        } else {
                          playPracticeQuiz(context);
                          // toast("Navigate to practive quiz", isError: false);
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
              mainPro.isLoading
                  ? CenterLoader(isScaffoldRequired: false)
                  : Container()
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
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => TabMainScreen()),
                  (route) => false);
            },
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
