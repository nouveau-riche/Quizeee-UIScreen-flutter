import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:com.quizeee.quizeee/models/usernotifications.dart';
import 'package:com.quizeee.quizeee/provider/mainPro.dart';
import 'package:com.quizeee.quizeee/widgets/centerLoader.dart';
import 'package:com.quizeee.quizeee/widgets/toast.dart';

import '../../constant.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Future<void> getNotifications() async {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    final response = await mainPro.getUsersNotifications();
  }

  Future<void> deleteNotification(String notiId) async {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    toast("Loading....", isError: false);
    final response = await mainPro.deleteNotications(notiId);
    mainPro.notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final mainPro = Provider.of<MainPro>(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          children: [
            buildAppBar(context, mq),
            SizedBox(
              height: mq.height * 0.04,
            ),
            FutureBuilder(
                future: getNotifications(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      mainPro.userNofications.isEmpty) {
                    return Center(
                      child: SpinKitPouringHourglass(color: kSecondaryColor),
                    );
                  }
                  return Expanded(
                    child: Stack(
                      children: [
                        Consumer<MainPro>(
                          builder: (con, data, _) => data
                                  .userNofications.isEmpty
                              ? Center(
                                  child: Text(
                                    "No Notifications Received Yet!",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              : ListView.builder(
                                  itemBuilder: (ctx, index) => Stack(
                                    children: [
                                      Column(
                                        children: [
                                          buildNotificationMessage(
                                              mq,
                                              data.userNofications[index]
                                                  .message,
                                              data.formatTime.format(
                                                  DateTime.parse(data
                                                      .userNofications[index]
                                                      .notificationDate))),
                                          SizedBox(
                                            height: mq.height * 0.02,
                                          )
                                        ],
                                      ),
                                      Positioned(
                                          right: 10,
                                          child: GestureDetector(
                                            onTap: () {
                                              deleteNotification(data
                                                  .userNofications[index].sId);
                                            },
                                            child: Icon(
                                              Icons.dangerous,
                                              color: kSecondaryColor,
                                            ),
                                          ))
                                    ],
                                  ),
                                  itemCount: data.userNofications.length,
                                ),
                        ),
                        mainPro.isLoading
                            ? CenterLoader(isScaffoldRequired: false)
                            : Container()
                      ],
                    ),
                  );
                }),
          ],
        ),
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
          width: mq.width * 0.75,
          height: mq.height * 0.06,
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: const Text(
              'NOTIFICATION',
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNotificationMessage(Size mq, String message, String time) {
    return Container(
      margin: EdgeInsets.only(top: mq.height * 0.01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: mq.height * 0.06,
            width: mq.width * 0.125,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(left: mq.width * 0.02),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color.fromRGBO(52, 94, 103, 1),
            ),
            child: Image.asset('assets/images/notification.png'),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: mq.width * 0.75,
                height: mq.height * 0.06,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(71, 112, 118, 1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: mq.width * 0.05,
                    ),
                    Text(
                      message,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  time, // change time according to notification
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
