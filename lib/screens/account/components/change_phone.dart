import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

import '../../../constant.dart';

class ChangePhone extends StatefulWidget {
  final String phoneNumber;

  ChangePhone({this.phoneNumber});

  @override
  _ChangePhoneState createState() => _ChangePhoneState();
}

class _ChangePhoneState extends State<ChangePhone> {

  final _formKey = GlobalKey<FormState>();
  String _phoneNumber;

  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: kSecondaryColor,
    borderRadius: BorderRadius.circular(10.0),
  );


  save(){
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();

      /// verify for otp

    }
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              buildAppBar(context, mq),
              SizedBox(
                height: mq.height * 0.1,
              ),
              Form(
                key: _formKey,
                child: buildPhoneTextFieldField(mq),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: PinPut(
                  fieldsCount: 6,
                  textStyle: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                  eachFieldWidth: 40.0,
                  eachFieldHeight: 48.0,
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  submittedFieldDecoration: pinPutDecoration,
                  selectedFieldDecoration: pinPutDecoration,
                  followingFieldDecoration: pinPutDecoration,
                  pinAnimationType: PinAnimationType.fade,
                  onSubmit: (pin) {
                    /// build logic for checking otp
                  },
                ),
              ),
              SizedBox(height: mq.height*0.1,),
              buildVerifyButton(),
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
      child: Container(
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(4),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          readOnly: true,
          cursorColor: kPrimaryLightColor,
          style: TextStyle(
              color: kPrimaryLightColor,
              fontWeight: FontWeight.bold,
              fontSize: 12.5),
          decoration: InputDecoration(
            hintText: 'PHONE NUMBER',
            hintStyle: TextStyle(color: kPrimaryLightColor),
            border: InputBorder.none,
          ),
          initialValue: widget.phoneNumber,
          // ignore: missing_return
          validator: (_value) {
            if (_value.isEmpty) {
              return kPhoneNumberNullError;
            }
            if (_value.length != 10) {
              return kInvalidPhoneError;
            }
          },
          onSaved: (_value) {
            _phoneNumber = _value;
          },
          // controller: _phoneController,
        ),
      ),
    );
  }

  Widget buildVerifyButton() {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: 68, height: 55),
      child: ElevatedButton(
        onPressed: () {
          save();
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          primary: kPrimaryLightColor,
        ),
        child: const Text(
          'Verify',
          style: TextStyle(
              fontSize: 12.8, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
    );
  }
}
