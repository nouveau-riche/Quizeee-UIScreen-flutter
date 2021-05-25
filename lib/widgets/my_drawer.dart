import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import '../widgets/toast.dart';
import '../provider/initialPro.dart';
import '../screens/login/login_screen.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Drawer(
      child: Container(
        color: kPrimaryColor,
        child: ListView(
          children: [
            buildDrawerHead(mq),
            buildListTile(mq, Icons.notifications, 'Notification Settings'),
            buildListTile(mq, CupertinoIcons.person_circle_fill, 'About Us'),
            buildListTile(mq, Icons.report_problem, 'Report'),
            buildListTile(mq, Icons.settings, 'Support'),
            buildLogoutListTile(context,mq),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerHead(Size mq) {
    return Container(
      height: mq.height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: mq.height * 0.045,
            width: mq.width * 0.12,
            child: Image.asset('assets/images/menubar.png'),
          ),
          SizedBox(
            height: 10,
          ),
          const Text(
            'MENUBAR',
            style: TextStyle(
                color: kSecondaryColor,
                fontFamily: 'DebugFreeTrial',
                fontSize: 28),
          ),
        ],
      ),
    );
  }

  Widget buildListTile(Size mq, IconData iconData, String title) {
    return ListTile(
      dense: true,
      leading: Container(
        margin: EdgeInsets.only(left: mq.width * 0.04),
        child: Icon(
          iconData,
          size: 21,
          color: kSecondaryColor,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
            color: kSecondaryColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildLogoutListTile(BuildContext context, Size mq) {
    return Consumer<Auth>(
      builder: (con, states, _) => ListTile(
        onTap: () async {
          await states.removePreferences();
          toast('User logged out', isError: false);
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(
                  builder: (context) => LoginScreen(),
                ),
                (route) => false);
          });
        },
        dense: true,
        leading: Container(
          margin: EdgeInsets.only(left: mq.width * 0.04),
          child: Icon(
            Icons.exit_to_app,
            size: 21,
            color: kSecondaryColor,
          ),
        ),
        title: Text(
          'Logout',
          style: const TextStyle(
              color: kSecondaryColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
