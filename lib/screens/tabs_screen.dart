import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizeee_ui/provider/mainPro.dart';
import 'package:quizeee_ui/widgets/centerLoader.dart';

import '../constant.dart';
import './account/account_screen.dart';
import './creatQuiz/create_quiz_screen.dart';
import './homeScreen/home_screen.dart';
import './wallet/wallet_screen.dart';

class TabMainScreen extends StatefulWidget {
  TabMainScreen({Key key}) : super(key: key);

  @override
  _TabMainScreenState createState() => _TabMainScreenState();
}

class _TabMainScreenState extends State<TabMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MainPro>(
        builder: (context, mainPro, _) => Stack(
          children: [
            TabsScreen(),
            mainPro.isLoading
                ? CenterLoader(
                    isScaffoldRequired: true,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

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
          BottomNavigationBarItem(
              icon: Container(
                height: 40,
                width: 50,
                child: pageIndex == 0
                    ? Image.asset(
                        'assets/images/home_fill.png',
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/home.png',
                        fit: BoxFit.cover,
                      ),
              ),
              label: 'DASHBOARD'),
          BottomNavigationBarItem(
              icon: Container(
                height: 36,
                width: 45,
                child: pageIndex == 1
                    ? Image.asset(
                        'assets/images/wallet_fill.png',
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/wallet.png',
                        fit: BoxFit.cover,
                      ),
              ),
              label: 'Wallet'),
          BottomNavigationBarItem(
              icon: Container(
                height: 28,
                width: 36,
                child: pageIndex == 2
                    ? Image.asset(
                        'assets/images/create_fill.png',
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/create.png',
                        fit: BoxFit.cover,
                      ),
              ),
              label: 'Create'),
          BottomNavigationBarItem(
              icon: Container(
                height: 28,
                width: 38,
                child: pageIndex == 3
                    ? Image.asset(
                        'assets/images/account_fill.png',
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/account.png',
                        fit: BoxFit.cover,
                      ),
              ),
              label: 'Account'),
        ],
      ),
    );
  }
}

// assets/images/account.png
