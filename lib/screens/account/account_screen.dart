import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';
import './components/edit_profile.dart';
import './components/transaction_history.dart';

class AccountScreen extends StatelessWidget {
  File image;

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
          'ACCOUNT',
          style: TextStyle(
            color: kSecondaryColor,
            fontSize: 35,
            fontFamily: 'DebugFreeTrial',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSelectImage(),
            TextButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(builder: (ctx) => EditProfile()),
                );
              },
              icon: const Icon(
                Icons.edit,
                color: kSecondaryColor,
                size: 16,
              ),
              label: Text(
                'Edit Profile',
                style: TextStyle(
                    color: kSecondaryColor, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            buildTransactionHistory(mq, context),
            SizedBox(
              height: mq.height * 0.06,
            ),
            buildStrengthCard(mq),
            SizedBox(
              height: mq.height * 0.02,
            ),
            buildMatchHistory(mq),
            SizedBox(
              height: mq.height * 0.02,
            ),
            buildWinPercentage(mq, 68),
          ],
        ),
      ),
    );
  }

  Widget buildSelectImage() {
    return GestureDetector(
      onTap: () {
        // openDialogBox();
      },
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: kSecondaryColor,
            child: CircleAvatar(
              radius: 46,
              backgroundColor: Colors.grey,
              backgroundImage: image == null
                  ? AssetImage('assets/images/profile.png')
                  : FileImage(image),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 26,
              width: 28,
              decoration: BoxDecoration(
                color: kSecondaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.camera_alt,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTransactionHistory(Size mq, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (ctx) => TransactionHistoryScreen()),
        );
      },
      child: Container(
        height: mq.height * 0.065,
        margin: EdgeInsets.symmetric(horizontal: mq.width * 0.1),
        decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.history,
              size: 20,
            ),
            const Text(
              '  TRANSACTION HISTORY',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStrengthCard(Size mq) {
    return Container(
      height: mq.height * 0.2,
      width: mq.width * 0.74,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.32),
            Color.fromRGBO(150, 180, 180, 1)
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: mq.height * 0.055,
            width: mq.width * 0.18,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '50%',
                style: const TextStyle(
                  color: kSecondaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'STRENGTH',
            style: TextStyle(
              fontSize: 21,
              color: kPrimaryColor,
              fontFamily: 'DebugFreeTrial',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          buildSubjectStrength('Science', 50),
          buildSubjectStrength('History', 80),
        ],
      ),
    );
  }

  Widget buildSubjectStrength(String subject, int percentage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          subject,
          style: const TextStyle(
            fontSize: 14,
            color: kPrimaryColor,
          ),
        ),
        Text(
          '$percentage%',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
        ),
      ],
    );
  }

  Widget buildMatchHistory(Size mq) {
    return Container(
      height: mq.height * 0.14,
      width: mq.width * 0.74,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.32),
            Color.fromRGBO(150, 180, 180, 1)
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'MATCH HISTORY',
            style: TextStyle(
              fontSize: 24,
              color: kPrimaryColor,
              fontFamily: 'DebugFreeTrial',
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TOTAL MATCHES PLAYED',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    '35',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TOTAL MATCHES WINNED',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    '20',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildWinPercentage(Size mq, int winPercentage) {
    return Container(
      height: mq.height * 0.07,
      width: mq.width * 0.74,
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.32),
            Color.fromRGBO(150, 180, 180, 1)
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'WINNING PERCENTAGE',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'DebugFreeTrial',
              fontSize: 20,
            ),
          ),
          Text(
            '$winPercentage%',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
