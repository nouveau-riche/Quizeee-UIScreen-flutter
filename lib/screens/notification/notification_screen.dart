import 'package:flutter/material.dart';

import '../../constant.dart';

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
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold),
            ),
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
            height: mq.height * 0.06,
            width: mq.width * 0.125,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(left: mq.width * 0.02),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color.fromRGBO(52, 94, 103,1),
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
                  color: const Color.fromRGBO(71, 112, 118,1),
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
                  '10:30 PM', // change time according to notification
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
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
