import 'package:flutter/material.dart';


class CustomNavigation {
  static void navigate(
      {required BuildContext context, required Widget screen}) {
    Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            transitionDuration: Duration.zero,
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              return FadeTransition(
                opacity: CurvedAnimation(
                    parent: animation, curve: Curves.easeInOutBack),
                child: child ?? Container(),
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return screen;
            }));
  }

  static void pushNavigate(
      {required BuildContext context, required Widget screen}) {
    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration.zero,
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              return FadeTransition(
                opacity: CurvedAnimation(
                    parent: animation, curve: Curves.easeInOutBack),
                child: child,
              );
            },
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secAnimation) {
              return screen;
            }));
  }

  static void pushAndRemoveUntil(
      {required BuildContext context, required Widget destination}) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => destination),
            (Route<dynamic> route) => false);
  }
}
