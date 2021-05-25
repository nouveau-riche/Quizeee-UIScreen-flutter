import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quizeee_ui/provider/apiUrl.dart';
import 'package:quizeee_ui/provider/mainPro.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../widgets/my_drawer.dart';
import '../../widgets/shimmer_effect.dart';
import '../../widgets/toast.dart';
import 'component/quiz_model.dart';
import '../../constant.dart';
import '../notification/notification_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> getDashboardData() async {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    final resp = await mainPro.getDashBoardData();
    final res = await mainPro.getDashBoardBanner();
  }

  Future<bool> checkBookingStatus(String quizId, int quizIndex) async {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    // toast("Loading...", isError: false);
    mainPro.changeLoadingState(true);
    mainPro.saveCurrentQuizId(quizId: quizId, quizIndex: quizIndex);
    final resp = await mainPro.checkQuizBookingStatus(quizId);
    mainPro.changeLoadingState(false);

    cancelToast();
    if (!resp['status']) {
      return resp['status'];
    } else {
      toast(resp['message'], isError: true);
      return resp['status'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: kSecondaryColor,
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
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState.openDrawer();
              },
              child: Image.asset(
                'assets/images/hamburger.png',
                fit: BoxFit.fitHeight,
              ),
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
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (ctx) => NotificationScreen(),
                  ),
                );
              },
              child: Container(
                width: 42,
                margin: EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 7),
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                    margin: EdgeInsets.all(7),
                    child: Image.asset('assets/images/notification.png')),
              ),
            ),
          ],
        ),
        drawer: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(100),
            bottomRight: Radius.circular(40),
          ),
          child: MyDrawer(),
        ),
        body: Consumer<MainPro>(builder: (context, mainPro, _) {
          return FutureBuilder(
              future: mainPro.assignedQuiz.isEmpty && mainPro.publicQuiz.isEmpty
                  ? getDashboardData()
                  : null,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ListView.builder(
                    itemBuilder: (ctx, index) => buildShimmer(context),
                    itemCount: 5,
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      mainPro.dashboardBanner.isNotEmpty
                          ? buildPoster(
                              mq, mainPro.dashboardBanner[0].bannerImg)
                          : Container(),
                      SizedBox(
                        height: mq.height * 0.018,
                      ),
                      Consumer<MainPro>(
                        builder: (context, mainPro, _) => mainPro
                                .assignedQuiz.isEmpty
                            ? Container()
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'ASSIGNED QUIZ',
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
                                  Column(
                                      children: List.generate(
                                          mainPro.assignedQuiz.length, (index) {
                                    var data = mainPro.assignedQuiz[index];
                                    return QuizBox(
                                      reverseSlot: checkBookingStatus,
                                      image: 'assets/images/pos2.png',
                                      category: data.quizCategory.toUpperCase(),
                                      time: mainPro.stateEndDate(data),
                                      entryPrize: data.entryAmount.toString(),
                                      slots: null,
                                      prize: data.winningPrize.toString(),
                                      isSlotBooked: false,
                                      quizId: data.quizId.toString(),
                                      totalSlots: data.availableSlots != "null"
                                          ? data.availableSlots.toString()
                                          : "0",
                                      data: data,
                                      quizIndex: index,
                                    );
                                  }))
                                ],
                              ),
                      ),
                      SizedBox(
                        height: mq.height * 0.018,
                      ),
                      Consumer<MainPro>(
                        builder: (context, mainPro, _) => mainPro
                                .publicQuiz.isEmpty
                            ? Container()
                            : Column(
                                children: [
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
                                  Column(
                                      children: List.generate(
                                          mainPro.publicQuiz.length, (index) {
                                    var data = mainPro.publicQuiz[index];
                                    return QuizBox(
                                      reverseSlot: checkBookingStatus,
                                      image: 'assets/images/pos2.png',
                                      category: data.quizCategory.toUpperCase(),
                                      time: mainPro.stateEndDate(data),
                                      entryPrize: data.entryAmount.toString(),
                                      slots: data.availableSlots.toString(),
                                      prize: data.winningPrize.toString(),
                                      isSlotBooked: data.slots == 0,
                                      quizId: data.quizId.toString(),
                                      totalSlots: data.slots.toString(),
                                      data: data,
                                      quizIndex: index,
                                    );
                                  }))
                                ],
                              ),
                      ),
                    ],
                  ),
                );
              });
        }),
      ),
    );
  }
}

// yashjimanu@gmail
//

Widget buildPoster(Size mq, String imgNetwork) {
  return Container(
    height: mq.height * 0.16,
    width: mq.width,
    margin: EdgeInsets.all(mq.width * 0.034),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: ApiUrls.baseUrlImage + imgNetwork,
        placeholder: (context, url) => Image.asset(
          "assets/images/poster.png",
          fit: BoxFit.cover,
        ),
        errorWidget: (context, url, error) => Image.asset(
          "assets/images/poster.png",
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
