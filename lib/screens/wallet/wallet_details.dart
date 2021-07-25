import 'package:flutter/material.dart';

import '../../constant.dart';

class WalletDetails extends StatelessWidget {
  final String total;
  final String refilltotal;
  final String refertotal;
  final String winningtotal;

  const WalletDetails(
      {Key key,
      this.total,
      this.refilltotal,
      this.refertotal,
      this.winningtotal})
      : super(key: key);
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
            height: mq.height * 0.025,
          ),
          buildNotificationMessage(mq, 'Total Balance', total),
          buildNotificationMessage(mq, 'Refill Balance', refilltotal),
          buildNotificationMessage(mq, 'Referral Balance', refertotal),
          buildNotificationMessage(mq, 'Winning Balance', winningtotal),
          Spacer(),
          buildSubmitButton(mq, context),
          SizedBox(
            height: mq.height * 0.045,
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
                Icons.account_balance_wallet_outlined,
                size: 20,
              ),
              Text(
                '  VIEW BALANCE',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildNotificationMessage(Size mq, String message, String amount) {
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
                    fontSize: 12.5,
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
                'Rs. $amount',
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

  Widget buildSubmitButton(Size mq, BuildContext context) {
    return SizedBox(
      height: mq.height * 0.058,
      width: mq.width * 0.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {},
        child: Text(
          'Withdraw Winning',
          style: TextStyle(
            color: kPrimaryColor,
            fontFamily: 'DebugFreeTrial',
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}
