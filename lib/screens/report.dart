import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constant.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  File image;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        elevation: 0,
        leading: Container(
          height: 45,
          width: 40,
          margin: EdgeInsets.only(
              left: mq.width * 0.024,
              right: mq.width * 0.024,
              top: 7,
              bottom: 7),
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
        title: const Text(
          'REPORT',
          style: TextStyle(
            color: kSecondaryColor,
            fontSize: 40,
            fontFamily: 'DebugFreeTrial',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: mq.height * 0.2,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: kPrimaryLightColor),
              ),
              child: image == null
                  ? Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          size: 35,
                          color: kPrimaryLightColor,
                        ),
                        onPressed: () {
                          openDialogBox();
                        },
                      ),
                    )
                  : Center(
                      child: Container(
                        height: mq.height * 0.2,
                        width: mq.width * 0.5,
                        child: Image.file(
                          image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
            Container(
              height: mq.height * 0.26,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: kPrimaryLightColor),
              ),
              child: TextFormField(
                cursorColor: kSecondaryColor,
                style: TextStyle(color: kSecondaryColor),
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'How can we help you?',
                  hintStyle: TextStyle(color: kSecondaryColor),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: mq.height * 0.15,
            ),
            buildSubmitButton(mq, context),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSubmitButton(Size mq, BuildContext context) {
    return SizedBox(
      height: mq.height * 0.058,
      width: mq.width * 0.55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {},
        child: Text(
          'Submit',
          style: TextStyle(
            color: kPrimaryColor,
            fontFamily: 'DebugFreeTrial',
            fontSize: 28,
          ),
        ),
      ),
    );
  }

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
}
