import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
        title: Text(
          'Solution 1', // change count dynamically
          style: TextStyle(
            color: kSecondaryColor,
            fontFamily: 'DebugFreeTrial',
            fontSize: 30,
          ),
        ),
        actions: [
          Container(
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
              onPressed: () {
                // change question
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: mq.height * 0.01,
          ),
          buildQuestionNumberIndicator(mq, 1, 10),
          SizedBox(
            height: mq.height * 0.1,
          ),
          Text(
            'Q1. Which one is an Indian city?',
            style: TextStyle(
                color: kPrimaryLightColor,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: mq.height * 0.02,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) => buildOption('Jaipur', mq),
              itemCount: 4,
            ),
          ),
          SizedBox(
            height: mq.height * 0.04,
          ),
          buildCheckSolution(mq),
          SizedBox(
            height: mq.height * 0.05,
          ),
        ],
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

  Widget buildOption(String option, Size mq) {
    return Container(
      height: mq.height * 0.07,
      margin: EdgeInsets.symmetric(
          vertical: mq.height * 0.015, horizontal: mq.width * 0.08),
      decoration: BoxDecoration(
        // add some functionality to add border and change color of text if selected

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

          color: kPrimaryLightColor,
          fontFamily: 'DebugFreeTrial',
        ),
      )),
    );
  }

  Widget buildCheckSolution(Size mq) {
    return Container(
      height: mq.height * 0.1,
      width: mq.width * 0.25,
      child: Stack(
        children: [
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
            child: Text(
              ' Check\nSolution',
              style: TextStyle(
                  color: kPrimaryLightColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
