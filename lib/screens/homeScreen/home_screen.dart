import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quizeee_ui/provider/apiUrl.dart';
import 'package:quizeee_ui/provider/mainPro.dart';
import 'package:quizeee_ui/widgets/toast.dart';

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
    final res = await mainPro.getDashBoardBanner();
  }

  Future<void> checkBookingStatus(String quizId) async {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    toast("Loading...", isError: false);
    final resp = await mainPro.checkQuizBookingStatus(quizId);
    // closeToast();
    if (!resp['status']) {
      toast(resp['message'], isError: true);
    } else {
      toast(resp['message'], isError: true);
    }
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
            Container(
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
          ],
        ),
        drawer: Drawer(),
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
                                      slots: data.slots.toString(),
                                      prize: data.winningPrize.toString(),
                                      isSlotBooked: data.slots == 0,
                                      quizId: data.quizId.toString(),
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
