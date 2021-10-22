import 'package:cached_network_image/cached_network_image.dart';
import 'package:com.quizeee.quizeee/provider/apiUrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:com.quizeee.quizeee/provider/mainPro.dart';
import 'package:com.quizeee.quizeee/widgets/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constant.dart';

class SolutionScreen extends StatelessWidget {
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
        title: Consumer<MainPro>(
          builder: (con, mainPro, _) => Text(
            'Solution ${mainPro.currentQuestionIndex + 1}',
            // change count dynamically
            style: TextStyle(
              color: kSecondaryColor,
              fontFamily: 'DebugFreeTrial',
              fontSize: 30,
            ),
          ),
        ),
        actions: [
          Consumer<MainPro>(
            builder: (con, mainPro, _) => Container(
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
                  Icons.arrow_forward_ios_outlined,
                  color: kPrimaryColor,
                ),
                onPressed: () async {
                  if (mainPro.selectedData.questions.length !=
                      mainPro.currentQuestionIndex + 1) {
                    if (await mainPro.incrementQuestions()) {
                      toast("End", isError: true);
                    }
                  } else {
                    toast("End", isError: true);
                  }

                  // change question
                },
              ),
            ),
          ),
        ],
      ),
      body: Consumer<MainPro>(
        builder: (context, mainPro, _) => Column(
          children: [
            SizedBox(
              height: mq.height * 0.01,
            ),
            buildQuestionNumberIndicator(mq, mainPro.currentQuestionIndex + 1,
                mainPro.selectedData.questions.length),
            SizedBox(
              height: mq.height * 0.1,
            ),
            Column(
              children: List.generate(
                  mainPro.selectedData.questions[mainPro.currentQuestionIndex]
                      .options.length, (i) {
                var questions = mainPro
                    .selectedData.questions[mainPro.currentQuestionIndex];
                var options = mainPro.selectedData
                    .questions[mainPro.currentQuestionIndex].options[i];
                return Column(
                  children: [
                    i == 0
                        ? Container(
                            padding: EdgeInsets.only(bottom: mq.height * 0.02),
                            width: mq.width * 0.7,
                            child: Center(
                              child: Text(
                                'Q${mainPro.currentQuestionIndex + 1} : ${questions.quesText}',
                                style: TextStyle(
                                    color: kPrimaryLightColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        : Container(),
                    i == 0
                        ? mainPro
                                .selectedData
                                .questions[mainPro.currentQuestionIndex]
                                .quesImgUrl
                                .isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: ClipRRect(
                                  child: Container(
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: ApiUrls.baseUrlImage +
                                          mainPro
                                              .selectedData
                                              .questions[
                                                  mainPro.currentQuestionIndex]
                                              .quesImgUrl,
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        "assets/images/poster.png",
                                        fit: BoxFit.cover,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Image.asset(
                                        "assets/images/poster.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    width: mq.width * 0.8,
                                    height: mq.height * 0.10,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              )
                            : Container()
                        : Container(),
                    buildOption(
                      '$options',
                      mq,
                      i,
                      mainPro,
                    ),
                  ],
                );
              }),
            ),
            SizedBox(
              height: mq.height * 0.04,
            ),
            buildCheckSolution(mq, mainPro, context),
            SizedBox(
              height: mq.height * 0.05,
            ),
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

  Widget buildOption(String option, Size mq, int index, MainPro main) {
    // selected answer index
    dynamic selectedAnswer;
    if (main.userRank[0].reviewSolutions
        .asMap()
        .containsKey(main.currentQuestionIndex)) {
      selectedAnswer = main.userRank[0]
              .reviewSolutions[main.currentQuestionIndex].userOption ??
          null;
    } else {
      selectedAnswer = null;
    }

    bool isCorrect = main
            .selectedData.questions[main.currentQuestionIndex].rightOption
            .toString() ==
        index.toString();

    return Container(
      height: mq.height * 0.07,
      margin: EdgeInsets.symmetric(
          vertical: mq.height * 0.015, horizontal: mq.width * 0.08),
      decoration: BoxDecoration(
        // add some functionality to add border and change color of text if selected
        border: main.showSolutions
            ? isCorrect
                ? Border.all(width: 1.5, color: Colors.green)
                : Border.all(
                    width: 1.5,
                    color: selectedAnswer != null &&
                            selectedAnswer.toString().isNotEmpty
                        ? selectedAnswer == index
                            ? kPrimaryLightColor
                            : Colors.transparent
                        : Colors.transparent)
            : Border.all(
                width: 1.5,
                color: selectedAnswer != null
                    ? selectedAnswer == index
                        ? kPrimaryLightColor
                        : Colors.transparent
                    : Colors.transparent),
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
      child: SingleChildScrollView(
        child: Center(
            child: Text(
          option.toString(),
          style: TextStyle(
            fontSize: 14,

            // if selected change this color to kPrimaryLightColor

            color: isCorrect ? Colors.green : kPrimaryLightColor,
          ),
        )),
      ),
    );
  }

  Widget buildCheckSolution(Size mq, MainPro main, BuildContext context) {
    return Container(
      height: mq.height * 0.1,
      width: mq.width * 0.25,
      child: GestureDetector(
        onTap: () {
          // launch the url for more description of the solution
          if (main.showSolutions) {
            main.showAnswer(false);
          } else {
            main.showAnswer(true);
          }
        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              height: mq.height * 0.14,
              width: mq.height * 0.14,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kPrimaryLightColor, kPrimaryColor.withOpacity(0.3)],
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

            // CircularCountDownTimer(
            //   duration: 10,
            //   initialDuration: 0,
            //   controller: CountDownController(),
            //   width: mq.width * 0.25,
            //   height: mq.height * 0.1,
            //   ringColor: kPrimaryLightColor,
            //   ringGradient: LinearGradient(
            //     colors: [
            //       kPrimaryColor,
            //       kPrimaryLightColor,
            //     ],
            //     begin: Alignment.centerLeft,
            //     end: Alignment.centerRight,
            //   ),
            //   fillColor: kSecondaryColor,
            //   fillGradient: null,
            //   backgroundColor: kPrimaryColor,
            //   backgroundGradient: null,
            //   strokeWidth: 4.0,
            //   strokeCap: StrokeCap.round,
            //   textStyle: TextStyle(
            //       fontSize: 33.0,
            //       color: Colors.transparent,
            //       fontWeight: FontWeight.bold),
            //   textFormat: CountdownTextFormat.S,
            //   isReverse: false,
            //   isReverseAnimation: false,
            //   isTimerTextShown: false,
            //   autoStart: false,
            //   onStart: () {},
            //   onComplete: () {},
            // ),
            Align(
              child: GestureDetector(
                onTap: () {
                  if (main.selectedData.questions[main.currentQuestionIndex]
                          .solution
                          .toString() !=
                      "") {
                    showDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        content: Text(
                          main.selectedData.questions[main.currentQuestionIndex]
                              .solution
                              .toString(),
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Clipboard.setData(new ClipboardData(
                                  text: main
                                      .selectedData
                                      .questions[main.currentQuestionIndex]
                                      .solution
                                      .toString()));
                              toast("Copied to clipboard", isError: false);
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Copy to clipboard',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    toast("Solution Not available!", isError: true);
                  }

                  // launchInBrowser(main.selectedData
                  //     .questions[main.currentQuestionIndex].solution);
                },
                child: Text(
                  ' Check\nSolution ',
                  style: TextStyle(
                      color: kPrimaryLightColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
      );
    } else {
      toast("Solution not available!", isError: true);
      throw 'Could not launch $url';
    }
  }
}
