import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant.dart';

class Support extends StatelessWidget {
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        leading: Container(
          height: 45,
          width: 40,
          margin: EdgeInsets.only(
              left: mq.width * 0.024,
              right: mq.width * 0.024,
              top: 7,
              bottom: 7),
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
        title: const Text(
          'CONTACT US',
          style: TextStyle(
            color: kSecondaryColor,
            fontSize: 40,
            fontFamily: 'DebugFreeTrial',
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: mq.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email,color: kSecondaryColor,size: 20,),
                SizedBox(width: 5,),
                const Text(
                  'Email',
                  style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: 25,
                    fontFamily: 'DebugFreeTrial',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: mq.height * 0.01,
            ),
            GestureDetector(
              onTap: () {
                _launchURL('mailto:sejpalbhargav67@gmail.com');
              },
              child: Container(
                width: mq.width * 0.75,
                height: mq.height * 0.06,
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: const Text(
                    'quizee@gmail.com',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: mq.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.call,color: kSecondaryColor,size: 20,),
                SizedBox(width: 5,),
                const Text(
                  'Phone',
                  style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: 25,
                    fontFamily: 'DebugFreeTrial',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: mq.height * 0.01,
            ),
            GestureDetector(
              onTap: () {
                _launchURL('tel:+917600896744');
              },
              child: Container(
                width: mq.width * 0.75,
                height: mq.height * 0.06,
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: const Text(
                    '+91 7879641574',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: mq.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.map,color: kSecondaryColor,size: 20,),
                SizedBox(width: 5,),
                const Text(
                  'Address',
                  style: TextStyle(
                    color: kSecondaryColor,
                    fontSize: 25,
                    fontFamily: 'DebugFreeTrial',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: mq.height * 0.01,
            ),
            GestureDetector(
              onTap: () {
                _launchURL(
                    'https://www.google.com/maps/place/Delhi/data=!4m2!3m1!1s0x390cfd5b347eb62d:0x37205b715389640?sa=X&ved=2ahUKEwiFlquiyeDxAhWCfH0KHfBuBaoQ8gEwAHoECAgQAQ');
              },
              child: Container(
                width: mq.width * 0.75,
                height: mq.height * 0.06,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: kPrimaryLightColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: const Text(
                    'ABC, Jaipur,Rajasthan 302017',
                    style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
