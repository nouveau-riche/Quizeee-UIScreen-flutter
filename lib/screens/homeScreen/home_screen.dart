import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quizeee_ui/provider/mainPro.dart';

import '../../widgets/shimmer_effect.dart';
import 'component/quiz_model.dart';
import '../../constant.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Widget> allQuizes = [
    QuizBox(
      image: 'assets/images/pos1.png',
      category: 'HISTORY',
      time: '03H: 12M: 02S',
      entryPrize: '5',
      slots: '4',
      prize: '49',
      isSlotBooked: false,
    ),
  ];
  Future<void> getDashboardData() async {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    final resp = await mainPro.getDashBoardData();
  }

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
          elevation: 0,
          leading: Container(
            margin: EdgeInsets.only(left: 8, top: 7, bottom: 7, right: 7),
            decoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Container(
                height: 35,
                width: 35,
                child: Image.asset(
                  'assets/images/hamburger.png',
                  fit: BoxFit.fill,
                ),
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
                fontFamily: 'MajorLeagueDuty',
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
                child: Image.asset('assets/images/notification.png'),
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
                    fontFamily: 'RapierZero',
                    color: kPrimaryLightColor,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: mq.height * 0.018,
            ),
            Consumer<MainPro>(
              builder: (context, mainPro, _) => FutureBuilder(
                  future:
                      mainPro.assignedQuiz.isEmpty ? getDashboardData() : null,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                        child: ListView.builder(
                          itemBuilder: (ctx, index) => buildShimmer(context),
                          itemCount: 5,
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemBuilder: (ctx, index) {
                            var data = mainPro.assignedQuiz[index];

                            return QuizBox(
                              image: 'assets/images/pos2.png',
                              category: data.quizCategory.toUpperCase(),
                              time: data.endTime,
                              entryPrize: data.entryAmount.toString(),
                              slots: '20',
                              prize: data.winningPrize.toString(),
                              isSlotBooked: false,
                            );
                          },
                          itemCount: mainPro.assignedQuiz.length,
                        ),
                      );
                    }
                  }),
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
