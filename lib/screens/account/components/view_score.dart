import 'package:com.quizeee.quizeee/provider/mainPro.dart';
import 'package:com.quizeee.quizeee/screens/homeScreen/component/quiz_result.dart';
import 'package:com.quizeee.quizeee/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import '../../../constant.dart';

class ViewScoreScreen extends StatefulWidget {
  @override
  _ViewScoreScreenState createState() => _ViewScoreScreenState();
}

class _ViewScoreScreenState extends State<ViewScoreScreen> {
  Future<void> getUserQuize(BuildContext context) async {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    if (!mainPro.isLoadedOnce) {
      final resp = await mainPro.getUsersQuiz();
      if (!resp['status']) {
        toast(resp['msg'], isError: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Consumer<MainPro>(
            // selector: (con, mainPro) => mainPro.selectedType,
            builder: (context, type, _) {
          return Consumer<MainPro>(builder: (context, quiz, _) {
            return Column(
              children: [
                buildAppBar(context, mq),
                SizedBox(
                  height: mq.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildViewScore(mq, context, onTap: () {
                      quiz.toggleType(0);
                    },
                        type: type.selectedType == 0
                            ? kPrimaryLightColor
                            : Colors.grey,
                        title: "Assigned"),
                    buildViewScore(mq, context, onTap: () {
                      quiz.toggleType(1);
                    },
                        type: type.selectedType == 1
                            ? kPrimaryLightColor
                            : Colors.grey,
                        title: "Public"),
                    buildViewScore(mq, context, onTap: () {
                      quiz.toggleType(2);
                    },
                        type: type.selectedType == 2
                            ? kPrimaryLightColor
                            : Colors.grey,
                        title: "Free")
                  ],
                ),
                FutureBuilder(
                    future: quiz.userPlayedAssigned.isEmpty
                        ? getUserQuize(context)
                        : null,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Expanded(
                          child: Center(
                            child:
                                SpinKitPouringHourglass(color: kSecondaryColor),
                          ),
                        );
                      } else {
                        int quizCount;
                        dynamic quizData;
                        if (type.selectedType == 0) {
                          quizCount = quiz.userPlayedAssigned.length;
                          quizData = quiz.userPlayedAssigned;
                        } else if (type.selectedType == 1) {
                          quizCount = quiz.userPlayedPublic.length;
                          quizData = quiz.userPlayedPublic;
                        } else {
                          quizCount = quiz.userPlayedFree.length;
                          quizData = quiz.userPlayedFree;
                        }
                        return Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 10),
                            itemBuilder: (ctx, index) {
                              if (quizData.isEmpty) {
                                return Container(
                                    margin:
                                        EdgeInsets.only(top: mq.height * 0.30),
                                    child: Center(
                                      child: Text(
                                        'NO DATA AVAILABLE',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                    ));
                              }
                              return buildResultListTile(
                                  mq,
                                  '${quizData[index].quizTitle}',
                                  '${quiz.formatDate(quizData[index].startDateNew.toString())}',
                                  mainPro: quiz,
                                  quiz: quizData[index],
                                  isAssigned: type.selectedType == 0 ||
                                      type.selectedType == 2,
                                  isPrac: false);
                            },
                            itemCount: quizData.isEmpty ? 1 : quizCount,
                          ),
                        );
                      }
                    }),
              ],
            );
          });
        }),
      ),
    );
  }

  Widget buildAppBar(BuildContext context, Size mq) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          // height: 45,
          width: mq.width * 0.12,
          margin: EdgeInsets.only(left: mq.width * 0.02),
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
          height: mq.height * 0.065,
          width: mq.width * 0.7,
          decoration: BoxDecoration(
            color: kPrimaryLightColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              'VIEW SCORE',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildViewScore(Size mq, BuildContext context,
      {Color type, Function onTap, String title}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        height: mq.height * 0.065,
        width: mq.width * 0.25,
        decoration: BoxDecoration(
          color: type,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '$title',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildResultListTile(Size mq, String name, String time,
      {dynamic quiz, MainPro mainPro, bool isPrac, bool isAssigned}) {
    return Container(
      margin: EdgeInsets.only(top: mq.height * 0.01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: mq.width * 0.75,
                height: mq.height * 0.06,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(71, 112, 118, 1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: mq.width * 0.05,
                    ),
                    Text(
                      '$name',
                      style: const TextStyle(
                          color: kSecondaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  time,
                  style: const TextStyle(
                      color: kSecondaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () async {
              mainPro.saveDataForQuestions(quiz);
              toast("Loading.....", isError: false);
              final resp = await mainPro.getUserRank();
              if (resp['status']) {
                if (isPrac) {
                  mainPro.saveDataForPracQuestions([quiz]);
                }
                Navigator.of(context).push(CupertinoPageRoute(
                  builder: (ctx) => QuizResult(
                    isPracticeQuiz: isPrac,
                    isAssigned: isAssigned,
                    isViewMore: true,
                  ),
                ));
              } else {
                toast(resp['msg'], isError: true);
              }
            },
            child: Container(
              height: mq.height * 0.062,
              width: mq.width * 0.132,
              margin: EdgeInsets.only(right: mq.width * 0.02),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromRGBO(52, 94, 103, 1),
              ),
              child: Center(
                child: Text(
                  'View',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      color: kSecondaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
