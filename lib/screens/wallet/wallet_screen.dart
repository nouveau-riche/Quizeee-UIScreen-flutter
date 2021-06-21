import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../constant.dart';

class WalletScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          'QUIZEEE',
          style: TextStyle(
              color: kTextColor,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: 'MajorLeagueDuty',
              decoration: TextDecoration.underline),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: mq.height * 0.02,
              ),
              buildRefillWithdrawAndBalance(mq),
              SizedBox(
                height: mq.height * 0.035,
              ),
              buildDocumentVerification(mq),
            ],
          ),
          Positioned(
            child: bottomSheet(mq),
            bottom: 0,
            left: 0,
            right: 0,
          ),
        ],
      ),
    );
  }

  Widget buildRefillWithdrawAndBalance(Size mq) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.only(left: 5),
          width: mq.width * 0.44,
          height: mq.height * 0.12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kPrimaryLightColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'BALANCE',
                style: TextStyle(fontSize: 18, fontFamily: 'DebugFreeTrial'),
              ),
              Text(
                'Rs. 200',
                style: TextStyle(fontSize: 24, fontFamily: 'DebugFreeTrial'),
              ),
            ],
          ),
        ),
        Column(
          children: [
            GestureDetector(
              onTap: (){},
              child: Container(
                margin: EdgeInsets.only(right: 5),
                width: mq.width * 0.44,
                height: mq.height * 0.055,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Center(
                  child: const Text(
                    'REFILL',
                    style: TextStyle(fontSize: 24, fontFamily: 'DebugFreeTrial'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: mq.height * 0.006,
            ),
            GestureDetector(
              onTap: (){},
              child: Container(
                margin: EdgeInsets.only(right: 5),
                width: mq.width * 0.44,
                height: mq.height * 0.055,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(86, 125, 130, 1),
                ),
                child: Center(
                  child: const Text(
                    'WITHDRAW',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'DebugFreeTrial'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDocumentVerification(Size mq) {
    return Container(
      height: mq.height * 0.22,
      width: mq.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromRGBO(86, 125, 130, 1),
      ),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Select Documents',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Select Documents To Verify Your Account',
            style: TextStyle(color: kSecondaryColor, fontSize: 9.5),
          ),
          const Text(
            'E.G Aadhar Card,Pan Card',
            style: TextStyle(color: kSecondaryColor, fontSize: 9.5),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: mq.height * 0.065,
            width: mq.width * 0.7,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                'UPLOAD DOCUMENTS',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                primary: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet(Size mq) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      width: mq.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            offset: Offset(1.0, 20.0),
            blurRadius: 20.0,
          )
        ],
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(32), topLeft: Radius.circular(32)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: mq.height * 0.025,
          ),
          const Text(
            'RECENT TRANSACTION HISTORY',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(
            height: mq.height * 0.05,
          ),
          buildRecentTransactionGradientBar(mq, 60),
          buildRecentTransactionGradientBar(mq, 35),
          TextButton(
            onPressed: () {},
            child: Text(
              'VIEW MORE',
              style: TextStyle(
                  color: kSecondaryColor.withOpacity(0.5), fontSize: 10),
            ),
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget buildRecentTransactionGradientBar(Size mq, double money) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: mq.width * 0.025),
      child: Column(
        children: [
          LinearPercentIndicator(
            padding: EdgeInsets.all(4),
            lineHeight: 8.0,
            percent: money / 100,
            backgroundColor: kSecondaryColor.withOpacity(0.4),
            progressColor: kPrimaryLightColor,
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Monday',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                'Rs. ${money.toInt()}',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
