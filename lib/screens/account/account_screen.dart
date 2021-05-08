import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:quizeee/screens/login/login_screen.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // await FirebaseAuth.instance.signOut();
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     CupertinoPageRoute(
            //       builder: (context) => LoginScreen(),
            //     ),
            //     (route) => false);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.orange,
          ),
          child: Text(
            'Log out',
            style:
                TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
