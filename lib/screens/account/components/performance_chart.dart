import 'package:flutter/material.dart';

import '../../../constant.dart';

class PerformanceChartScreen extends StatefulWidget {
  @override
  _PerformanceChartScreenState createState() => _PerformanceChartScreenState();
}

class _PerformanceChartScreenState extends State<PerformanceChartScreen> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: mq.height * 0.05,
            ),
            buildAppBar(context, mq),
            SizedBox(
              height: mq.height * 0.025,
            ),
            const Text(
              'ASSIGNED QUIZ',
              style: TextStyle(
                fontFamily: 'RapierZero',
                color: kPrimaryLightColor,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: mq.height * 0.025,
            ),
            buildHeader(mq, context, 'CATEGORY'),
            SizedBox(
              height: mq.height * 0.025,
            ),
            buildChart(mq),
            SizedBox(
              height: mq.height * 0.025,
            ),
            buildHeader(mq, context, 'SUB-CATEGORY'),
            SizedBox(
              height: mq.height * 0.025,
            ),
            buildChart(mq),
            SizedBox(
              height: mq.height * 0.025,
            ),
            buildHeader(mq, context, 'AREA OF INTEREST'),
            SizedBox(
              height: mq.height * 0.025,
            ),
            buildChart(mq),
            SizedBox(
              height: mq.height * 0.04,
            ),
            const Text(
              'PUBLIC QUIZ',
              style: TextStyle(
                fontFamily: 'RapierZero',
                color: kPrimaryLightColor,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: mq.height * 0.025,
            ),
            buildHeader(mq, context, 'CATEGORY'),
            SizedBox(
              height: mq.height * 0.025,
            ),
            buildChart(mq),
            SizedBox(
              height: mq.height * 0.025,
            ),
            buildHeader(mq, context, 'SUB-CATEGORY'),
            SizedBox(
              height: mq.height * 0.025,
            ),
            buildChart(mq),
            SizedBox(
              height: mq.height * 0.025,
            ),
            buildHeader(mq, context, 'AREA OF INTEREST'),
            SizedBox(
              height: mq.height * 0.025,
            ),
            buildChart(mq),
            SizedBox(
              height: mq.height * 0.025,
            ),
          ],
        ),
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
          style: TextStyle(fontSize: 22, color: kSecondaryColor),
        ),
      ],
    );
  }

  int index = 0;

  Widget buildHeader(Size mq, BuildContext context, String type) {
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
      child: type == 'CATEGORY'
          ? Center(
              child: Text(
                type,
                style: TextStyle(
                    color: kPrimaryLightColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5),
              ),
            )
          : DropdownButtonHideUnderline(
              child: DropdownButton(
                value: index,
                items: [
                  DropdownMenuItem(
                    child: const Text(
                      '                              SUB-CATEGORY',
                      // don't remove space it's for center align
                      style: TextStyle(
                          color: kPrimaryLightColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.5),
                    ),
                    value: 0,
                  ),
                  DropdownMenuItem(
                    child: const Text(
                      '                               BBBB',
                      style: TextStyle(
                          color: kPrimaryLightColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.5),
                    ),
                    value: 1,
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    index = value;
                  });
                },
              ),
            ),
    );
  }

  Widget buildChart(Size mq) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildYAxis(mq),
        Column(
          children: [
            Container(
              height: mq.height * 0.24,
              width: mq.width * 0.8,
              margin: EdgeInsets.only(left: 2),
              child: Container(
                height: mq.height * 0.24,
                width: mq.width * 0.8,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: kSecondaryColor, width: 1.5),
                    left: BorderSide(color: kSecondaryColor, width: 1.5),
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Divider(
                          color: kSecondaryColor,
                        ),
                        SizedBox(
                          height: mq.height * 0.046,
                        ),
                        Divider(
                          color: kSecondaryColor,
                        ),
                        SizedBox(
                          height: mq.height * 0.046,
                        ),
                        Divider(
                          color: kSecondaryColor,
                        ),
                        SizedBox(
                          height: mq.height * 0.046,
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: mq.width * 0.05,
                            ),
                            buildGraphBar(mq, 20),
                            SizedBox(
                              width: mq.width * 0.05,
                            ),
                            buildGraphBar(mq, 40),
                            SizedBox(
                              width: mq.width * 0.05,
                            ),
                            buildGraphBar(mq, 50),
                            SizedBox(
                              width: mq.width * 0.05,
                            ),
                            buildGraphBar(mq, 60.0),
                            SizedBox(
                              width: mq.width * 0.05,
                            ),
                            buildGraphBar(mq, 10.0),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            buildXAxis(mq),
          ],
        ),
      ],
    );
  }

  Widget buildYAxis(Size mq) {
    return Container(
      height: mq.height * 0.24,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: mq.height * 0.005,
          ),
          Text(
            '60',
            style: TextStyle(color: kPrimaryLightColor, fontSize: 9),
          ),
          SizedBox(
            height: mq.height * 0.045,
          ),
          Text(
            '40',
            style: TextStyle(color: kPrimaryLightColor, fontSize: 9),
          ),
          SizedBox(
            height: mq.height * 0.045,
          ),
          Text(
            '20',
            style: TextStyle(color: kPrimaryLightColor, fontSize: 9),
          ),
          SizedBox(
            height: mq.height * 0.045,
          ),
          Text(
            '00',
            style: TextStyle(color: kPrimaryLightColor, fontSize: 9),
          ),
        ],
      ),
    );
  }

  Widget buildXAxis(Size mq) {
    return Container(
      width: mq.width * 0.86,
      margin: EdgeInsets.only(left: 2, top: 4),
      child: Row(
        children: [
          SizedBox(
            width: mq.width * 0.08,
          ),
          Container(
            width: 30,
            margin: EdgeInsets.only(left: 4),
            child: Text(
              'Math',
              style: TextStyle(color: kPrimaryLightColor, fontSize: 8.5),
            ),
          ),
          SizedBox(
            width: mq.width * 0.05,
          ),
          Container(
            width: 30,
            child: Text(
              'Science',
              style: TextStyle(color: kPrimaryLightColor, fontSize: 8.5),
            ),
          ),
          SizedBox(
            width: mq.width * 0.05,
          ),
          Container(
            width: 30,
            margin: EdgeInsets.only(left: 2),
            child: Text(
              'Java',
              style: TextStyle(color: kPrimaryLightColor, fontSize: 8.5),
            ),
          ),
          SizedBox(
            width: mq.width * 0.05,
          ),
          Container(
            width: 30,
            child: Text(
              'History',
              style: TextStyle(color: kPrimaryLightColor, fontSize: 8.5),
            ),
          ),
          SizedBox(
            width: mq.width * 0.05,
          ),
          Container(
            width: 30,
            margin: EdgeInsets.only(left: 2),
            child: Text(
              'Games',
              style: TextStyle(color: kPrimaryLightColor, fontSize: 8.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGraphBar(Size mq, double score) {
    double height = mq.height * 0.062;

    double sc = score / 20.0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: height * sc,
      width: 22,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }
}
