import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:com.quizeee.quizeee/navigatorAnimation/navigatorParent.dart';
import 'package:com.quizeee.quizeee/provider/mainPro.dart';
import 'package:com.quizeee.quizeee/screens/homeScreen/component/lets_start_or_play_practice_quiz.dart';
import 'package:com.quizeee.quizeee/screens/homeScreen/component/reserve_slot_screen.dart';
import 'package:com.quizeee.quizeee/widgets/toast.dart';

import '../../../constant.dart';
import 'rules_screen.dart';

class QuizBox extends StatelessWidget {
  final Function reverseSlot;
  final bool isAssignedQuiz;
  final String image;
  final String category;
  final String time;
  final String slots;
  final String entryPrize;
  final String prize;
  final String quizId;
  final bool isSlotBooked;
  final String totalSlots;
  final dynamic data;
  final int quizIndex;

  QuizBox({
    this.isAssignedQuiz,
    this.reverseSlot,
    this.totalSlots,
    this.quizIndex,
    this.data,
    this.quizId,
    this.image,
    this.category,
    this.time,
    this.slots,
    this.entryPrize,
    this.prize,
    this.isSlotBooked,
  });

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: mq.height * 0.26,
          width: mq.width,
          padding: EdgeInsets.all(8),
          margin:
              EdgeInsets.symmetric(horizontal: mq.width * 0.034, vertical: 7),
          decoration: BoxDecoration(
            color: Color.fromRGBO(33, 64, 74, 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildQuizPoster(mq.height * 0.15, mq.width),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildCategory(mq.height * 0.038, mq.width * 0.28),
                  isAssignedQuiz
                      ? Container()
                      : buildEntryPrize(mq.height * 0.07, mq.width * 0.28),
                ],
              ),
            ],
          ),
        ),
        slots != null
            ? buildSlotsTag(mq.height * 0.062, mq.width * 0.11)
            : Container(),
        int.parse(totalSlots) == 0 && !isAssignedQuiz
            ? Container()
            : Positioned(
                right: mq.width * 0.055,
                bottom: mq.height * 0.1,
                child: GestureDetector(
                    onTap: () async {
                      final mainPro =
                          Provider.of<MainPro>(context, listen: false);
                      String date;
                      if (data.endDate == "" ||
                          data.endDate == null ||
                          data.endDate == "null") {
                        date = data.startDate;
                      } else {
                        date = data.endDate;
                      }
                      if (!mainPro.isQuizEnded(date)) {
                        if (isAssignedQuiz) {
                          if (data.bookingStatus != null &&
                              data.bookingStatus == -1) {
                            mainPro.saveDataForQuestions(data);
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (ctx) => RulesScreen(
                                      isPracticeQuiz: false,
                                    )));
                            // Navigator.of(context).push(
                            //   CupertinoPageRoute(
                            //     builder: (ctx) => LetsStartOrPlayPracticeQuiz(
                            //       data: data,
                            //     ),
                            //   ),
                            // );
                          } else {
                            if (data.bookingStatus == null) {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (ctx) => LetsStartOrPlayPracticeQuiz(
                                    data: data,
                                  ),
                                ),
                              );
                            } else {
                              // 2 played

                            }
                          }
                        } else {
                          // bool booked = await reverseSlot(quizId, quizIndex);
                          Future.delayed(Duration(milliseconds: 500), () async {
                            if (data.bookingStatus == 1) {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (ctx) => LetsStartOrPlayPracticeQuiz(
                                    data: data,
                                  ),
                                ),
                              );
                            } else if (data.bookingStatus == 2) {
                              toast("Already Played..", isError: false);
                            } else {
                              // bool booked = await reverseSlot(quizId, quizIndex);

                              Provider.of<MainPro>(context, listen: false)
                                  .saveCurrentQuizId(
                                      quizId: quizId, quizIndex: quizIndex);
                              Provider.of<MainPro>(context, listen: false)
                                  .changeServeStatus = false;
                              Provider.of<MainPro>(context, listen: false)
                                  .notifyListeners();
                              Navigator.of(context).push(FadeNavigation(
                                widget: ReserveSlotScreen(
                                  isSlotBooked: false,
                                  category: category,
                                  image: image,
                                  prize: prize,
                                  time: time,
                                  entryPrize: entryPrize,
                                  difficultyLevel:
                                      data.difficultyLevel.toString(),
                                  totalSlots: totalSlots,
                                  slotsLeft: slots,
                                  data: data,
                                ),
                              ));
                            }
                          });
                        }
                      } else {
                        toast("Time up!", isError: true);
                      }
                    },
                    child: isAssignedQuiz
                        ? buildReserveSlot(
                            context,
                            mq.height * 0.055,
                            mq.width * 0.28,
                            data.bookingStatus == 2
                                ? "PLAYED"
                                : data.bookingStatus == null
                                    ? "AWAITED"
                                    : "PLAY\nNOW")
                        : data.bookingStatus != 1 &&
                                data.bookingStatus != 2 &&
                                slots == "0"
                            ? Container()
                            : data.bookingStatus == 2
                                ? buildReserveSlot(context, mq.height * 0.055,
                                    mq.width * 0.28, "PLAYED")
                                : buildReserveSlot(
                                    context,
                                    mq.height * 0.055,
                                    mq.width * 0.28,
                                    data.bookingStatus == 1
                                        ? "PLAY\nNOW"
                                        : "RESERVE\nSLOT")),
              ),
        Positioned(
          top: mq.height * 0.027,
          right: mq.width * 0.08,
          child: buildPrizeMoney(),
        )
      ],
    );
  }

  Widget buildQuizPoster(double height, double width) {
    return Container(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildCategory(double height, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$category',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: kSecondaryColor),
        ),
        Consumer<MainPro>(builder: (context, mainPro, _) {
          return Text(
            mainPro.isStartOrEnd(data),
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: kSecondaryColor),
          );
        }),
        Container(
          height: height,
          width: width,
          margin: EdgeInsets.only(top: 2),
          decoration: BoxDecoration(
            color: kPrimaryLightColor,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Center(
            child: Text(
              time,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEntryPrize(double height, double width) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ENTRY PRIZE',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'RS. $entryPrize/-',
            style: TextStyle(
              fontSize: 13.5,
              fontFamily: 'RapierZero',
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSlotsTag(double height, double width) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.only(left: 8.5),
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              slots,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'SLOTS',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'DebugFreeTrial',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPrizeMoney() {
    return Column(
      children: [
        prize != "null"
            ? Column(
                children: [
                  Text(
                    'WINNING PRIZE',
                    style: TextStyle(
                        color: kPrimaryLightColor,
                        fontFamily: 'DebugFreeTrial',
                        fontSize: 18),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'RS. $prize',
                        style: TextStyle(
                            color: kPrimaryLightColor,
                            fontFamily: 'DebugFreeTrial',
                            fontSize: 15),
                      ),
                      Text(
                        '/ -',
                        style: TextStyle(
                            color: kPrimaryLightColor,
                            fontFamily: 'Bungee',
                            fontSize: 15),
                      )
                    ],
                  ),
                ],
              )
            : Container(),
        Text(
          '${data.quizCategory} QUIZ',
          style: TextStyle(
              color: kPrimaryLightColor,
              fontFamily: 'DebugFreeTrial',
              fontSize: 15),
        ),
      ],
    );
  }

  Widget buildReserveSlot(
      BuildContext context, double height, double width, String title) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontFamily: 'DebugFreeTrial',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
