import 'package:com.quizeee.quizeee/provider/mainPro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';

class PerformanceChartScreen extends StatefulWidget {
  @override
  _PerformanceChartScreenState createState() => _PerformanceChartScreenState();
}

class _PerformanceChartScreenState extends State<PerformanceChartScreen> {
  bool isLoading = false;
  Future<void> getCategory() async {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    changeLoadingState(true);
    final resp = await mainPro.getUserPerformanceCategory();
    if (mainPro.performaceCategory[0].assignedGraph.isNotEmpty) {
      await mainPro.getUserPerformanceSubCategory(
          mainPro.performaceCategory[0].assignedGraph[0].category);
      await reCall();
      mainPro.initialAssCate(
          mainPro.performaceCategory[0].assignedGraph[0].category);
      mainPro.initialPubCate(
          mainPro.performaceCategory[0].publicGraph[0].category);
    }

    // await mainPro.getUserPerformanceAreaOfInterest(
    //     mainPro.performaceCategory[0].assignedGraph[0].category,
    //     mainPro.performaceSubCategory[0].assignedGraph[0].category);
    // if (mainPro.performaceAreaOfInterest.isNotEmpty) {
    //   mainPro.initialAssSubCate(
    //       mainPro.performaceSubCategory[0].assignedGraph[0].category);
    //   mainPro.initialPubSubCate(
    //       mainPro.performaceSubCategory[0].publicGraph[0].category);
    // }

    changeLoadingState(false);
  }

  changeLoadingState(bool val) {
    setState(() => isLoading = val);
  }

  Future<void> reCall() async {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    if (mainPro.performaceSubCategory.isNotEmpty) {
      await mainPro.getUserPerformanceAreaOfInterest(
          mainPro.performaceCategory[0].assignedGraph[0].category,
          mainPro.performaceSubCategory[0].assignedGraph[0].category);
      if (mainPro.performaceAreaOfInterest.isNotEmpty) {
        mainPro.initialAssSubCate(
            mainPro.performaceSubCategory[0].assignedGraph[0].category);
        mainPro.initialPubSubCate(
            mainPro.performaceSubCategory[0].publicGraph[0].category);
      }
    }
  }

  onChanage(String value, int type, String forData) async {
    final mainPro = Provider.of<MainPro>(context, listen: false);
    try {
      changeLoadingState(true);
      if (type == 0) {
        // assigned
        if (forData == "subCate") {
          mainPro.initialAssCate(value);
          await mainPro.getUserPerformanceSubCategory(value);
          await reCall();
        } else if (forData == "AOI") {
          mainPro.initialAssSubCate(value);
          await mainPro.getUserPerformanceAreaOfInterest(
              mainPro.selectedAssCategory, value);
        }
      } else {
        // public
        if (forData == "subCate") {
          mainPro.initialPubCate(value);
          await mainPro.getUserPerformanceSubCategory(value);
          await reCall();
        } else if (forData == "AOI") {
          mainPro.initialPubSubCate(value);
          await mainPro.getUserPerformanceAreaOfInterest(
              mainPro.selectedPubCategory, value);
        }
      }
    } catch (e) {
      print(e);
    } finally {
      changeLoadingState(false);
    }
  }

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: isLoading
          ? Center(
              child: SpinKitPouringHourglass(color: kSecondaryColor),
            )
          : Consumer<MainPro>(builder: (context, mainPro, _) {
              // assigned
              final assignedCate =
                  mainPro.performaceCategory[0].assignedGraph.isEmpty
                      ? []
                      : mainPro.performaceCategory[0].assignedGraph;
              final assignedSubCate = mainPro.performaceSubCategory.isNotEmpty
                  ? mainPro.performaceSubCategory[0].assignedGraph.isNotEmpty
                      ? mainPro.performaceSubCategory[0].assignedGraph
                      : []
                  : [];
              final assignedAOI = mainPro.performaceAreaOfInterest.isNotEmpty
                  ? mainPro.performaceAreaOfInterest[0].assignedGraph.isNotEmpty
                      ? mainPro.performaceAreaOfInterest[0].assignedGraph
                      : []
                  : [];

              // public
              final publicCate =
                  mainPro.performaceCategory[0].publicGraph.isEmpty
                      ? []
                      : mainPro.performaceCategory[0].publicGraph;
              final publicSubCate = mainPro.performaceSubCategory.isNotEmpty
                  ? mainPro.performaceSubCategory[0].publicGraph.isNotEmpty
                      ? mainPro.performaceSubCategory[0].publicGraph
                      : []
                  : [];
              final publicAOI = mainPro.performaceAreaOfInterest.isNotEmpty
                  ? mainPro.performaceAreaOfInterest[0].publicGraph.isNotEmpty
                      ? mainPro.performaceAreaOfInterest[0].publicGraph
                      : []
                  : [];

              bool isAssigned = mainPro.selectedType == 0;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: mq.height * 0.05,
                    ),
                    buildAppBar(context, mq),
                    SizedBox(
                      height: mq.height * 0.025,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: buildViewScore(mq, context, onTap: () {
                              mainPro.toggleType(0);
                            },
                                type: mainPro.selectedType == 0
                                    ? kPrimaryLightColor
                                    : Colors.grey,
                                title: "Assigned"),
                          ),
                          SizedBox(
                            width: mq.width * 0.035,
                          ),
                          Expanded(
                            child: buildViewScore(mq, context, onTap: () {
                              mainPro.toggleType(1);
                            },
                                type: mainPro.selectedType == 1
                                    ? kPrimaryLightColor
                                    : Colors.grey,
                                title: "Public"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: mq.height * 0.025,
                    ),
                    mainPro.selectedType == 0
                        ?
                        // Assigned
                        Column(
                            children: [
                              SizedBox(
                                height: mq.height * 0.025,
                              ),
                              buildHeader(mq, context, 'CATEGORY'),
                              SizedBox(
                                height: mq.height * 0.025,
                              ),
                              // category
                              assignedCate.isEmpty
                                  ? emptyChart("No Data available")
                                  : buildChart(mq, assignedCate),
                              SizedBox(
                                height: mq.height * 0.025,
                              ),

                              Column(
                                // Sub-Cate
                                children: [
                                  buildHeader(mq, context, 'SUB-CATEGORY'),
                                  SizedBox(
                                    height: mq.height * 0.01,
                                  ),
                                  assignedCate.isNotEmpty
                                      ? buildDropDownField(
                                          mq,
                                          mainPro.selectedAssCategory,
                                          "subCate",
                                          data: assignedCate,
                                          onTap: onChanage,
                                          type: 0)
                                      : Container(),
                                  SizedBox(
                                    height: mq.height * 0.025,
                                  ),
                                  assignedSubCate.isEmpty
                                      ? emptyChart("No Data available")
                                      : buildChart(
                                          mq,
                                          isAssigned
                                              ? assignedSubCate
                                              : publicSubCate),
                                  SizedBox(
                                    height: mq.height * 0.025,
                                  ),
                                ],
                              ),

                              Column(
                                // AOI
                                children: [
                                  buildHeader(mq, context, 'AREA OF INTEREST'),
                                  SizedBox(
                                    height: mq.height * 0.01,
                                  ),
                                  assignedSubCate.isNotEmpty
                                      ? buildDropDownField(mq,
                                          mainPro.selectedAssSubCategory, "AOI",
                                          data: assignedSubCate,
                                          onTap: onChanage,
                                          type: 0)
                                      : Container(),
                                  SizedBox(
                                    height: mq.height * 0.025,
                                  ),
                                  assignedAOI.isEmpty
                                      ? emptyChart("No Data available")
                                      : buildChart(mq,
                                          isAssigned ? assignedAOI : publicAOI),
                                  SizedBox(
                                    height: mq.height * 0.04,
                                  ),
                                ],
                              ),
                            ],
                          )
                        :

                        // public
                        Column(
                            children: [
                              SizedBox(
                                height: mq.height * 0.025,
                              ),
                              buildHeader(mq, context, 'CATEGORY'),
                              SizedBox(
                                height: mq.height * 0.025,
                              ),
                              publicCate.isEmpty
                                  ? emptyChart("No Data available")
                                  : buildChart(mq, publicCate),
                              SizedBox(
                                height: mq.height * 0.025,
                              ),
                              Column(
                                // Sub-Cate
                                children: [
                                  buildHeader(mq, context, 'SUB-CATEGORY'),
                                  SizedBox(
                                    height: mq.height * 0.01,
                                  ),
                                  publicCate.isNotEmpty
                                      ? buildDropDownField(
                                          mq,
                                          mainPro.selectedPubCategory,
                                          "subCate",
                                          data: publicCate,
                                          onTap: onChanage,
                                          type: 1)
                                      : Container(),
                                  SizedBox(
                                    height: mq.height * 0.025,
                                  ),
                                  publicSubCate.isEmpty
                                      ? emptyChart("No Data available")
                                      : buildChart(mq, publicSubCate),
                                  SizedBox(
                                    height: mq.height * 0.025,
                                  ),
                                ],
                              ),
                              Column(
                                //AOI
                                children: [
                                  buildHeader(mq, context, 'AREA OF INTEREST'),
                                  SizedBox(
                                    height: mq.height * 0.01,
                                  ),
                                  publicSubCate.isEmpty
                                      ? Container()
                                      : buildDropDownField(mq,
                                          mainPro.selectedPubSubCategory, "AOI",
                                          data: publicSubCate,
                                          onTap: onChanage,
                                          type: 1),
                                  SizedBox(
                                    height: mq.height * 0.025,
                                  ),
                                  publicAOI.isEmpty
                                      ? emptyChart("No Data available")
                                      : buildChart(mq, publicAOI),
                                  SizedBox(
                                    height: mq.height * 0.025,
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ],
                ),
              );
            }),
    );
  }

  Container emptyChart(String title) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            '$title',
            style: TextStyle(
                color: Colors.white, fontSize: 15, letterSpacing: 1.2),
          ),
        ),
      ),
    );
  }

  Widget buildViewScore(Size mq, BuildContext context,
      {Color type, Function onTap, String title}) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        height: mq.height * 0.055,
        width: mq.width * 0.25,
        decoration: BoxDecoration(
          color: type,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '$title',
              style: TextStyle(
                  fontFamily: 'RapierZero',
                  color: Colors.black,
                  fontSize: 15,
                  letterSpacing: 1.2),
            ),
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
        SizedBox(
          width: mq.width * 0.05,
        ),
        Text(
          'PERFORMANCE CHART',
          style: TextStyle(fontSize: 22, color: kSecondaryColor),
        ),
      ],
    );
  }

  int index = 0;

  Widget buildHeader(Size mq, BuildContext context, String type) {
    return Container(
      height: mq.height * 0.065,
      width: mq.width,
      margin: EdgeInsets.symmetric(horizontal: mq.width * 0.1),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            kPrimaryColor,
            kSecondaryColor.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          type,
          style: TextStyle(
              color: kPrimaryLightColor,
              fontWeight: FontWeight.bold,
              fontSize: 12.5),
        ),
      ),
    );
  }

  Widget buildDropDownField(Size mq, String value, String from,
      {dynamic data, Function onTap, int type}) {
    try {
      return Container(
        width: mq.width,
        margin: EdgeInsets.symmetric(
            horizontal: mq.width * 0.1, vertical: mq.height * 0.015),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              kSecondaryColor.withOpacity(0.5),
              kSecondaryColor.withOpacity(0.1)
            ],
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          width: mq.width,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(25),
          ),
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              style: TextStyle(
                  color: kPrimaryLightColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5),
              value: value,
              items: List.generate(data.length, (index) {
                return DropdownMenuItem(
                  child: Text(
                    data[index].category.toString(),
                    style: TextStyle(
                        color: kPrimaryLightColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.5),
                  ),
                  value: data[index].category.toString(),
                );
              }),
              onChanged: (value) {
                onTap(value, type, from);
              },
            ),
          ),
        ),
      );
    } catch (e) {
      return Container();
    }
  }

  Widget buildChart(Size mq, [dynamic data]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildYAxis(mq),
        Column(
          children: [
            Container(
              height: mq.height * 0.24,
              width: mq.width * 0.8,
              margin: EdgeInsets.only(left: 2),
              child: Container(
                height: mq.height * 0.24,
                width: mq.width * 0.8,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: kSecondaryColor, width: 1.5),
                    left: BorderSide(color: kSecondaryColor, width: 1.5),
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Divider(
                          color: kSecondaryColor,
                        ),
                        SizedBox(
                          height: mq.height * 0.046,
                        ),
                        Divider(
                          color: kSecondaryColor,
                        ),
                        SizedBox(
                          height: mq.height * 0.046,
                        ),
                        Divider(
                          color: kSecondaryColor,
                        ),
                        SizedBox(
                          height: mq.height * 0.046,
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: List.generate(data.length, (index) {
                              return Row(
                                children: [
                                  SizedBox(
                                    width: mq.width * 0.05,
                                  ),
                                  buildGraphBar(
                                      mq,
                                      double.parse(data[index]
                                          .winningPercentage
                                          .toString())),
                                ],
                              );
                            })

                            // [
                            //   SizedBox(
                            //     width: mq.width * 0.05,
                            //   ),
                            //   buildGraphBar(mq, 20),
                            //   SizedBox(
                            //     width: mq.width * 0.05,
                            //   ),
                            //   buildGraphBar(mq, 40),
                            //   SizedBox(
                            //     width: mq.width * 0.05,
                            //   ),
                            //   buildGraphBar(mq, 50),
                            //   SizedBox(
                            //     width: mq.width * 0.05,
                            //   ),
                            //   buildGraphBar(mq, 60.0),
                            //   SizedBox(
                            //     width: mq.width * 0.05,
                            //   ),
                            //   buildGraphBar(mq, 10.0),
                            // ],
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: mq.width * 0.86,
              margin: EdgeInsets.only(left: 2, top: 4),
              child: Row(
                  children: List.generate(data.length ?? 0, (index) {
                return Row(
                  children: [
                    SizedBox(
                      width: mq.width * 0.05,
                    ),
                    Container(
                      width: mq.width * 0.10,
                      margin: EdgeInsets.only(left: 4),
                      child: Tooltip(
                        message: data[index].category ?? "None",
                        child: Text(
                          data[index].category ?? "None",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: kPrimaryLightColor, fontSize: 8.5),
                        ),
                      ),
                    ),
                  ],
                );
              })

                  // [
                  //   SizedBox(
                  //     width: mq.width * 0.08,
                  //   ),
                  //   Container(
                  //     width: 30,
                  //     margin: EdgeInsets.only(left: 4),
                  //     child: Text(
                  //       'Math',
                  //       style:
                  //           TextStyle(color: kPrimaryLightColor, fontSize: 8.5),
                  //     ),
                  //   ),
                  //   SizedBox(
                  //     width: mq.width * 0.05,
                  //   ),
                  //   Container(
                  //     width: 30,
                  //     child: Text(
                  //       'Science',
                  //       style:
                  //           TextStyle(color: kPrimaryLightColor, fontSize: 8.5),
                  //     ),
                  //   ),
                  //   SizedBox(
                  //     width: mq.width * 0.05,
                  //   ),
                  //   Container(
                  //     width: 30,
                  //     margin: EdgeInsets.only(left: 2),
                  //     child: Text(
                  //       'Java',
                  //       style:
                  //           TextStyle(color: kPrimaryLightColor, fontSize: 8.5),
                  //     ),
                  //   ),
                  //   SizedBox(
                  //     width: mq.width * 0.05,
                  //   ),
                  //   Container(
                  //     width: 30,
                  //     child: Text(
                  //       'History',
                  //       style:
                  //           TextStyle(color: kPrimaryLightColor, fontSize: 8.5),
                  //     ),
                  //   ),
                  //   SizedBox(
                  //     width: mq.width * 0.05,
                  //   ),
                  //   Container(
                  //     width: 30,
                  //     margin: EdgeInsets.only(left: 2),
                  //     child: Text(
                  //       'Games',
                  //       style:
                  //           TextStyle(color: kPrimaryLightColor, fontSize: 8.5),
                  //     ),
                  //   ),
                  // ],
                  ),
            )
          ],
        ),
      ],
    );
  }

  Widget buildYAxis(Size mq) {
    return Container(
      height: mq.height * 0.24,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: mq.height * 0.005,
          ),
          Text(
            '60',
            style: TextStyle(color: kPrimaryLightColor, fontSize: 9),
          ),
          SizedBox(
            height: mq.height * 0.045,
          ),
          Text(
            '40',
            style: TextStyle(color: kPrimaryLightColor, fontSize: 9),
          ),
          SizedBox(
            height: mq.height * 0.045,
          ),
          Text(
            '20',
            style: TextStyle(color: kPrimaryLightColor, fontSize: 9),
          ),
          SizedBox(
            height: mq.height * 0.045,
          ),
          Text(
            '00',
            style: TextStyle(color: kPrimaryLightColor, fontSize: 9),
          ),
        ],
      ),
    );
  }

  Widget buildGraphBar(Size mq, double score) {
    double height = mq.height * 0.062;

    double sc = score / 20.0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: height * sc,
      width: 22,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    );
  }
}
