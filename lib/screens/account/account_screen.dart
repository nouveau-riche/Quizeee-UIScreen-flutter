import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizeee_ui/provider/initialPro.dart';
import 'package:quizeee_ui/widgets/toast.dart';

import '../login/login_screen.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<Auth>(
          builder: (con, states, _) => ElevatedButton(
            child: Text("Logout"),
            onPressed: () async {
              await states.removePreferences();
              toast('User logged out',isError: false);
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (context) => LoginScreen()),
                  (route) => false);
            },
          ),
        ),
      ),
    );
  }
}
