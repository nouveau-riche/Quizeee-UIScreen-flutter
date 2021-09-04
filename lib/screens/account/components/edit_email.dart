import 'package:com.quizeee.quizeee/provider/initialPro.dart';
import 'package:com.quizeee.quizeee/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';

class ChangeEmail extends StatefulWidget {
  final String email;

  ChangeEmail({this.email});

  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  bool isLoading = false;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: kSecondaryColor,
    borderRadius: BorderRadius.circular(10.0),
  );

  save() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (isOtpSent) {
        saveOtp();
      } else {
        sendOtp();
      }
    }
  }

  void getBack() async {
    final intialPro = Provider.of<Auth>(context, listen: false);
    intialPro.editedEmail = _email ?? widget.email;
    intialPro.notifyListeners();
    Navigator.pop(context);
  }

  bool isOtpSent = false;
  var resp;
  String verifySub = "Send Otp";

  Future<void> sendOtp() async {
    final intialPro = Provider.of<Auth>(context, listen: false);
    var body = {"email": _email};
    setLoading(true);
    resp = await intialPro.sendVerificationOtp(body, false, true);
    setLoading(false);

    toast(resp['msg'] ?? resp['message'], isError: !resp['status']);
    if (resp['status']) {
      isOtpSent = true;
      setState(() {
        verifySub = "Submit";
      });
    }
  }

  Future<void> saveOtp() async {
    final intialPro = Provider.of<Auth>(context, listen: false);
    if (resp['otp'] == _pinPutController.text) {
      intialPro.emailOtp = _pinPutController.text;
      toast("Email Verified!", isError: false);
      Future.delayed(Duration(milliseconds: 400), () {
        getBack();
      });
    } else {
      toast("Invalid Otp!", isError: true);
    }
  }

  void setLoading(bool val) {
    setState(() => isLoading = val);
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
              height: 10,
            ),
            SafeArea(child: buildAppBar(context, mq)),
            SizedBox(
              height: mq.height * 0.035,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.email,
                  color: kPrimaryLightColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Edit Email',
                  style: TextStyle(
                    fontSize: 32,
                    color: kPrimaryLightColor,
                    fontFamily: 'DebugFreeTrial',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: mq.height * 0.05,
            ),
            Form(
              key: _formKey,
              child: buildEmailTextFieldField(mq),
            ),
            SizedBox(
              height: mq.height * 0.025,
            ),
            Text(
              'Please enter the otp to validate',
              style: TextStyle(
                fontSize: 18,
                color: kPrimaryLightColor,
                fontFamily: 'DebugFreeTrial',
              ),
            ),
            Text(
              'your email',
              style: TextStyle(
                fontSize: 18,
                color: kPrimaryLightColor,
                fontFamily: 'DebugFreeTrial',
              ),
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
            SizedBox(
              height: mq.height * 0.12,
            ),
            isLoading
                ? SpinKitPouringHourglass(color: kSecondaryColor)
                : buildVerifyButton(mq),
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

  Widget buildEmailTextFieldField(Size mq) {
    return Container(
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
          cursorColor: kPrimaryLightColor,
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
              color: kPrimaryLightColor,
              fontWeight: FontWeight.bold,
              fontSize: 12.5),
          decoration: InputDecoration(
            hintText: 'EDIT EMAIL',
            hintStyle: TextStyle(color: kPrimaryLightColor),
            border: InputBorder.none,
          ),
          initialValue: widget.email,
          // ignore: missing_return
          validator: (_value) {
            if (_value.isEmpty) {
              return kEmailNullError;
            }

            if (!emailValidatorRegExp.hasMatch(_value)) {
              return kInvalidEmailError;
            }
          },
          onSaved: (_value) {
            _email = _value;
          },
        ),
      ),
    );
  }

  Widget buildVerifyButton(Size mq) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
          width: mq.width * 0.22, height: mq.height * 0.20),
      child: ElevatedButton(
        onPressed: () {
          save();
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          primary: kPrimaryLightColor,
        ),
        child: Text(
          '$verifySub',
          style: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
    );
  }
}
