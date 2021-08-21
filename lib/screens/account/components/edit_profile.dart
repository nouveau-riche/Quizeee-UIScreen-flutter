import 'dart:io';
import 'package:com.quizeee.quizeee/provider/apiUrl.dart';
import 'package:com.quizeee.quizeee/provider/initialPro.dart';
import 'package:com.quizeee.quizeee/provider/mainPro.dart';
import 'package:com.quizeee.quizeee/screens/account/components/change_phone.dart';
import 'package:com.quizeee.quizeee/screens/account/components/edit_email.dart';
import 'package:com.quizeee.quizeee/widgets/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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
  final _formKey = GlobalKey<FormState>();

  int _locationIndex = 0;

  String _username;
  String _location;
  String _email;
  String _phoneNumber;

  File image;

  final picker = ImagePicker();

  Future pickImageFromGallery() async {
    try {
      final imageFile = await picker.getImage(source: ImageSource.gallery);
      if (mounted) {
        setState(() {
          image = File(imageFile.path);
          profileUrl = null;
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
          profileUrl = null;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  //
  // TextEditingController _nameController = TextEditingController();
  // TextEditingController _locationController = TextEditingController();
  // TextEditingController _emailController = TextEditingController();
  // TextEditingController _phoneController = TextEditingController();

  String profileUrl;

  @override
  void initState() {
    super.initState();
    initialUserData();
  }

  initialUserData() {
    final userEdit = Provider.of<Auth>(context, listen: false);
    final mainPro = Provider.of<MainPro>(context, listen: false);
    _username = userEdit.userModel[0].username;
    _location = userEdit.userModel[0].location;

    int inx = states.indexWhere((element) {
      if (element == _location) {
        return true;
      }
      return false;
    });

    if (inx != -1) {
      _locationIndex = inx;
    }

    _email = userEdit.userModel[0].email == "null"
        ? null
        : userEdit.userModel[0].email;
    _phoneNumber = userEdit.userModel[0].phone == "null"
        ? null
        : userEdit.userModel[0].phone;
    // _nameController.text = userEdit.userModel[0].username;
    // _locationController.text = userEdit.userModel[0].location;
    // _emailController.text = userEdit.userModel[0].email;
    // _phoneController.text = userEdit.userModel[0].phone;
    profileUrl = userEdit.userModel[0].profilePic;
  }

  Future<void> submit(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      print(_location);

      final userEdit = Provider.of<Auth>(context, listen: false);
      var body = new FormData.fromMap({
        "userId": userEdit.userModel[0].userId,
        // "username": _nameController.text ?? null,
        // "location": _locationController.text ?? null,
        // "email": _emailController.text ?? null,
        // "phone": _phoneController.text ?? null,
        "username": _username ?? null,
        "location": _location ?? null,
        "email": userEdit.editedEmail ?? _email ?? null,
        "phone": userEdit.editedPhone ?? _phoneNumber ?? null,
        "profilePic": image != null
            ? image.path != null
                ? await MultipartFile.fromFile(image.path,
                    filename: 'upload.png')
                : null
            : profileUrl ?? null
      });
      userEdit.setLoading(true);
      final response = await userEdit.editUserProfile(body);
      userEdit.setLoading(false);
      toast(
          response['status']
              ? "User profile updated"
              : response['status'] ?? "Something went wrong",
          isError: !response['status']);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              buildAppBar(context, mq),
              buildSelectImage(),
              SizedBox(
                height: mq.height * 0.05,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildNameTextFieldField(mq),
                    buildLocationTextFieldField(mq),
                    buildEmailTextFieldField(mq),
                    buildPhoneTextFieldField(mq),
                  ],
                ),
              ),
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

  openDialogBox() {
    showDialog(
        context: context,
        builder: (ctx) => SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: kPrimaryColor,
              children: <Widget>[
                SimpleDialogOption(
                    child: const Text(
                      "Capture Image with Camera",
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      captureImageFromCamera();
                    }),
                SimpleDialogOption(
                    child: const Text(
                      "Pick Image from Gallery",
                      style: const TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      pickImageFromGallery();
                    }),
                SimpleDialogOption(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        const Text(
                          "Cancel",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ],
            ));
  }

  Widget buildSelectImage() {
    return GestureDetector(
      onTap: () {
        openDialogBox();
      },
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: kSecondaryColor,
            child: CircleAvatar(
              radius: 47,
              backgroundColor: Colors.grey,
              backgroundImage: profileUrl != null
                  ? NetworkImage(ApiUrls.baseUrlImage + profileUrl)
                  : image == null
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
      // height: mq.height * 0.075,
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
          child: TextFormField(
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
            initialValue: _username ?? "",
            // ignore: missing_return
            validator: (_value) {
              if (_value.isEmpty) {
                return kNameNullError;
              }
            },
            onSaved: (_value) {
              _username = _value;
            },
            // controller: _nameController,
          ),
        ),
      ),
    );
  }

  Widget buildLocationTextFieldField(Size mq) {
    return Container(
      // height: mq.height * 0.075,
      width: mq.width,
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

      child: Container(
        width: mq.width,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: _locationIndex,
            items: stateDropDownListForEditProfile,
            onChanged: (value) {
              setState(() {
                _locationIndex = value;
                _location = states[_locationIndex];
              });
            },
          ),
        ),
        // child: TextFormField(
        //   cursorColor: kPrimaryLightColor,
        //   style: TextStyle(
        //       color: kPrimaryLightColor,
        //       fontWeight: FontWeight.bold,
        //       fontSize: 12.5),
        //   decoration: InputDecoration(
        //     hintText: 'LOCATION',
        //     hintStyle: TextStyle(color: kPrimaryLightColor),
        //     border: InputBorder.none,
        //     suffixIcon: Icon(
        //       Icons.edit,
        //       color: kSecondaryColor,
        //       size: 18,
        //     ),
        //   ),
        //   initialValue: _location,
        //   // ignore: missing_return
        //   validator: (_value) {
        //     if (_value.isEmpty) {
        //       return kLocationNullError;
        //     }
        //   },
        //   onSaved: (_value) {
        //     _location = _value;
        //   },
        //   // controller: _locationController,
        // ),
      ),
    );
  }

  Widget buildEmailTextFieldField(Size mq) {
    final initialPro = Provider.of<Auth>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (ctx) => ChangeEmail(
              email: initialPro.editedEmail ?? _email ?? "",
            ),
          ),
        );
      },
      child: Container(
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
            height: mq.height,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.all(4),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Consumer<Auth>(builder: (context, auth, _) {
                  return Text(
                    auth.editedEmail ?? _email ?? "Enter valid email id",
                    style: TextStyle(
                      color: kPrimaryLightColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.5,
                    ),
                  );
                }),
                Spacer(),
                Icon(
                  Icons.edit,
                  color: kSecondaryColor,
                  size: 18,
                ),
                SizedBox(
                  width: mq.width * 0.04,
                )
              ],
            ),
            // child: TextFormField(
            //   cursorColor: kPrimaryLightColor,
            //   style: TextStyle(
            //       color: kPrimaryLightColor,
            //       fontWeight: FontWeight.bold,
            //       fontSize: 12.5),
            //   decoration: InputDecoration(
            //     hintText: 'EMAIL',
            //     hintStyle: TextStyle(color: kPrimaryLightColor),
            //     border: InputBorder.none,
            //     suffixIcon: Icon(
            //       Icons.edit,
            //       color: kSecondaryColor,
            //       size: 18,
            //     ),
            //   ),
            //   initialValue: _email,
            //   // ignore: missing_return
            //   validator: (_value) {
            //     if (_value.isEmpty) {
            //       return kEmailNullError;
            //     }
            //     bool emailValid = emailValidatorRegExp.hasMatch(_value);
            //     if (!emailValid) {
            //       return kInvalidEmailError;
            //     }
            //   },
            //   onSaved: (_value) {
            //     _email = _value;
            //   },
            //
            //   // controller: _emailController,
            // ),
          ),
        ),
      ),
    );
  }

  Widget buildPhoneTextFieldField(Size mq) {
    final initialPro = Provider.of<Auth>(context, listen: false);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (ctx) => ChangePhone(
              phoneNumber: initialPro.editedPhone ?? _phoneNumber ?? "",
            ),
          ),
        );
      },
      child: Container(
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
        child: Container(
          height: mq.height,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Consumer<Auth>(builder: (context, auth, _) {
                return Text(
                  auth.editedPhone ??
                      _phoneNumber ??
                      "Enter valid phone number",
                  style: TextStyle(
                    color: kPrimaryLightColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5,
                  ),
                );
              }),
              Spacer(),
              Icon(
                Icons.edit,
                color: kSecondaryColor,
                size: 18,
              ),
              SizedBox(
                width: mq.width * 0.04,
              )
            ],
          ),
          // child: TextFormField(
          //   readOnly: true,
          //   cursorColor: kPrimaryLightColor,
          //   style: TextStyle(
          //       color: kPrimaryLightColor,
          //       fontWeight: FontWeight.bold,
          //       fontSize: 12.5),
          //   decoration: InputDecoration(
          //     hintText: 'PHONE NUMBER',
          //     hintStyle: TextStyle(color: kPrimaryLightColor),
          //     border: InputBorder.none,
          //     suffixIcon: Icon(
          //       Icons.edit,
          //       color: kSecondaryColor,
          //       size: 18,
          //     ),
          //   ),
          //   initialValue: _phoneNumber,
          //   // ignore: missing_return
          //   validator: (_value) {
          //     if (_value.isEmpty) {
          //       return kPhoneNumberNullError;
          //     }
          //     if (_value.length != 10) {
          //       return kInvalidPhoneError;
          //     }
          //   },
          //   onSaved: (_value) {
          //     _phoneNumber = _value;
          //   },
          //   // controller: _phoneController,
          // ),
        ),
      ),
    );
  }

  Widget buildSaveButton(Size mq) {
    return GestureDetector(
      onTap: () {
        submit(context);
      },
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
