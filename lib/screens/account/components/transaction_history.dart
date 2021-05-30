import 'package:flutter/material.dart';

import '../../../constant.dart';

class TransactionHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          SizedBox(
            height: mq.height * 0.045,
          ),
          buildAppBar(context, mq),
          Expanded(
            child: ListView.builder(
              itemBuilder: (ctx, index) =>
                  buildNotificationMessage(mq, 'New game starts in 2 minutes'),
              itemCount: 3,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context, Size mq) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 45,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.history,
                size: 20,
              ),
              Text(
                '  TRANSACTION HISTORY',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildNotificationMessage(Size mq, String message) {
    return Container(
      margin: EdgeInsets.only(top: mq.height * 0.01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: EdgeInsets.only(left: mq.width * 0.02),
            width: mq.width * 0.75,
            height: mq.height * 0.06,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(71, 112, 118, 1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                message,
                style: const TextStyle(
                    color: kSecondaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: mq.height * 0.062,
            width: mq.width * 0.132,
            margin: EdgeInsets.only(right: mq.width * 0.02),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color.fromRGBO(52, 94, 103, 1),
            ),
            child: Center(
              child: Text(
                'Rs. 20',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    color: kSecondaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}