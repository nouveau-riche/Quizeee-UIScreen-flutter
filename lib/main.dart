import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

import './constant.dart';
import './provider/initialPro.dart';
import './provider/mainPro.dart';
import './provider/states.dart';
import './screens/login/login_screen.dart';
import './screens/tabs_screen.dart';
import './widgets/centerLoader.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initOneSignal();
  }

  Future<void> initOneSignal() async {
    await OneSignal.shared.init(oneSignalKey).catchError((e) {
      print(e.toString());
    });

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    OneSignal.shared.setNotificationOpenedHandler((openedResult) {
      print(openedResult.notification);
    });

    OneSignal.shared.setNotificationReceivedHandler((notification) {
      print(notification.androidNotificationId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: AppStates()),
        ChangeNotifierProxyProvider<Auth, MainPro>(
          create: (_) => MainPro(),
          update: (_, auth, products) => products..upate(auth),
        ),
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
            CupertinoPageRoute(builder: (context) => TabMainScreen()),
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
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: checkLogin(),
          builder: (con, snap) => Stack(
            children: [
              LoginScreen(),
              CenterLoader(
                isScaffoldRequired: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
