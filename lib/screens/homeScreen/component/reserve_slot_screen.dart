import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizeee_ui/screens/homeScreen/component/lets_start_or_play_practice_quiz.dart';

import '../../../constant.dart';

class ReserveSlotScreen extends StatelessWidget {
  final bool isSlotBooked;
  final String category;
  final String image;
  final String prize;
  final String time;
  final int totalSlots;
  final int slotsLeft;
  final String entryPrize;
  final String difficultyLevel;

  ReserveSlotScreen(
      {this.isSlotBooked,
      this.category,
      this.image,
      this.prize,
      this.time,
      this.totalSlots,
      this.slotsLeft,
      this.entryPrize,
      this.difficultyLevel});

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: mq.height * 0.04,
            ),
            buildAppBar(context, mq.width * 0.045),
            buildQuizPoster(mq),
            buildSlotsLeftGradientBar(mq, totalSlots, slotsLeft),
            Text(
              'PRICE BREAKDOWN',
              style: TextStyle(
                  color: kSecondaryColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: mq.height * 0.015,
            ),
            buildRankWisePrizeRow(),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: mq.width * 0.07, vertical: mq.height * 0.02),
              height: 2,
              width: mq.width,
              color: kSecondaryColor.withOpacity(0.2),
            ),
            buildEntryFeeAndLevel(),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: mq.width * 0.07, vertical: mq.height * 0.02),
              height: 2,
              width: mq.width,
              color: kSecondaryColor.withOpacity(0.2),
            ),
            isSlotBooked
                ? buildPayNow(mq, context)
                : buildReserveSlot(mq, context),
            SizedBox(
              height: mq.height * 0.015,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context, double margin) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 45,
          width: 40,
          margin: EdgeInsets.only(left: margin),
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
        Spacer(),
        Text(
          '$category QUIZ',
          style: TextStyle(
              color: kSecondaryColor,
              fontSize: 22,
              fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Container(
          width: 42,
          margin: EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 7),
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset('assets/images/profile.png'),
          ),
        ),
      ],
    );
  }

  Widget buildQuizPoster(Size mq) {
    return Stack(
      children: [
        Container(
          height: mq.height * 0.2,
          margin: EdgeInsets.all(mq.width * 0.055),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              image,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          right: mq.width * 0.1,
          top: mq.height * 0.04,
          child: buildPrizeMoney(prize),
        ),
        Positioned(
          right: mq.width * 0.06,
          bottom: mq.height * 0.026,
          child: buildQuizTime(mq.height * 0.042, mq.width * 0.32),
        ),
      ],
    );
  }

  Widget buildPrizeMoney(String prize) {
    return Column(
      children: [
        Text(
          'WINNING PRIZE',
          style: TextStyle(
              color: kPrimaryLightColor,
              fontFamily: 'DebugFreeTrial',
              fontWeight: FontWeight.w500,
              fontSize: 24),
        ),
        Text(
          'RS. $prize/  ',
          style: TextStyle(
              color: kPrimaryLightColor,
              fontFamily: 'DebugFreeTrial',
              fontWeight: FontWeight.w500,
              fontSize: 24),
        )
      ],
    );
  }

  Widget buildQuizTime(double height, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'QUIZ STARTS AT ',
          style: TextStyle(
              fontFamily: 'DebugFreeTrial',
              color: kPrimaryLightColor,
              fontSize: 18),
        ),
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
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSlotsLeftGradientBar(Size mq, int totalSlots, int slotsLeft) {
    int percentage = (100 * slotsLeft) ~/ totalSlots;
    print(percentage);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildSlotTag(slotsLeft, mq.height * 0.06, mq.width * 0.1, true),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          width: mq.width * 0.65,
          height: 7,
          color: kSecondaryColor.withOpacity(0.4),
          child: Row(
            children: [
              Container(
                width: ((mq.width * 0.65 * percentage) ~/ 100).toDouble(),
                height: 7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        kSecondaryColor.withOpacity(0.4),
                        kPrimaryLightColor
                      ]),
                ),
              ),
            ],
          ),
        ),
        buildSlotTag(totalSlots, mq.height * 0.06, mq.width * 0.1, false),
      ],
    );
  }

  Widget buildSlotTag(int slot, double height, double width, bool showLeft) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$slot',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'SLOTS',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'DebugFreeTrial',
              ),
            ),
            if (showLeft)
              Text(
                'LEFT',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'DebugFreeTrial',
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildRankWisePrizeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildRankList('#1 rank'),
            buildRankList('#2nd - #3rd'),
            buildRankList('#4th - #10th'),
            buildRankList('#11th - #50th'),
            buildRankList('#51st - #100th'),
            buildRankList('#101th - #200th'),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildMoney(100),
            buildMoney(90),
            buildMoney(80),
            buildMoney(60),
            buildMoney(40),
            buildMoney(30),
          ],
        ),
      ],
    );
  }

  Widget buildMoney(int money) {
    return Container(
      height: 35,
      child: Center(
        child: Text(
          'Rs $money/ -',
          style: TextStyle(
              color: kPrimaryLightColor.withOpacity(0.8),
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildRankList(String rank) {
    return Container(
      height: 35,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 35,
            width: 35,
            child: Image.asset(
              'assets/images/cup.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            rank,
            style: TextStyle(
              color: kPrimaryLightColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEntryFeeAndLevel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text(
              'ENTRY FEE',
              style: TextStyle(
                  color: kSecondaryColor,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              'Rs. $entryPrize',
              style: TextStyle(
                  color: kPrimaryLightColor,
                  fontSize: 28.5,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              'DIFFICULTY LEVEL',
              style: TextStyle(
                  color: kSecondaryColor,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              difficultyLevel,
              style: TextStyle(
                  color: kPrimaryLightColor,
                  fontSize: 28.5,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildReserveSlot(Size mq, BuildContext context) {
    return SizedBox(
      height: mq.height * 0.058,
      width: mq.width * 0.55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          buildAlertBoxForSlotBook(context, mq);
        },
        child: Text(
          'RESERVE SLOT',
          style: TextStyle(
            color: kPrimaryColor,
            fontFamily: 'DebugFreeTrial',
            fontSize: 30,
          ),
        ),
      ),
    );
  }

  Widget buildPayNow(Size mq, BuildContext context) {
    return SizedBox(
      height: mq.height * 0.058,
      width: mq.width * 0.55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          buildAlertBoxForPayNow(context);
        },
        child: Text(
          'PAY NOW',
          style: TextStyle(
            color: kPrimaryColor,
            fontFamily: 'DebugFreeTrial',
            fontSize: 30,
          ),
        ),
      ),
    );
  }

  buildAlertBoxForSlotBook(BuildContext context, Size mq) {
    showDialog(
      context: context,

      // change the padding of alert box from inside

      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SLOT BOOKED',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(width: 0.5, color: Colors.black26),
                        top: BorderSide(width: 1, color: Colors.black26),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'BACK',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1, color: Colors.black26),
                        left: BorderSide(width: 0.5, color: Colors.black26),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // logic for slot book

                        // if successfully booked change the state of isSlotBooked variable as true

                        Navigator.of(context).pop();

                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (ctx) => LetsStartOrPlayPracticeQuiz()));


                      },
                      child: Text(
                        'DONE',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  buildAlertBoxForPayNow(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'PAY Rs. $entryPrize/-',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(width: 0.5, color: Colors.black26),
                        top: BorderSide(width: 1, color: Colors.black26),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'DONE',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1, color: Colors.black26),
                        left: BorderSide(width: 0.5, color: Colors.black26),
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        // logic for slot book

                        Navigator.of(context).pop();

                        // if payment is successful then navigate

                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (ctx) => LetsStartOrPlayPracticeQuiz()));
                      },
                      child: Text(
                        'PAY NOW',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
