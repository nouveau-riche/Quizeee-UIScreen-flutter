import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:com.quizeee.quizeee/provider/mainPro.dart';
import 'package:com.quizeee.quizeee/widgets/centerLoader.dart';
import 'package:com.quizeee.quizeee/widgets/toast.dart';

import '../../../../constant.dart';
import '../../../../main.dart';
import '../../../tabs_screen.dart';
import '../quiz_result.dart';

class QuizQuestion extends StatefulWidget {
  final String quizName;
  final String question;
  final List<String> options;

  QuizQuestion({this.quizName, this.question, this.options});

  @override
  _QuizQuestionState createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion>
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
  void initState() {
    super.initState();
    startRolling();
    startTimmer();
  }

  void startRolling() {
    final main = Provider.of<MainPro>(context, listen: false);
    seconds = main.selectedData.timePerQues;
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
    // final mainn = Provider.of<MainPro>(context, listen: false);
    // mainn.resetSeconds();
    // Timer.periodic(Duration(seconds: 1), (timer) {
    // final main = Provider.of<MainPro>(context, listen: false);

    //   if (main.seconds == 0) {
    //     timer.cancel();
    //     enableButton(context);
    //   } else {
    //     main.decrementSeconds();
    //   }
    // });

    Timer.periodic(Duration(seconds: 1), (t) {
      var timeinfo = Provider.of<MainPro>(context, listen: false);
      timeinfo.updateRemainingTime();
      print(timeinfo.gettime_remain_provider());
      if (timeinfo.gettime_remain_provider() == 0) {
        t.cancel();
        enableButton();
      }
    });
  }

  enableButton() async {
    final main = Provider.of<MainPro>(context, listen: false);
    main.enableButtonAns(true);
    // toast("Times Up!", isError: false);
    if (main.enableButton) {
      if (await main.incrementQuestions()) {
        toast("Quiz Completed", isError: false);
        main.calculateTotalScore();
        _controller.stop();
        main.changeLoadingState(true);
        final response = await main.submitQuizResult();
        await main.getDashBoardData();
        main.changeLoadingState(false);
        main.clearQuizData();
        if (response['status']) {
          Navigator.of(context).pushReplacement(CupertinoPageRoute(
            builder: (ctx) => QuizResult(
              isPracticeQuiz: false,
            ),
          ));
        } else {
          buildAlertBox(context, response['message']);
        }
        // Navigate to next Screen

      } else {
        main.resetSelectedOption();
        main.enableButtonAns(false);
        print("Show must go on!!");
        startTimmer();
      }
    }
  }

  buildAlertBox(BuildContext context, String msg) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) =>
          CupertinoAlertDialog(
            title: Text(
              'Science Quiz',// add quiz name
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            content: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Your Score',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '2/7', // add correctAns and Total Question
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Response Time',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '2 Sec', // add time taken
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
                Text(
                  'Result will be\navailable on date ',//add date
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Ok',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ],
          ),
      //     CupertinoAlertDialog(
      //   content: Text(
      //     msg,
      //     style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      //   ),
      //   actions: [
      //     TextButton(
      //       onPressed: () {
      //         Navigator.of(context).pushAndRemoveUntil(
      //             MaterialPageRoute(builder: (ctx) => TabMainScreen()),
      //             (route) => false);
      //       },
      //       child: Text(
      //         'OK',
      //         style: TextStyle(color: Colors.black54),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  @override
  void dispose() {
    this.deactivate();
    super.dispose();
    _controller.dispose();
    _timer.cancel();
  }

  Future<bool> willPop(BuildContext context) async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    print("BUILD METHOD");
    return WillPopScope(
      onWillPop: () {
        willPop(context);
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          centerTitle: true,
          leading: Container(
              // height: 45,
              // width: 40,
              // margin: EdgeInsets.only(
              //   left: mq.width * 0.024,
              //   right: mq.width * 0.024,
              //   top: 7,
              //   bottom: 7,
              // ),
              // decoration: BoxDecoration(
              //   color: kSecondaryColor,
              //   borderRadius: BorderRadius.circular(10),
              // ),
              // child: IconButton(
              //   icon: Icon(
              //     Icons.arrow_back_ios_outlined,
              //     color: kPrimaryColor,
              //   ),
              //   onPressed: () {
              //     // userExitsQuiz();
              //     // Navigator.of(context).pop();
              //   },
              // ),
              ),
          title: Consumer<MainPro>(builder: (context, main, _) {
            return Text(
              '${main.selectedData.quizCategory} QUIZ',
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
                          mainSelector.currentQuestionIndex,
                      builder: (context, index, _) {
                        return Column(
                          children: [
                            SizedBox(
                              height: mq.height * 0.01,
                            ),
                            buildQuestionNumberIndicator(mq, index + 1,
                                main.selectedData.questions.length),
                            SizedBox(
                              height: mq.height * 0.1,
                            ),
                            Column(
                              children: List.generate(
                                  main.selectedData.questions[index].options
                                      .length, (i) {
                                //initializations
                                var questions =
                                    main.selectedData.questions[index];
                                var options = main
                                    .selectedData.questions[index].options[i];
                                //--
                                return Column(
                                  children: [
                                    i == 0
                                        ? questionsContainer(
                                            mq, index, questions)
                                        : Container(),
                                    GestureDetector(
                                      onTap: () {
                                        main.setSelectedOption(i);
                                        main.makeSelections(i);
                                      },
                                      child: optionsContainer(
                                          mq, main, i, options),
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
                  Selector<MainPro, int>(
                      selector: (context, mainSelector) =>
                          mainSelector.gettime_remain_provider(),
                      builder: (context, second, _) {
                        return secondsContainer(mq, second);
                      }),
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
      ),
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

  Container secondsContainer(Size mq, int second) {
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
              '${second}s',
              style: TextStyle(
                  color: kPrimaryLightColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
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

        border: main.selectedOption != null
            ? Border.all(
                width: 1.5,
                color: main.selectedOption == i
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

          color:
              main.selectedOption == i ? kPrimaryLightColor : kSecondaryColor,
          fontFamily: 'DebugFreeTrial',
        ),
      )),
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
}
