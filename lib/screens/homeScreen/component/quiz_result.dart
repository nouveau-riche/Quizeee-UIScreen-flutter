import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizeee_ui/main.dart';
import 'package:quizeee_ui/provider/mainPro.dart';
import 'package:quizeee_ui/screens/homeScreen/component/quiz_question/solution_screen.dart';
import 'package:quizeee_ui/screens/tabs_screen.dart';
import 'package:quizeee_ui/widgets/centerLoader.dart';

import '../../../constant.dart';

class QuizResult extends StatelessWidget {
  final bool isPracticeQuiz;

  // final int pointsScored;
  // final int totalPoints;

  QuizResult({this.isPracticeQuiz});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
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
      body: SafeArea(
        child: Consumer<MainPro>(builder: (context, mainPro, _) {
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
                    style: TextStyle(color: kSecondaryColor, fontSize: 17),
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
                              'You Have Passed The Practice Test',
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
                            '${rankDetails.score}/100',
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
                  Text(
                    'PRIZE WON',
                    style: TextStyle(
                        color: kSecondaryColor, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: mq.height * 0.01,
                  ),
                  Text(
                    '₹ ${rankDetails.prize}/ -',
                    style: TextStyle(
                        color: kResultColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      isPracticeQuiz
                          ? buildPlayAgain(mq, context)
                          : buildReviewSolution(mq, context),
                      isPracticeQuiz
                          ? buildBackToQuiz(mq, context)
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
    );
  }

  Widget buildPlayAgain(Size mq, BuildContext context) {
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
        onPressed: () {},
        child: Text(
          'PLAY AGAIN',
          style: TextStyle(
            color: kPrimaryColor,
            fontFamily: 'DebugFreeTrial',
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget buildBackToQuiz(Size mq, BuildContext context) {
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
        onPressed: () {},
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
