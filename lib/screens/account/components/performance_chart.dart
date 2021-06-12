import 'package:flutter/material.dart';

import '../../../constant.dart';

class PerformanceChartScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        children: [
          SizedBox(
            height: mq.height * 0.05,
          ),
          buildAppBar(context, mq),
          SizedBox(
            height: mq.height * 0.025,
          ),
          Text(
            'CATEGORY',
            style: TextStyle(color: kPrimaryLightColor),
          ),
          SizedBox(
            height: mq.height * 0.025,
          ),
          buildTransactionHistory(mq, context),
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context, Size mq) {
    return Row(
      children: [
        Container(
          height: 45,
          width: mq.width * 0.12,
          margin: EdgeInsets.only(left: mq.width * 0.05),
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
        SizedBox(
          width: mq.width * 0.05,
        ),
        Text(
          'PERFORMANCE CHART',
          style: TextStyle(fontSize: 24, color: kSecondaryColor),
        ),
      ],
    );
  }

  Widget buildTransactionHistory(Size mq, BuildContext context) {
    return Container(
      height: mq.height * 0.065,
      width: mq.width,
      margin: EdgeInsets.symmetric(horizontal: mq.width * 0.1),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            kPrimaryColor,
            kSecondaryColor.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: const Text(
          '  SUB-CATEGORY',
          style: TextStyle(
              color: kPrimaryLightColor,
              fontWeight: FontWeight.bold,
              fontSize: 12.5),
        ),
      ),
    );
  }
}
