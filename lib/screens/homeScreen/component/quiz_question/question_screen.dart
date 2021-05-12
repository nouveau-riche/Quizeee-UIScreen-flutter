import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizeee_ui/provider/mainPro.dart';
import 'package:quizeee_ui/widgets/toast.dart';

import '../../../../constant.dart';
import 'timer_animation.dart';

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
  @override
  Widget build(BuildContext context) {
    final mainPro = Provider.of<MainPro>(context, listen: false);

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
        title: Consumer<MainPro>(builder: (context, mainPro, _) {
          return Text(
            'QUIZ',
            style: TextStyle(
              color: kSecondaryColor,
              fontFamily: 'DebugFreeTrial',
              fontSize: 30,
            ),
          );
        }),
      ),
      body: Column(
        children: [
          Selector<MainPro, int>(
              selector: (context, main) => main.currentQuestionIndex,
              builder: (context, index, _) {
                return Column(
                  children: [
                    SizedBox(
                      height: mq.height * 0.01,
                    ),
                    buildQuestionNumberIndicator(mq),
                    SizedBox(
                      height: mq.height * 0.1,
                    ),
                    Column(
                      children: List.generate(
                          mainPro.selectedData.questions[index].options.length,
                          (i) {
                        var questions = mainPro.selectedData.questions[index];
                        var options = mainPro
                            .selectedData.questions[index].options[index];
                        return Column(
                          children: [
                            i == 0
                                ? Container(
                                    padding: EdgeInsets.only(
                                        bottom: mq.height * 0.04),
                                    width: mq.width * 0.7,
                                    child: Center(
                                      child: Text(
                                        '${questions.quesText}',
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

                    SizedBox(
                      height: mq.height * 0.1,
                    ),
                  ],
                );
              }),
          QuestionSeconds(),
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

  Widget buildOption(String option, Size mq, int index) {
    return Consumer<MainPro>(builder: (context, main, _) {
      return GestureDetector(
        onTap: () {
          if (main.enableButton) {
            main.makeSelections(index);
            toast("Cant select now!", isError: true);
          } else {
            print("Selected");
          }
        },
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

class _QuestionSecondsState extends State<QuestionSeconds> {
  Timer _timer;
  int seconds = 0;
  @override
  void initState() {
    super.initState();
    startTimmer();
  }

  void startTimmer() {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    seconds = mainPro.selectedData.timePerQues;
    Timer.periodic(Duration(seconds: seconds), (timer) {
      if (seconds == 0) {
        timer.cancel();
        enableButton();
      } else {
        setState(() {
          seconds -= 1;
        });
      }
    });
  }

  void enableButton() {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    mainPro.enableButtonAns();
    toast("Times Up!", isError: true);
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<MainPro, bool>(
      selector: (context, main) => main.enableButton,
      builder: (context, enableButton, _) => RaisedButton(
          onPressed: () {
            final mainPro = Provider.of<MainPro>(context, listen: false);

            if (enableButton) {
              if (mainPro.incrementQuestions()) {
                toast("Quiz Completed!!", isError: false);
              } else {
                print("Show must go on!!");
                startTimmer();
              }
            }
          },
          child: Text("${seconds}")),
    );
  }
}
