import 'package:flutter/material.dart';

import '../constant.dart';

class CenterLoader extends StatelessWidget {
  bool isScaffoldRequired;
  CenterLoader({
    @required this.isScaffoldRequired,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    if (isScaffoldRequired) {
      return buildContainer(mq);
    }
    return buildContainer(mq);
  }

  Container buildContainer(Size mq) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Container(
          width: mq.width * 0.50,
          height: mq.height * 0.15,
          decoration: BoxDecoration(
              color: kPrimaryColor, borderRadius: BorderRadius.circular(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              CircularProgressIndicator(),
              Spacer(),
              Text("Loading....",
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SairaStencilOne',
                  )),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}