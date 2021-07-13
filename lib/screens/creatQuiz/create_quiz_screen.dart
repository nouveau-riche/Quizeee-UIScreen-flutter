import 'package:com.quizeee.quizeee/provider/apiUrl.dart';
import 'package:com.quizeee.quizeee/provider/mainPro.dart';
import 'package:com.quizeee.quizeee/screens/creatQuiz/webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class CreateQuizScreen extends StatefulWidget {
  @override
  _CreateQuizScreenState createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: mq.height * 0.02,
            ),
            const Text(
              'CREATE QUIZ',
              style: TextStyle(
                color: kSecondaryColor,
                fontSize: 40,
                fontFamily: 'DebugFreeTrial',
              ),
            ),
            SizedBox(
              height: mq.height * 0.02,
            ),
            Container(
              width: mq.width,
              margin: EdgeInsets.all(20),
              child: Text(
                'Create free quiz & play with your friends & family',
                style: TextStyle(
                  fontSize: 32,
                  color: kPrimaryLightColor,
                  fontFamily: 'DebugFreeTrial',
                ),
              ),
            ),
            SizedBox(
              height: mq.height * 0.025,
            ),
            buildCreateNowButton(mq),
            SizedBox(
              height: mq.height * 0.08,
            ),
            Container(
              width: mq.width,
              margin: EdgeInsets.all(20),
              child: const Text(
                'If You Want to become an quizeee master or want to create quiz for your students?\nFor more information please connect with the admin',
                style: TextStyle(
                  fontSize: 26,
                  color: kPrimaryLightColor,
                  fontFamily: 'DebugFreeTrial',
                ),
              ),
            ),
            SizedBox(
              height: mq.height * 0.025,
            ),
            buildConnectAdmin(mq),
          ],
        ),
      ),
    );
  }

  Widget buildCreateNowButton(Size mq) {
    return SizedBox(
      height: 46,
      width: mq.width * 0.5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          final mainPro = Provider.of<MainPro>(context, listen: false);
          Navigator.of(context).push(
            CupertinoPageRoute(
                builder: (ctx) => WebViewGlobal(
                      url: ApiUrls.createQuiz + mainPro.getUserID,
                      title: "CREATE QUIZ",
                    )),
          );
        },
        child: Text(
          'Create Now',
          style: TextStyle(
            color: kPrimaryColor,
            fontFamily: 'DebugFreeTrial',
            fontSize: 28,
          ),
        ),
      ),
    );
  }

  Widget buildConnectAdmin(Size mq) {
    return SizedBox(
      height: 46,
      width: mq.width * 0.5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {},
        child: Text(
          'Connect Admin',
          style: TextStyle(
            color: kPrimaryColor,
            fontFamily: 'DebugFreeTrial',
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}
