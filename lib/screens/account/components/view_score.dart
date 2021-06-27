import 'package:flutter/material.dart';

import '../../../constant.dart';

class ViewScoreScreen extends StatelessWidget {
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
                  buildResultListTile(mq, 'Science', '20-12-2021'),
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

  Widget buildResultListTile(Size mq, String name, String time) {
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
                      '$name Quiz',
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
                'View',
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
