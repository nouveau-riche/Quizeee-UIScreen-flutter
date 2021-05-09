import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../provider/initialPro.dart';
import '../../widgets/toast.dart';
import '../../constant.dart';
import '../otp/otp_screen.dart';
import '../../utility/custom_calendar.dart';

enum CalendarViews { dates, months, year }

class DOBImage extends StatefulWidget {
  final String username;
  final String location;
  final String email;
  final String phoneNumber;
  final String referralCode;

  DOBImage(
      {this.username,
      this.location,
      this.email,
      this.phoneNumber,
      this.referralCode});

  @override
  _DOBImageState createState() => _DOBImageState();
}

class _DOBImageState extends State<DOBImage> {
  String imageUrl = '';

  DateTime _currentDateTime;
  DateTime _selectedDateTime;
  List<Calendar> _sequentialDates;
  int midYear;
  CalendarViews _currentView = CalendarViews.dates;
  final List<String> _weekDays = [
    '  M',
    '  T',
    '  W',
    '  T',
    '  F',
    '  S',
    '  S'
  ];
  final List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  File image;
  final picker = ImagePicker();

  // Future pickImageFromGallery() async {
  //   var img = await ImagePicker.pickImage(source: ImageSource.gallery);
  //
  //   setState(() {
  //     image = img;
  //   });
  // }

  Future pickImageFromGallery() async {
    try {
      print('working fine');
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

  Future<void> sendOtp() async {
    var body = {
      "phone": "+91" + widget.phoneNumber,
    };
    final authPro = Provider.of<Auth>(context, listen: false);
    authPro.setLoading(true);

    final response = await authPro.sendVerificationOtp(body, false);
    authPro.setLoading(false);

    if (response['status']) {
      toast(response['msg'], isError: response['status']);
      Future.delayed(Duration(seconds: 1), () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (ctx) => OTPScreen(
              type: 'signup',
              phone: widget.phoneNumber,
              username: widget.username,
              location: widget.location,
              email: widget.email,
              referralCode: widget.referralCode,
              dob: _selectedDateTime,
              image: image,
            ),
          ),
        );
      });
    } else {
      toast(response['msg'], isError: response['status']);
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

  @override
  void initState() {
    super.initState();
    final date = DateTime.now();
    _currentDateTime = DateTime(date.year, date.month);
    _selectedDateTime = DateTime(date.year, date.month, date.day);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() => _getCalendar());
    });
  }

  @override
  void dispose() {
    super.dispose();
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 45,
                  width: 40,
                  margin: EdgeInsets.only(left: 25),
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
                SizedBox(
                  width: mq.width * 0.15,
                ),
              ],
            ),
            SizedBox(
              height: mq.height * 0.02,
            ),
            const Text(
              'SELECT PROFILE PICTURE',
              style: TextStyle(
                color: kTextColor,
                fontFamily: 'DebugFreeTrial',
                fontSize: 28,
              ),
            ),
            SizedBox(
              height: mq.height * 0.02,
            ),
            buildSelectImage(),
            SizedBox(
              height: mq.height * 0.06,
            ),
            const Text(
              'SELECT DATE OF BIRTH',
              style: TextStyle(
                color: kTextColor,
                fontFamily: 'DebugFreeTrial',
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: mq.height * 0.02,
            ),
            Container(
              height: mq.height * 0.07,
              width: mq.width * 0.9,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  // 'DD/MM/YYYY',
                  _selectedDateTime.toString().substring(0, 10),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.only(left: 18, right: 18, top: 2),
              height: mq.height * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: (_currentView == CalendarViews.dates)
                  ? _datesView()
                  : (_currentView == CalendarViews.months)
                      ? _showMonthsList()
                      : _yearsView(midYear ?? _currentDateTime.year),
            ),
            SizedBox(
              height: mq.height * 0.02,
            ),
            Consumer<Auth>(
              builder: (con, auth, _) => auth.isLoading
                  ? CircularProgressIndicator()
                  : ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 68, height: 55),
                      child: ElevatedButton(
                        onPressed: () {
                          sendOtp();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          primary: kTextColor,
                        ),
                        child: const Text(
                          'NEXT',
                          style: TextStyle(
                              fontSize: 12.8,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSelectImage() {
    return GestureDetector(
      onTap: () {
        openDialogBox();
      },
      child: Stack(
        children: [
          CircleAvatar(
            radius: 42,
            backgroundColor: kSecondaryColor,
            child: CircleAvatar(
              radius: 38,
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

  // dates view
  Widget _datesView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 35,
          decoration: BoxDecoration(
              color: kSecondaryColor, borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: <Widget>[
              // prev month button
              _toggleBtn(false),
              // month and year
              Expanded(
                child: InkWell(
                  onTap: () =>
                      setState(() => _currentView = CalendarViews.months),
                  child: Center(
                    child: Text(
                      '${_monthNames[_currentDateTime.month - 1]} ${_currentDateTime.year}',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              // next month button
              _toggleBtn(true),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Flexible(child: _calendarBody()),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  // next / prev month buttons
  Widget _toggleBtn(bool next) {
    return IconButton(
      onPressed: () {
        if (_currentView == CalendarViews.dates) {
          setState(() => (next) ? _getNextMonth() : _getPrevMonth());
        } else if (_currentView == CalendarViews.year) {
          if (next) {
            midYear =
                (midYear == null) ? _currentDateTime.year + 9 : midYear + 9;
          } else {
            midYear =
                (midYear == null) ? _currentDateTime.year - 9 : midYear - 9;
          }
          setState(() {});
        }
      },
      icon: Icon((next) ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
          size: 18),
    );
  }

  // calendar
  Widget _calendarBody() {
    if (_sequentialDates == null) return Container();
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: _sequentialDates.length + 7,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 8,
        crossAxisCount: 7,
        crossAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        if (index < 7) return _weekDayTitle(index);
        if (_sequentialDates[index - 7].date == _selectedDateTime)
          return _selector(_sequentialDates[index - 7]);
        return _calendarDates(_sequentialDates[index - 7]);
      },
    );
  }

  // calendar header
  Widget _weekDayTitle(int index) {
    return Text(
      _weekDays[index],
      style: const TextStyle(color: Colors.white, fontSize: 12),
    );
  }

  // calendar element
  Widget _calendarDates(Calendar calendarDate) {
    return InkWell(
      onTap: () {
        if (_selectedDateTime != calendarDate.date) {
          if (calendarDate.nextMonth) {
            _getNextMonth();
          } else if (calendarDate.prevMonth) {
            _getPrevMonth();
          }
          setState(() => _selectedDateTime = calendarDate.date);
        }
      },
      child: Center(
          child: Text(
        '${calendarDate.date.day}',
        style: TextStyle(
          color: (calendarDate.thisMonth)
              ? kSecondaryColor
              : Colors.white.withOpacity(0.5),
        ),
      )),
    );
  }

  // date selector
  Widget _selector(Calendar calendarDate) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.white, width: 1),
        gradient: LinearGradient(
          colors: [Colors.black.withOpacity(0.1), Colors.white],
          stops: [0.1, 1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            '${calendarDate.date.day}',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  // get next month calendar
  void _getNextMonth() {
    if (_currentDateTime.month == 12) {
      _currentDateTime = DateTime(_currentDateTime.year + 1, 1);
    } else {
      _currentDateTime =
          DateTime(_currentDateTime.year, _currentDateTime.month + 1);
    }
    _getCalendar();
  }

  // get previous month calendar
  void _getPrevMonth() {
    if (_currentDateTime.month == 1) {
      _currentDateTime = DateTime(_currentDateTime.year - 1, 12);
    } else {
      _currentDateTime =
          DateTime(_currentDateTime.year, _currentDateTime.month - 1);
    }
    _getCalendar();
  }

  // get calendar for current month
  void _getCalendar() {
    _sequentialDates = CustomCalendar().getMonthCalendar(
        _currentDateTime.month, _currentDateTime.year,
        startWeekDay: StartWeekDay.monday);
  }

  // show months list
  Widget _showMonthsList() {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () => setState(() => _currentView = CalendarViews.year),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              '${_currentDateTime.year}',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
        ),
        const Divider(
          color: Colors.white,
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: _monthNames.length,
            itemBuilder: (context, index) => ListTile(
              onTap: () {
                _currentDateTime = DateTime(_currentDateTime.year, index + 1);
                _getCalendar();
                setState(() => _currentView = CalendarViews.dates);
              },
              title: Center(
                child: Text(
                  _monthNames[index],
                  style: TextStyle(
                      fontSize: 18,
                      color: (index == _currentDateTime.month - 1)
                          ? Colors.yellow
                          : Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // years list views
  Widget _yearsView(int midYear) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            _toggleBtn(false),
            const Spacer(),
            _toggleBtn(true),
          ],
        ),
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            // physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 0,
            ),
            itemBuilder: (context, index) {
              int thisYear;
              if (index < 4) {
                thisYear = midYear - (4 - index);
              } else if (index > 4) {
                thisYear = midYear + (index - 4);
              } else {
                thisYear = midYear;
              }

              return GestureDetector(
                onTap: () {
                  _currentDateTime = DateTime(thisYear, _currentDateTime.month);
                  _getCalendar();
                  setState(() => _currentView = CalendarViews.months);
                },
                child: Text(
                  '    $thisYear',
                  style: TextStyle(
                      fontSize: 16,
                      color: (thisYear == _currentDateTime.year)
                          ? Colors.yellow
                          : Colors.white),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
