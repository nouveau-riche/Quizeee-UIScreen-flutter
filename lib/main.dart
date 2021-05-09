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
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
    bool userExist = await auth.checkKeyExist("userId");
    if (userExist) {
      final response = await auth.getUserDetails();
      if (response['status']) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: FutureBuilder(
            future: checkLogin(),
            builder: (con, snap) =>
                snap.connectionState == ConnectionState.waiting
                    ? Stack(
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
                      )
                    : snap.data
                        ? TabsScreen()
                        : LoginScreen()),
      ),
    );
  }
}
