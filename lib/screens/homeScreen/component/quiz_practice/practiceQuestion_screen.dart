import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizeee_ui/provider/mainPro.dart';
import 'package:quizeee_ui/widgets/centerLoader.dart';
import 'package:quizeee_ui/widgets/toast.dart';

import '../../../../constant.dart';
import '../../../../main.dart';
import '../../../tabs_screen.dart';
import '../quiz_result.dart';

class PracticeQuizQuestion extends StatefulWidget {
  final String quizName;
  final String question;
  final List<String> options;

  PracticeQuizQuestion({this.quizName, this.question, this.options});

  @override
  _QuizQuestionState createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<PracticeQuizQuestion>
    with SingleTickerProviderStateMixin {
  void userExitsQuiz() {
    final main = Provider.of<MainPro>(context, listen: false);
    toast("We are taking you out of the quiz!", isError: true);
    main.clearQuizData();
    Navigator.pop(context);
  }

  Timer _timer;

  AnimationController _controller;
  Animation _animation;

  int seconds = 5 + 1; // change this duration according to api and + 1

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    startRolling();
    startTimmer();
  }

  void startTimmer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer _timer) {
      var timeinfo = Provider.of<MainPro>(context, listen: false);
      timeinfo.updateRemainingTimePractice(false);
    });
  }

  void nexQuestion() {
    final main = Provider.of<MainPro>(context, listen: false);
    //increment Question index
    if (main.currentPracQuestion == main.selectedPracQuizData.length - 1) {
      _timer.cancel();
      main.calculateTotalScore();
      // toast("Good job...", isError: false);
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(CupertinoPageRoute(
          builder: (ctx) => QuizResult(
            isPracticeQuiz: true,
          ),
        ));
      });
    } else {
      main.updateRemainingTimePractice(true);
    }
  }

  void startRolling() {
    final main = Provider.of<MainPro>(context, listen: false);
    // seconds = main.selectedPracQuizData.timePerQues;
    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..repeat();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

  buildAlertBox(BuildContext context, String msg) {
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
                  MaterialPageRoute(builder: (ctx) => TabMainScreen()),
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
    // print("BUILD METHOD");
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
        title: Consumer<MainPro>(builder: (context, main, _) {
          return Text(
            '${main.selectedPracQuizData[0].quizCategory} QUIZ',
            style: TextStyle(
              color: kSecondaryColor,
              fontFamily: 'DebugFreeTrial',
              fontSize: 30,
            ),
          );
        }),
      ),
      body: Consumer<MainPro>(builder: (context, main, _) {
        // int index = main.currentQuestionIndex;

        return Stack(
          children: [
            Column(
              children: [
                Selector<MainPro, int>(
                    selector: (context, mainSelector) =>
                        mainSelector.currentPracQuestion,
                    builder: (context, index, _) {
                      return Column(
                        children: [
                          SizedBox(
                            height: mq.height * 0.01,
                          ),
                          buildQuestionNumberIndicator(
                              mq, index + 1, main.selectedPracQuizData.length),
                          SizedBox(
                            height: mq.height * 0.1,
                          ),
                          Column(
                            children: List.generate(
                                main.selectedPracQuizData[index].options.length,
                                (i) {
                              //initializations
                              var questions = main.selectedPracQuizData[index];
                              var options =
                                  main.selectedPracQuizData[index].options[i];
                              //--
                              return Column(
                                children: [
                                  i == 0
                                      ? questionsContainer(mq, index, questions)
                                      : Container(),
                                  GestureDetector(
                                    onTap: () {
                                      main.setSelectedOptionPrac(i);
                                      main.makeSelectionsPrac(i);
                                    },
                                    child:
                                        optionsContainer(mq, main, i, options),
                                  )
                                ],
                              );
                            }),
                          ),
                          SizedBox(
                            height: mq.height * 0.04,
                          ),
                        ],
                      );
                    }),
                secondsContainer(mq, nexQuestion)
              ],
            ),
            main.isLoading
                ? CenterLoader(
                    isScaffoldRequired: true,
                  )
                : Container(
                    // color: Colors.transparent,
                    )
          ],
        );
      }),
    );
  }

  Container questionsContainer(Size mq, int index, questions) {
    return Container(
      padding: EdgeInsets.only(bottom: mq.height * 0.04),
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
    );
  }

  Container secondsContainer(Size mq, Function nextQues) {
    return Container(
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
                  height: mq.height * 0.16,
                  width: mq.height * 0.16,
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
          GestureDetector(
            onTap: () {
              nexQuestion();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                child: Text(
                  'NEXT',
                  style: TextStyle(
                      color: kPrimaryLightColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container optionsContainer(Size mq, MainPro main, int i, options) {
    return Container(
      height: mq.height * 0.07,
      margin: EdgeInsets.symmetric(
          vertical: mq.height * 0.015, horizontal: mq.width * 0.08),
      decoration: BoxDecoration(
        // add some functionality to add border and change color of text if selected

        border: main.selectedOptionPrac != null
            ? Border.all(
                width: 1.5,
                color: main.selectedOptionPrac == i
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
        options,
        style: TextStyle(
          fontSize: 26,

          // if selected change this color to kPrimaryLightColor

          color: main.selectedOptionPrac == i
              ? kPrimaryLightColor
              : kSecondaryColor,
          fontFamily: 'DebugFreeTrial',
        ),
      )),
    );
  }

  Widget buildQuestionNumberIndicator(Size mq, int current, int total) {
    int percentage = (100 * current) ~/ total;
    // print(percentage);

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
}
