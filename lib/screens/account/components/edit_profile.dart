import 'dart:io';
import 'package:com.quizeee.quizeee/provider/initialPro.dart';
import 'package:com.quizeee.quizeee/widgets/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File image;

  final picker = ImagePicker();

  Future pickImageFromGallery() async {
    try {
      final imageFile = await picker.getImage(source: ImageSource.gallery);
      if (mounted) {
        setState(() {
          image = File(imageFile.path);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future captureImageFromCamera() async {
    try {
      final imageFile = await picker.getImage(source: ImageSource.camera);
      if (mounted) {
        setState(() {
          image = File(imageFile.path);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  TextEditingController _nameController =
      TextEditingController();

  TextEditingController _locationController = TextEditingController();

  TextEditingController _emailController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  TextEditingController _dobController = TextEditingController();

  Future<void> submit(BuildContext context) async {
    final userEdit = Provider.of<Auth>(context, listen: false);
    var body = new FormData.fromMap({
      "username": _nameController.text ?? null,
      "location": _locationController.text ?? null,
      "email": _emailController.text ?? null,
      "phone": "+91" + _phoneController.text ?? null,
      "dateOfBirth": _dobController.text ?? null,
      "profilePic": image.path != null
          ? await MultipartFile.fromFile(image.path, filename: 'upload.png')
          : null
    });
    userEdit.setLoading(true);
    final response = await userEdit.editUserProfile(body);
    userEdit.setLoading(false);
    toast(response['msg'], isError: !response['status']);
  }

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
            Selector<Auth, bool>(
                selector: (con, auth) => auth.isLoading,
                builder: (context, state, _) {
                  return state
                      ? SpinKitPouringHourglass(color: kSecondaryColor)
                      : GestureDetector(
                          onTap: () {
                            submit(context);
                          },
                          child: buildSaveButton(mq));
                }),
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
