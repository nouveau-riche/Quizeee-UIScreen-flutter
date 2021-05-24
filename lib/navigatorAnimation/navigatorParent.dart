import 'package:flutter/material.dart';

class SlideNavigation extends PageRouteBuilder {
  final Widget widget;

  SlideNavigation({this.widget})
      : super(
            transitionDuration: Duration(milliseconds: 500),
            transitionsBuilder: (BuildContext con, Animation<double> animation,
                Animation<double> secAnimation, Widget child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut);
              // return ScaleTransition(
              //   scale: animation,
              //   alignment: Alignment.center,
              //   child: child,
              // );
              return SlideTransition(
                transformHitTests: true,
                position:
                    Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
                        .animate(animation),
                textDirection: TextDirection.ltr,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secanimation) {
              return widget;
            });
}

class FadeNavigation extends PageRouteBuilder {
  final Widget widget;

  FadeNavigation({this.widget})
      : super(
            transitionDuration: Duration(milliseconds: 650),
            transitionsBuilder: (BuildContext con, Animation<double> animation,
                Animation<double> secAnimation, Widget child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.easeInOut);
              // return ScaleTransition(
              //   scale: animation,
              //   alignment: Alignment.center,
              //   child: child,
              // );
              return FadeTransition(
                opacity: animation,
                alwaysIncludeSemantics: true,

                // position: Tween<Offset>(
                //         begin: const Offset(10.0, 10.0), end: Offset.zero)
                //     .animate(animation),
                // textDirection: TextDirection.ltr,
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secanimation) {
              return widget;
            });
}
