import 'dart:io';

import 'package:com.quizeee.quizeee/models/userWalletModel.dart';
import 'package:com.quizeee.quizeee/provider/apiUrl.dart';
import 'package:com.quizeee.quizeee/provider/mainPro.dart';
import 'package:com.quizeee.quizeee/screens/creatQuiz/webview.dart';
import 'package:com.quizeee.quizeee/screens/wallet/wallet_details.dart';
import 'package:com.quizeee.quizeee/widgets/toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with WidgetsBindingObserver {
  AppLifecycleState state;

  Future<void> getUserWallet() async {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    final resp = await mainPro.getUserWalletData();
    if (!resp['status']) {
      toast(resp['msg'], isError: true);
    }
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState appLifecycleState) {
  //   super.didChangeAppLifecycleState(state);
  //   state = appLifecycleState;
  //   if (state == AppLifecycleState.resumed) {
  //     if (isWebViewLoaded) {
  //       getUserWallet();
  //       setState(() {});
  //       isWebViewLoaded = false;
  //     }
  //   }
  // }

  bool isLoading = false;
  bool isWebViewLoaded = false;
  File image;
  final picker = ImagePicker();
  String profileUrl;

  Future pickImageFromGallery() async {
    try {
      final imageFile = await picker.getImage(source: ImageSource.gallery);
      if (mounted) {
        image = File(imageFile.path);
        if (image.path != null) {
          uploadDocs();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future captureImageFromCamera() async {
    try {
      final imageFile = await picker.getImage(source: ImageSource.camera);
      if (mounted) {
        image = File(imageFile.path);
        profileUrl = null;
        if (image.path != null) {
          uploadDocs();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> uploadDocs() async {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    var body = new FormData.fromMap({
      "userId": mainPro.getUserID,
      "documentImg": image != null
          ? image.path != null
              ? await MultipartFile.fromFile(image.path, filename: 'upload.png')
              : null
          : null
    });
    mainPro.changeLoadingState(true);
    final resp = await mainPro.uploadWalletDocs(body);
    mainPro.changeLoadingState(false);
    toast(resp['msg'], isError: !resp['status']);
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

  Future<void> launchInBrowser(String url) async {
    isWebViewLoaded = true;
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        enableJavaScript: true,
        enableDomStorage: true,
      ).whenComplete(() {
        print("DONE");
      });
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: const Text(
          'QUIZEEE',
          style: TextStyle(
              color: kTextColor,
              fontSize: 40,
              fontWeight: FontWeight.bold,
              fontFamily: 'MajorLeagueDuty',
              decoration: TextDecoration.underline),
        ),
      ),
      body: FutureBuilder(
          future: getUserWallet(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                isLoading) {
              return Center(
                child: SpinKitPouringHourglass(color: kSecondaryColor),
              );
            }
            return Consumer<MainPro>(builder: (context, mainPro, _) {
              final data = mainPro.getUserWallet;
              return Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: mq.height * 0.02,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (ctx) => WalletDetails(
                                  refertotal:
                                      data[0].referralBalance.toString(),
                                  refilltotal: data[0].refillBalance.toString(),
                                  total: (data[0].winningbalance +
                                          data[0].referralBalance +
                                          data[0].refillBalance)
                                      .toString(),
                                  winningtotal:
                                      data[0].winningbalance.toString(),
                                ),
                              ),
                            );
                            // final mainPro =
                            //     Provider.of<MainPro>(context, listen: false);
                            // launchInBrowser(
                            //     ApiUrls.walletRefill + mainPro.getUserID);
                          },
                          child: buildRefillWithdrawAndBalance(
                              mq,
                              (data[0].winningbalance +
                                      data[0].referralBalance +
                                      data[0].refillBalance)
                                  .toString())),
                      SizedBox(
                        height: mq.height * 0.035,
                      ),
                      buildDocumentVerification(mq),
                    ],
                  ),
                  Positioned(
                    child: bottomSheet(mq, data, mainPro),
                    bottom: 0,
                    left: 0,
                    right: 0,
                  ),
                ],
              );
            });
          }),
    );
  }

  Widget buildRefillWithdrawAndBalance(Size mq, String amt) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.only(left: 5),
          width: mq.width * 0.44,
          height: mq.height * 0.12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kPrimaryLightColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'BALANCE',
                style: TextStyle(fontSize: 18, fontFamily: 'DebugFreeTrial'),
              ),
              Text(
                'Rs. $amt',
                style: TextStyle(fontSize: 24, fontFamily: 'DebugFreeTrial'),
              ),
            ],
          ),
        ),
        Column(
          children: [
            GestureDetector(
              onTap: () {
                final mainPro = Provider.of<MainPro>(context, listen: false);
                launchInBrowser(ApiUrls.walletRefill + mainPro.getUserID);
              },
              child: Container(
                margin: EdgeInsets.only(right: 5),
                width: mq.width * 0.44,
                height: mq.height * 0.055,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Center(
                  child: const Text(
                    'REFILL',
                    style:
                        TextStyle(fontSize: 24, fontFamily: 'DebugFreeTrial'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: mq.height * 0.006,
            ),
            GestureDetector(
              onTap: () {
                final mainPro = Provider.of<MainPro>(context, listen: false);
                launchInBrowser(ApiUrls.walletWithdrawAmt + mainPro.getUserID);
              },
              child: Container(
                margin: EdgeInsets.only(right: 5),
                width: mq.width * 0.44,
                height: mq.height * 0.055,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(86, 125, 130, 1),
                ),
                child: Center(
                  child: const Text(
                    'WITHDRAW',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'DebugFreeTrial'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDocumentVerification(Size mq) {
    return Container(
      height: mq.height * 0.22,
      width: mq.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromRGBO(86, 125, 130, 1),
      ),
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Select Documents',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Select Documents To Verify Your Account',
            style: TextStyle(color: kSecondaryColor, fontSize: 9.5),
          ),
          const Text(
            'E.G Aadhar Card,Pan Card',
            style: TextStyle(color: kSecondaryColor, fontSize: 9.5),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: mq.height * 0.065,
            width: mq.width * 0.7,
            child: ElevatedButton(
              onPressed: () {
                openDialogBox();
              },
              child: const Text(
                'UPLOAD DOCUMENTS',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                primary: kPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet(Size mq, List<UserWalletModel> data, MainPro mainPro) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      width: mq.width,
      height: mq.height * 0.30,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            offset: Offset(1.0, 20.0),
            blurRadius: 20.0,
          )
        ],
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(32), topLeft: Radius.circular(32)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: mq.height * 0.025,
          ),
          const Text(
            'RECENT TRANSACTION HISTORY',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(
            height: mq.height * 0.05,
          ),
          data[0].transactions.length >= 1
              ? Expanded(
                  child: ListView(
                    children:
                        List.generate(data[0].transactions.length, (index) {
                      return buildRecentTransactionGradientBar(
                          mq,
                          data[0].transactions[index].amount,
                          mainPro.format.format(DateTime.parse(data[0]
                              .transactions[index]
                              .transactionDateTimestamp)));
                    }),
                  ),
                )
              : Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Center(
                    child: Text(
                      'No Transactions Done Yet!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
          // TextButton(
          //   onPressed: () {},
          //   child: Text(
          //     'VIEW MORE',
          //     style: TextStyle(
          //         color: kSecondaryColor.withOpacity(0.5), fontSize: 10),
          //   ),
          // ),
          // SizedBox(height: 4),
        ],
      ),
    );
  }

  Widget buildRecentTransactionGradientBar(
      Size mq, dynamic money, String date) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: mq.width * 0.025),
      child: Column(
        children: [
          // LinearPercentIndicator(
          //   padding: EdgeInsets.all(4),
          //   lineHeight: 8.0,
          //   percent: (money / 160000) * 100,
          //   backgroundColor: kSecondaryColor.withOpacity(0.4),
          //   progressColor: kPrimaryLightColor,
          // ),
          SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$date',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                '${money}',
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ],
          ),

          Divider()
        ],
      ),
    );
  }
}
