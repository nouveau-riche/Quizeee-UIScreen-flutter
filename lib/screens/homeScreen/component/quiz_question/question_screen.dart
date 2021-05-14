import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizeee_ui/provider/mainPro.dart';
import 'package:quizeee_ui/screens/tabs_screen.dart';
import 'package:quizeee_ui/widgets/centerLoader.dart';
import 'package:quizeee_ui/widgets/toast.dart';

import '../../../../constant.dart';
import '../../../../main.dart';
import '../quiz_result.dart';

class QuizQuestion extends StatefulWidget {
  final MainPro mainPro;
  final String quizName;
  final String question;
  final List<String> options;

  QuizQuestion({this.quizName, this.question, this.options, this.mainPro});

  @override
  _QuizQuestionState createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion> {
  void userExitsQuiz() {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    toast("We are taking you out of the quiz!", isError: true);
    mainPro.clearQuizData();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mainPro = Provider.of<MainPro>(context, listen: false);

    final mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
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
              userExitsQuiz();
              // Navigator.of(context).pop();
            },
          ),
        ),
        title: Consumer<MainPro>(builder: (context, mainPro, _) {
          return Text(
            '${mainPro.selectedData.quizSubCategory} QUIZ',
            style: TextStyle(
              color: kSecondaryColor,
              fontFamily: 'DebugFreeTrial',
              fontSize: 30,
            ),
          );
        }),
      ),
      body: Consumer<MainPro>(
        builder: (con, loading, _) => Stack(
          children: [
            Column(
              children: [
                Selector<MainPro, int>(
                    selector: (context, main) => main.currentQuestionIndex,
                    builder: (context, index, _) {
                      return Column(
                        children: [
                          SizedBox(
                            height: mq.height * 0.01,
                          ),
                          buildQuestionNumberIndicator(mq, index + 1,
                              mainPro.selectedData.questions.length),
                          SizedBox(
                            height: mq.height * 0.1,
                          ),
                          Column(
                            children: List.generate(
                                mainPro.selectedData.questions[index].options
                                    .length, (i) {
                              var questions =
                                  mainPro.selectedData.questions[index];
                              var options = mainPro
                                  .selectedData.questions[index].options[i];
                              return Column(
                                children: [
                                  i == 0
                                      ? Container(
                                          padding: EdgeInsets.only(
                                              bottom: mq.height * 0.04),
                                          width: mq.width * 0.7,
                                          child: Center(
                                            child: Text(
                                              'Q${index + 1} : ${questions.quesText}',
                                              style: TextStyle(
                                                  color: kPrimaryLightColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  buildOption('$options', mq, i),
                                ],
                              );
                            }),
                          ),
                          // Expanded(
                          //   child: ListView.builder(
                          //     itemBuilder: (ctx, index) => ),
                          //     itemCount: 4,
                          //   ),
                          // ),
                          SizedBox(
                            height: mq.height * 0.04,
                          ),

                          // SizedBox(
                          //   height: mq.height * 0.1,
                          // ),
                        ],
                      );
                    }),
                QuestionSeconds(),

                // SizedBox(height: mq.height*0.1,),
              ],
            ),
            loading.isLoading
                ? CenterLoader(
                    isScaffoldRequired: false,
                  )
                : Container(
                    // color: Colors.transparent,
                    )
          ],
        ),
      ),
    );
  }

  Widget buildQuestionNumberIndicator(Size mq, int current, int total) {
    int percentage = (100 * current) ~/ total;
    print(percentage);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 4,
          width: mq.width * 0.88,
          decoration: BoxDecoration(
            color: kSecondaryColor.withOpacity(0.4),
            borderRadius: BorderRadius.circular(2),
          ),
          child: Row(
            children: [
              Container(
                width: ((mq.width * 0.88 * percentage) ~/ 100).toDouble(),
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(2),
                      bottomRight: Radius.circular(2)),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        kPrimaryLightColor.withOpacity(0.1),
                        kPrimaryLightColor
                      ]),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          '$current out of $total',
          style: TextStyle(
              color: kPrimaryLightColor.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildOption(String option, Size mq, int index) {
    return Consumer<MainPro>(builder: (context, main, _) {
      return GestureDetector(
        onTap: () {
          if (!main.enableButton) {
            main.setSelectedOption(index);
            main.makeSelections(index);
          }
          // if (main.enableButton) {
          //   main.makeSelections(index);
          //   toast("Cant select now!", isError: true);
          // } else {
          //   print("Selected");
          // }
        },
        child: Container(
          height: mq.height * 0.07,
          margin: EdgeInsets.symmetric(
              vertical: mq.height * 0.015, horizontal: mq.width * 0.08),
          decoration: BoxDecoration(
            // add some functionality to add border and change color of text if selected

            border: main.selectedOption != null
                ? Border.all(
                    width: 1.5,
                    color: main.selectedOption == index
                        ? kPrimaryLightColor
                        : Colors.transparent)
                : Border.all(color: Colors.transparent),
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

              color: main.selectedOption == index
                  ? kPrimaryLightColor
                  : kSecondaryColor,
              fontFamily: 'DebugFreeTrial',
            ),
          )),
        ),
      );
    });
  }
}

class QuestionSeconds extends StatefulWidget {
  QuestionSeconds({
    Key key,
  }) : super(key: key);

  @override
  _QuestionSecondsState createState() => _QuestionSecondsState();
}

class _QuestionSecondsState extends State<QuestionSeconds>
    with SingleTickerProviderStateMixin {
  Timer _timer;

  AnimationController _controller;
  Animation _animation;

  int seconds = 5; // change
  @override
  void initState() {
    super.initState();
    startRolling();
    startTimmer();
  }

  void startRolling() {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    seconds = mainPro.selectedData.timePerQues;
    _controller = AnimationController(
      duration: Duration(seconds: seconds),
      vsync: this,
    )..repeat();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

  void startTimmer() {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    mainPro.resetSeconds();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (mainPro.seconds == 0) {
        timer.cancel();
        enableButton();
      } else {
        mainPro.decrementSeconds();
      }
    });
  }

  Future<void> enableButton() async {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    mainPro.enableButtonAns(true);
    toast("Times Up!", isError: false);
    if (mainPro.enableButton) {
      if (mainPro.incrementQuestions()) {
        toast("Quiz Completed", isError: false);
        mainPro.calculateTotalScore();
        _controller.stop();
        mainPro.changeLoadingState(true);
        final response = await mainPro.submitQuizResult();
        mainPro.changeLoadingState(false);
        if (response['status']) {
          Navigator.of(context).pushReplacement(CupertinoPageRoute(
            builder: (ctx) => QuizResult(
              isPracticeQuiz: false,
            ),
          ));
        } else {
          buildAlertBoxForPayNow(context, response['message']);
        }
        // Navigate to next Screen

      } else {
        mainPro.enableButtonAns(false);
        print("Show must go on!!");
        startTimmer();
      }
    }
  }

  buildAlertBoxForPayNow(BuildContext context, String msg) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: Text(
          msg,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (ctx) => NavigateScreen()),
                  (route) => false);
            },
            child: Text(
              'OK',
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    this.deactivate();
    super.dispose();
    _controller.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Selector<MainPro, int>(
      selector: (context, main) => main.seconds,
      builder: (context, enableButton, _) => Container(
        height: mq.height * 0.1,
        width: mq.width * 0.25,
        child: Stack(
          children: [
            RotationTransition(
              turns: _animation,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    height: mq.height * 0.14,
                    width: mq.height * 0.14,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          kPrimaryLightColor,
                          kPrimaryColor.withOpacity(0.3)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      height: mq.height * 0.1,
                      width: mq.height * 0.1,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -4,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimaryLightColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              child: Text(
                '${enableButton}s',
                style: TextStyle(
                    color: kPrimaryLightColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
