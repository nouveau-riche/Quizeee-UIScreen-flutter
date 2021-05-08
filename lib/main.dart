import 'package:flutter/material.dart';
import 'package:quizeee_ui/screens/tabs_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizeee',
      home: TabsScreen(),
    );
  }
}
