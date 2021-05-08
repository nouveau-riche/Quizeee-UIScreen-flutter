import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Account',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
    );
  }
}
