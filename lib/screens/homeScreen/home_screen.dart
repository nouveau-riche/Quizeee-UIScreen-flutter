import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'component/quiz_model.dart';
import '../../constant.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Widget> allQuizes = [
    QuizBox(
      image: 'assets/images/pos2.png',
      category: 'SCIENCE',
      time: '12H: 34M: 30S',
      entryPrize: '10',
      slots: '20',
      prize: '100',
    ),
    QuizBox(
      image: 'assets/images/pos1.png',
      category: 'HISTORY',
      time: '03H: 12M: 02S',
      entryPrize: '5',
      slots: '4',
      prize: '49',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: kPrimaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: kPrimaryColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leading: Container(
            margin: EdgeInsets.only(left: 8, top: 7, bottom: 7, right: 7),
            decoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Container(
                height: 40,
                width: 40,
                child: Image.asset('assets/images/hamburger.png'),
              ),
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
            ),
          ),
          centerTitle: true,
          title: const Text(
            'QUIZEEE',
            style: TextStyle(
                color: kTextColor,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: 'SairaStencilOne',
                decoration: TextDecoration.underline),
          ),
          actions: [
            Container(
              width: 42,
              margin: EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 7),
              decoration: BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset('assets/images/profile.png'),
              ),
            ),
          ],
        ),
        drawer: Drawer(),
        body: Column(
          children: [
            buildPoster(mq.height * 0.16, mq.width),
            SizedBox(
              height: mq.height * 0.018,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'PLAY ANY QUIZ',
                  style: TextStyle(
                    fontFamily: 'rapier zero',
                    color: kPrimaryLightColor,
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: mq.height * 0.018,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (ctx, index) => allQuizes[index],
                itemCount: allQuizes.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildPoster(double height, double width) {
  return Container(
    height: height,
    width: width,
    margin: EdgeInsets.all(14),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/images/poster.png',
          fit: BoxFit.cover,
        )),
  );
}
