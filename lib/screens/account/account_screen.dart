import 'dart:io';
import 'package:com.quizeee.quizeee/provider/mainPro.dart';
import 'package:com.quizeee.quizeee/screens/account/components/view_score.dart';
import 'package:com.quizeee.quizeee/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import './components/edit_profile.dart';
import './components/transaction_history.dart';
import './components/performance_chart.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  File image;

  Future<void> getUserPerformance() async {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    if (mainPro.assignedPerformace.isEmpty) {
      final resp = await mainPro.getUserPerformance();
      // if (!resp['status']) {
      //   toast(resp['msg'], isError: true);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(0, 44, 62, 1),
        centerTitle: true,
        title: const Text(
          'ACCOUNT',
          style: TextStyle(
            color: kSecondaryColor,
            fontSize: 40,
            fontFamily: 'DebugFreeTrial',
          ),
        ),
      ),
      body: FutureBuilder(
          future: getUserPerformance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKitPouringHourglass(color: kSecondaryColor),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(0, 44, 62, 1),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      ),
                    ),
                    child: Column(
                      children: [
                        buildSelectImage(),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                  builder: (ctx) => EditProfile()),
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
                                color: kSecondaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        buildTransactionHistory(mq, context),
                        SizedBox(
                          height: 10,
                        ),
                        buildPerformanceChart(mq, context),
                        SizedBox(
                          height: 10,
                        ),
                        buildViewScore(mq, context),
                        SizedBox(
                          height: mq.height * 0.04,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: mq.height * 0.02,
                  ),
                  Consumer<MainPro>(builder: (con, mainPro, _) {
                    if (mainPro.assignedPerformace.isEmpty) {
                      return Container();
                    }
                    var data = mainPro.assignedPerformace[0];
                    return Column(
                      children: [
                        const Text(
                          'ASSIGNED QUIZ',
                          style: TextStyle(
                            fontFamily: 'RapierZero',
                            color: kPrimaryLightColor,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: mq.height * 0.02,
                        ),
                        buildStrengthCard(mq, data),
                      ],
                    );
                  }),
                  SizedBox(
                    height: mq.height * 0.02,
                  ),
                  Consumer<MainPro>(builder: (con, mainPro, _) {
                    if (mainPro.publicPerformace.isEmpty) {
                      return Container();
                    }
                    var data = mainPro.publicPerformace[0];
                    return Column(
                      children: [
                        const Text(
                          'PUBLIC QUIZ',
                          style: TextStyle(
                            fontFamily: 'RapierZero',
                            color: kPrimaryLightColor,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: mq.height * 0.02,
                        ),
                        buildStrengthCard(mq, data),
                      ],
                    );
                  }),
                  SizedBox(
                    height: mq.height * 0.02,
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget buildSelectImage() {
    return CircleAvatar(
      radius: 50,
      backgroundColor: kSecondaryColor,
      child: CircleAvatar(
        radius: 46,
        backgroundColor: Colors.grey,
        backgroundImage: image == null
            ? AssetImage('assets/images/profile.png')
            : FileImage(image),
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

  Widget buildPerformanceChart(Size mq, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (ctx) => PerformanceChartScreen()),
        );
      },
      child: Container(
        height: mq.height * 0.065,
        width: mq.width,
        margin: EdgeInsets.symmetric(horizontal: mq.width * 0.1),
        decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: const Text(
            'PERFORMANCE CHART',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5),
          ),
        ),
      ),
    );
  }

  Widget buildViewScore(Size mq, BuildContext context) {
    return GestureDetector(
      onTap: () {
        final mainPro = Provider.of<MainPro>(context, listen: false);
        mainPro.clearPlayedResult();
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (ctx) => ViewScoreScreen()),
        );
      },
      child: Container(
        height: mq.height * 0.065,
        width: mq.width,
        margin: EdgeInsets.symmetric(horizontal: mq.width * 0.1),
        decoration: BoxDecoration(
          color: kPrimaryLightColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: const Text(
            'VIEW SCORE',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5),
          ),
        ),
      ),
    );
  }

  Widget buildStrengthCard(Size mq, dynamic data) {
    return Container(
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
                '${data.averagePercentage.toString().length >= 4 ? data.averagePercentage.toString().substring(0, 4) : data.averagePercentage}%',
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
              fontSize: 24,
              color: kPrimaryColor,
              fontFamily: 'DebugFreeTrial',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: List.generate(data.strengths.length, (index) {
              var strength = data.strengths[index];
              return buildSubjectStrength('${strength.category}',
                  "${strength.percentage.toString().length >= 4 ? strength.percentage.toString().substring(0, 4) : strength.percentage.toString()}");
            }),
          ),
          data.weeknesses.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'WEEKNESSES',
                      style: TextStyle(
                        fontSize: 24,
                        color: kPrimaryColor,
                        fontFamily: 'DebugFreeTrial',
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: List.generate(data.weeknesses.length, (index) {
                        var strength = data.weeknesses[index];
                        return buildSubjectStrength('${strength.category}',
                            "${strength.percentage.toString().length >= 4 ? strength.percentage.toString().substring(0, 4) : strength.percentage.toString()}");
                      }),
                    ),
                  ],
                )
              : Container(),
          const SizedBox(
            height: 10,
          ),
          buildMatchHistory(
            mq,
            data.totalMatchesPlayed.toString(),
            data.totalMatchesWinned.toString(),
          ),
          const SizedBox(
            height: 15,
          ),
          buildWinPercentage(
              mq,
              data.winningPercentage.toString().length >= 4
                  ? data.winningPercentage.toString().substring(0, 4)
                  : data.winningPercentage.toString()),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Widget buildSubjectStrength(String subject, String percentage) {
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

  Widget buildMatchHistory(Size mq, String totalPlayed, String totalWinned) {
    return Column(
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
        const SizedBox(
          height: 20,
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
                  totalPlayed,
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
                  totalWinned,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget buildWinPercentage(Size mq, String winPercentage) {
    return Row(
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
    );
  }
}
