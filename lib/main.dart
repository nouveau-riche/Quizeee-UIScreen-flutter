import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizeee_ui/screens/signup/dob_image.dart';

import './provider/initialPro.dart';
import './screens/login/login_screen.dart';
import 'package:quizeee_ui/screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Quizeee',
        home: LoginScreen(),
      ),
    );
  }
}
