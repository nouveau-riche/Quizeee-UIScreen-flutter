import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';

class QuizBox extends StatelessWidget {
  final String image;
  final String category;
  final String time;
  final String slots;
  final String entryPrize;
  final String prize;
  final bool isSlotBooked;

  QuizBox({
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
          margin: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
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
                  buildEntryPrize(mq.height * 0.07, mq.width * 0.28),
                ],
              ),
            ],
          ),
        ),
        buildSlotsTag(mq.height * 0.062, mq.width * 0.11),
        Positioned(
          right: mq.width * 0.055,
          bottom: mq.height * 0.11,
          child: buildReserveSlot(context, mq.height * 0.055, mq.width * 0.28),
        ),
        Positioned(
          top: mq.height * 0.028,
          right: mq.width * 0.08,
          child: buildPrizeMoney(),
        ),
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
          '$category QUIZ',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: kSecondaryColor),
        ),
        Text(
          'QUIZ STARTS AT',
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: kSecondaryColor),
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
    );
  }

  Widget buildReserveSlot(BuildContext context, double height, double width) {
    return GestureDetector(
      onTap: () {},
      child: Container(
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
                'RESERVE',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'DebugFreeTrial',
                ),
              ),
              Text(
                'SLOT',
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'DebugFreeTrial',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
