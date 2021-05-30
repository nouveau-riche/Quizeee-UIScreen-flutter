import 'dart:io';
import 'package:flutter/material.dart';

import '../../../constant.dart';

class EditProfile extends StatelessWidget {
  File image;

  TextEditingController _nameController =
      TextEditingController(text: 'Nikunj Sharma');
  TextEditingController _locationController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: mq.height * 0.05,
            ),
            buildAppBar(context, mq),
            buildSelectImage(),
            SizedBox(
              height: mq.height * 0.05,
            ),
            buildNameTextFieldField(mq),
            buildLocationTextFieldField(mq),
            buildEmailTextFieldField(mq),
            buildPhoneTextFieldField(mq),
            buildDobTextFieldField(mq),
            buildSaveButton(mq),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context, Size mq) {
    return Row(
      children: [
        Container(
          height: 45,
          width: mq.width * 0.12,
          margin: EdgeInsets.only(left: mq.width * 0.05),
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: kPrimaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }

  Widget buildSelectImage() {
    return GestureDetector(
      onTap: () {
// openDialogBox();
      },
      child: Stack(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundColor: kSecondaryColor,
            child: CircleAvatar(
              radius: 41,
              backgroundColor: Colors.grey,
              backgroundImage: image == null
                  ? AssetImage('assets/images/profile.png')
                  : FileImage(image),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 26,
              width: 28,
              decoration: BoxDecoration(
                color: kSecondaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNameTextFieldField(Size mq) {
    return Container(
      height: mq.height * 0.075,
      margin: EdgeInsets.symmetric(
          horizontal: mq.width * 0.05, vertical: mq.height * 0.015),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            kSecondaryColor.withOpacity(0.5),
            kSecondaryColor.withOpacity(0.1)
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            cursorColor: kPrimaryLightColor,
            style: TextStyle(
                color: kPrimaryLightColor,
                fontWeight: FontWeight.bold,
                fontSize: 12.5),
            decoration: InputDecoration(
              hintText: 'USERNAME',
              hintStyle: TextStyle(color: kPrimaryLightColor),
              border: InputBorder.none,
              suffixIcon: Icon(
                Icons.edit,
                color: kSecondaryColor,
                size: 18,
              ),
            ),
            controller: _nameController,
          ),
        ),
      ),
    );
  }

  Widget buildLocationTextFieldField(Size mq) {
    return Container(
      height: mq.height * 0.075,
      margin: EdgeInsets.symmetric(
          horizontal: mq.width * 0.05, vertical: mq.height * 0.015),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            kSecondaryColor.withOpacity(0.5),
            kSecondaryColor.withOpacity(0.1)
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            cursorColor: kPrimaryLightColor,
            style: TextStyle(
                color: kPrimaryLightColor,
                fontWeight: FontWeight.bold,
                fontSize: 12.5),
            decoration: InputDecoration(
              hintText: 'LOCATION',
              hintStyle: TextStyle(color: kPrimaryLightColor),
              border: InputBorder.none,
              suffixIcon: Icon(
                Icons.edit,
                color: kSecondaryColor,
                size: 18,
              ),
            ),
            controller: _locationController,
          ),
        ),
      ),
    );
  }

  Widget buildEmailTextFieldField(Size mq) {
    return Container(
      height: mq.height * 0.075,
      margin: EdgeInsets.symmetric(
          horizontal: mq.width * 0.05, vertical: mq.height * 0.015),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            kSecondaryColor.withOpacity(0.5),
            kSecondaryColor.withOpacity(0.1)
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            cursorColor: kPrimaryLightColor,
            style: TextStyle(
                color: kPrimaryLightColor,
                fontWeight: FontWeight.bold,
                fontSize: 12.5),
            decoration: InputDecoration(
              hintText: 'EMAIL',
              hintStyle: TextStyle(color: kPrimaryLightColor),
              border: InputBorder.none,
              suffixIcon: Icon(
                Icons.edit,
                color: kSecondaryColor,
                size: 18,
              ),
            ),
            controller: _emailController,
          ),
        ),
      ),
    );
  }

  Widget buildPhoneTextFieldField(Size mq) {
    return Container(
      height: mq.height * 0.075,
      margin: EdgeInsets.symmetric(
          horizontal: mq.width * 0.05, vertical: mq.height * 0.015),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            kSecondaryColor.withOpacity(0.5),
            kSecondaryColor.withOpacity(0.1)
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            cursorColor: kPrimaryLightColor,
            style: TextStyle(
                color: kPrimaryLightColor,
                fontWeight: FontWeight.bold,
                fontSize: 12.5),
            decoration: InputDecoration(
              hintText: 'PHONE NUMBER',
              hintStyle: TextStyle(color: kPrimaryLightColor),
              border: InputBorder.none,
              suffixIcon: Icon(
                Icons.edit,
                color: kSecondaryColor,
                size: 18,
              ),
            ),
            controller: _phoneController,
          ),
        ),
      ),
    );
  }

  Widget buildDobTextFieldField(Size mq) {
    return Container(
      height: mq.height * 0.075,
      margin: EdgeInsets.symmetric(
          horizontal: mq.width * 0.05, vertical: mq.height * 0.015),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            kSecondaryColor.withOpacity(0.5),
            kSecondaryColor.withOpacity(0.1)
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextField(
            cursorColor: kPrimaryLightColor,
            style: TextStyle(
                color: kPrimaryLightColor,
                fontWeight: FontWeight.bold,
                fontSize: 12.5),
            decoration: InputDecoration(
              hintText: 'DOB',
              hintStyle: TextStyle(color: kPrimaryLightColor),
              border: InputBorder.none,
              suffixIcon: Icon(
                Icons.edit,
                color: kSecondaryColor,
                size: 18,
              ),
            ),
            controller: _dobController,
          ),
        ),
      ),
    );
  }

  Widget buildSaveButton(Size mq) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: mq.height * 0.07,
        margin: EdgeInsets.symmetric(
            horizontal: mq.width * 0.05, vertical: mq.height * 0.015),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              kSecondaryColor.withOpacity(0.1),
              kSecondaryColor.withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: kPrimaryLightColor),
        ),
        child: Center(
          child: Text(
            'SAVE',
            style: TextStyle(
                color: kPrimaryLightColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
