import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:com.quizeee.quizeee/main.dart';
import 'package:com.quizeee.quizeee/provider/mainPro.dart';
import 'package:com.quizeee.quizeee/screens/homeScreen/component/quiz_question/solution_screen.dart';
import 'package:com.quizeee.quizeee/screens/homeScreen/component/rules_screen.dart';
import 'package:com.quizeee.quizeee/screens/tabs_screen.dart';
import 'package:com.quizeee.quizeee/widgets/centerLoader.dart';

import '../../../constant.dart';
import 'lets_start_or_play_practice_quiz.dart';
import 'quiz_practice/practiceQuestion_screen.dart';

class QuizResult extends StatelessWidget {
  final bool isPracticeQuiz;
  final bool isAssigned;
  final bool isViewMore;

  // final int pointsScored;
  // final int totalPoints;

  QuizResult({this.isPracticeQuiz, this.isAssigned, this.isViewMore});

  Future<bool> willPop(BuildContext context) async {
    if (isViewMore ?? false) {
      Navigator.of(context).pop();
    } else {
      final mainPro = Provider.of<MainPro>(context, listen: false);
      mainPro.changeLoadingState(true);
      await mainPro.getDashBoardData();
      mainPro.changeLoadingState(false);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (ctx) => TabMainScreen()),
          (route) => false);
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        return willPop(context);
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          elevation: 0,
          leading: Container(
            height: 45,
            width: 40,
            margin: EdgeInsets.only(
                left: mq.width * 0.022,
                right: mq.width * 0.022,
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
                willPop(context);
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
        body: SafeArea(
          child: isPracticeQuiz
              ? Consumer<MainPro>(builder: (context, mainPro, _) {
                  var selectedQuiz = mainPro.selectedPracQuizData;
                  return Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: mq.height * 0.085,
                            child: Image.asset('assets/images/stars.png'),
                          ),
                          Text(
                            'COMPLETED',
                            style: TextStyle(
                                fontFamily: 'DebugFreeTrial',
                                color: kResultColor,
                                fontSize: 30),
                          ),
                          SizedBox(
                            height: mq.height * 0.01,
                          ),
                          Text(
                            '${selectedQuiz[0].quizCategory} QUIZZ',
                            style:
                                TextStyle(color: kSecondaryColor, fontSize: 17),
                          ),
                          SizedBox(
                            height: mq.height * 0.02,
                          ),
                          Container(
                            height: mq.height * 0.14,
                            child: Image.asset('assets/images/cartoon.png'),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: mq.height * 0.02,
                              ),
                              Text(
                                'Congratulations !!',
                                style: TextStyle(
                                    fontFamily: 'DebugFreeTrial',
                                    color: kResultColor,
                                    fontSize: 25),
                              ),
                              SizedBox(
                                height: mq.height * 0.01,
                              ),
                              Text(
                                'You have passed the ${selectedQuiz[0].quizCategory} Quiz',
                                style: TextStyle(
                                    color: kSecondaryColor, fontSize: 15),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: mq.height * 0.04,
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  isPracticeQuiz
                                      ? Icon(
                                          Icons.account_balance_wallet,
                                          color: kResultColor,
                                        )
                                      : Container(),
                                  Text(
                                    'YOUR SCORE',
                                    style: TextStyle(
                                        color: kSecondaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: mq.height * 0.01,
                                  ),
                                  Text(
                                    '${isViewMore ?? false ? mainPro.userRank[0].score : mainPro.score}/${mainPro.selectedPracQuizData.length}',
                                    style: TextStyle(
                                        color: kResultColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  isPracticeQuiz
                                      ? Icon(
                                          Icons.account_balance_wallet,
                                          color: kResultColor,
                                        )
                                      : Container(),
                                  Text(
                                    'RESPONSE TIME',
                                    style: TextStyle(
                                        color: kSecondaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: mq.height * 0.01,
                                  ),
                                  Text(
                                    '${isViewMore ?? false ? mainPro.userRank[0].responseTime : mainPro.responseTime}sec',
                                    style: TextStyle(
                                        color: kResultColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          SizedBox(
                            height: mq.height * 0.01,
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              isPracticeQuiz
                                  ? buildPlayAgain(
                                      mq, context, mainPro, isViewMore ?? false)
                                  : buildReviewSolution(mq, context),
                              isPracticeQuiz
                                  ? buildBackToQuiz(mq, context, mainPro)
                                  : buildPlayMoreQuiz(mq, context),
                            ],
                          ),
                          SizedBox(
                            height: mq.height * 0.1,
                          ),
                        ],
                      ),
                      mainPro.isLoading
                          ? CenterLoader(
                              isScaffoldRequired: false,
                            )
                          : Container(
                              // color: Colors.transparent,
                              )
                    ],
                  );
                })
              : Consumer<MainPro>(builder: (context, mainPro, _) {
                  var rankDetails = mainPro.userRank[0];
                  var selectedQuiz = mainPro.selectedData;
                  return Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: mq.height * 0.085,
                            child: Image.asset('assets/images/stars.png'),
                          ),
                          Text(
                            'COMPLETED',
                            style: TextStyle(
                                fontFamily: 'DebugFreeTrial',
                                color: kResultColor,
                                fontSize: 30),
                          ),
                          SizedBox(
                            height: mq.height * 0.01,
                          ),
                          Text(
                            '${selectedQuiz.quizCategory} QUIZZ',
                            style:
                                TextStyle(color: kSecondaryColor, fontSize: 17),
                          ),
                          SizedBox(
                            height: mq.height * 0.02,
                          ),
                          Container(
                            height: mq.height * 0.14,
                            child: Image.asset('assets/images/cartoon.png'),
                          ),
                          isPracticeQuiz == true
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: mq.height * 0.02,
                                    ),
                                    Text(
                                      'Congratulations !!',
                                      style: TextStyle(
                                          fontFamily: 'DebugFreeTrial',
                                          color: kResultColor,
                                          fontSize: 25),
                                    ),
                                    SizedBox(
                                      height: mq.height * 0.01,
                                    ),
                                    Text(
                                      'You have passed the ${selectedQuiz.quizCategory} Quiz',
                                      style: TextStyle(
                                          color: kSecondaryColor, fontSize: 15),
                                    ),
                                  ],
                                )
                              : Container(),
                          SizedBox(
                            height: mq.height * 0.04,
                          ),
                          isPracticeQuiz
                              ? Container()
                              : Text(
                                  '#${rankDetails.rank}rd',
                                  style: TextStyle(
                                      color: kResultColor,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600),
                                ),
                          isPracticeQuiz
                              ? Container()
                              : Text(
                                  'RANK',
                                  style: TextStyle(
                                      color: kResultColor,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600),
                                ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  isPracticeQuiz
                                      ? Icon(
                                          Icons.account_balance_wallet,
                                          color: kResultColor,
                                        )
                                      : Container(),
                                  Text(
                                    'YOUR SCORE',
                                    style: TextStyle(
                                        color: kSecondaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: mq.height * 0.01,
                                  ),
                                  Text(
                                    // total questions
                                    '${rankDetails.score}/${mainPro.selectedData.questions.length}',
                                    style: TextStyle(
                                        color: kResultColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  isPracticeQuiz
                                      ? Icon(
                                          Icons.account_balance_wallet,
                                          color: kResultColor,
                                        )
                                      : Container(),
                                  Text(
                                    'RESPONSE TIME',
                                    style: TextStyle(
                                        color: kSecondaryColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: mq.height * 0.01,
                                  ),
                                  Text(
                                    '${rankDetails.responseTime}sec',
                                    style: TextStyle(
                                        color: kResultColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          isAssigned ?? false
                              ? Container()
                              : Text(
                                  'PRIZE WON',
                                  style: TextStyle(
                                      color: kSecondaryColor,
                                      fontWeight: FontWeight.w600),
                                ),
                          isAssigned ?? false
                              ? Container()
                              : SizedBox(
                                  height: mq.height * 0.01,
                                ),
                          isAssigned ?? false
                              ? Container()
                              : Text(
                                  '₹ ${mainPro.selectedData.winningPrize}/ -',
                                  style: TextStyle(
                                      color: kResultColor,
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600),
                                ),
                          isAssigned ?? false ? Container() : Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              isPracticeQuiz
                                  ? buildPlayAgain(
                                      mq, context, mainPro, isViewMore ?? false)
                                  : buildReviewSolution(mq, context),
                              isPracticeQuiz
                                  ? buildBackToQuiz(mq, context, mainPro)
                                  : buildPlayMoreQuiz(mq, context),
                            ],
                          ),
                          SizedBox(
                            height: mq.height * 0.1,
                          ),
                        ],
                      ),
                      mainPro.isLoading
                          ? CenterLoader(
                              isScaffoldRequired: false,
                            )
                          : Container(
                              // color: Colors.transparent,
                              )
                    ],
                  );
                }),
        ),
      ),
    );
  }

  Widget buildPlayAgain(Size mq, BuildContext context, MainPro mainPro,
      [bool isViewMore]) {
    return SizedBox(
      height: mq.height * 0.058,
      width: mq.width * 0.45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          if (isViewMore ?? false) {
            willPop(context);
          } else {
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (ctx) => RulesScreen(
                  isPracticeQuiz: true,
                ),
              ),
            );
          }
        },
        child: Text(
          isViewMore ?? false ? 'REVIEW SOLUTION' : 'PLAY AGAIN',
          style: TextStyle(
            color: kPrimaryColor,
            fontFamily: 'DebugFreeTrial',
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget buildBackToQuiz(Size mq, BuildContext context, MainPro mainPro) {
    return SizedBox(
      height: mq.height * 0.058,
      width: mq.width * 0.45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () async {
          final mainPro = Provider.of<MainPro>(context, listen: false);
          mainPro.changeLoadingState(true);
          await mainPro.getDashBoardData();
          mainPro.changeLoadingState(false);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) => TabMainScreen()),
              (route) => false);
          // Navigator.of(context).pushReplacement(
          //   CupertinoPageRoute(
          //     builder: (ctx) => LetsStartOrPlayPracticeQuiz(
          //       data: mainPro.selectedData,
          //     ),
          //   ),
          // );
        },
        child: Text(
          'BACK TO QUIZ',
          style: TextStyle(
              color: kPrimaryColor, fontFamily: 'DebugFreeTrial', fontSize: 18),
        ),
      ),
    );
  }

  Widget buildPlayMoreQuiz(Size mq, BuildContext context) {
    return SizedBox(
      height: mq.height * 0.058,
      width: mq.width * 0.45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () async {
          final mainPro = Provider.of<MainPro>(context, listen: false);
          mainPro.changeLoadingState(true);
          await mainPro.getDashBoardData();
          mainPro.changeLoadingState(false);
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (ctx) => TabMainScreen()),
              (route) => false);
        },
        child: Text(
          'PLAY MORE QUIZ',
          style: TextStyle(
              color: kPrimaryColor, fontFamily: 'DebugFreeTrial', fontSize: 18),
        ),
      ),
    );
  }

  Widget buildReviewSolution(Size mq, BuildContext context) {
    return SizedBox(
      height: mq.height * 0.058,
      width: mq.width * 0.45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Provider.of<MainPro>(context, listen: false).clearQuizData();
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (ctx) => SolutionScreen(),
            ),
          );
        },
        child: Text(
          'REVIEW SOLUTIONS',
          style: TextStyle(
              color: kPrimaryColor, fontFamily: 'DebugFreeTrial', fontSize: 18),
        ),
      ),
    );
  }
}
