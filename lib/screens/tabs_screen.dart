import 'package:flutter/material.dart';

import '../constant.dart';
import './account/account_screen.dart';
import './creatQuiz/create_quiz_screen.dart';
import 'homeScreen/home_screen.dart';
import './wallet/wallet_screen.dart';


class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Widget> screens = [
    HomeScreen(),
    WalletScreen(),
    CreateQuizScreen(),
    AccountScreen()
  ];

  int pageIndex = 0;

  void selectPage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        type: BottomNavigationBarType.fixed,
        onTap: selectPage,
        currentIndex: pageIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: kSecondaryColor,
        selectedIconTheme: IconThemeData(color: kSecondaryColor),
        unselectedIconTheme: IconThemeData(color: Colors.white24),
        selectedLabelStyle: TextStyle(fontSize: 11),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'DASHBOARD'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.create), label: 'Create'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
