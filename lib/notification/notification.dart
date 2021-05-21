import 'package:flutter/material.dart';

import '../constant.dart';

class NotificationScreen extends StatelessWidget {
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
          SizedBox(
            height: mq.height * 0.02,
          ),
          buildNotificationMessage(mq, 'New game starts in 2 minutes'),
          buildNotificationMessage(mq, 'New game starts in 2 minutes'),
          buildNotificationMessage(mq, 'Congratulations! You won Rs. 30'),
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
          width: mq.width * 0.10,
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
          width: mq.width * 0.75,
          height: mq.height * 0.06,
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: const Text(
              'NOTIFICATION',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNotificationMessage(Size mq, String message) {
    return Container(
      margin: EdgeInsets.only(top: mq.width * 0.05),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 60,
            width: mq.width * 0.125,
            margin: EdgeInsets.only(left: mq.width * 0.02),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kNotificationColor,
            ),
            child: Image.asset('assets/images/notification.png'),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: mq.width * 0.75,
                height: mq.height * 0.06,
                decoration: BoxDecoration(
                  color: kNotificationColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: mq.width * 0.05,
                    ),
                    Text(
                      message,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '10:30 PM',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
