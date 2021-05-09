import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quizeee_ui/provider/initialPro.dart';
import 'package:quizeee_ui/provider/states.dart';
import 'package:quizeee_ui/screens/login/login_screen.dart';
import 'package:quizeee_ui/screens/tabs_screen.dart';

import 'constant.dart';

void main() {
  runApp(MyApp());
  ErrorWidget.builder = (FlutterErrorDetails details) {
    bool inDebug = false;
    assert(() {
      inDebug = true;
      return true;
    }());
    // In debug mode, use the normal error widget which shows
    // the error message:
    if (inDebug) return ErrorWidget(details.exception);
    // In release builds, show a yellow-on-blue message instead:
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Error! ${details.exception} ${details.context} ${details.informationCollector} ${details.library}',
        style: TextStyle(color: Colors.black, fontSize: 14),
        textDirection: TextDirection.ltr,
      ),
    );
  };
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: AppStates()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quizeee',
        home: NavigateScreen(),
      ),
    );
  }
}

class NavigateScreen extends StatefulWidget {
  NavigateScreen({Key key}) : super(key: key);

  @override
  _NavigateScreenState createState() => _NavigateScreenState();
}

class _NavigateScreenState extends State<NavigateScreen> {
  Future<bool> checkLogin() async {
    final auth = Provider.of<Auth>(context, listen: false);
    final userExist = await auth.checkKeyExist("userId");
    if (userExist != null) {
      final response = await auth.getUserDetails();
      if (response['status']) {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => TabsScreen()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      }
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => LoginScreen()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: FutureBuilder(
            future: checkLogin(),
            builder: (con, snap) => Stack(
                  children: [
                    LoginScreen(),
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.black.withOpacity(0.7),
                      child: Center(
                        child: Container(
                          width: mq.width * 0.50,
                          height: mq.height * 0.15,
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              CircularProgressIndicator(),
                              Spacer(),
                              Text("Loading....",
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SairaStencilOne',
                                  )),
                              SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )),
      ),
    );
  }
}
