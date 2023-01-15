import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationFush {
  BuildContext context;
  String message;
  String title;
  FlushbarPosition flushbarPosition;
  Duration duration;
  IconData icon;
  double sizeIcon;
  Color indicatorColor;
  LinearGradient gradient;
  Color backgroundColor;
  Color colorShadow;

  NotificationFush(
      {required this.context,
      required this.message,
      this.title = "smc",
      this.flushbarPosition = FlushbarPosition.TOP,
      this.duration = const Duration(seconds: 6),
      this.icon = FontAwesomeIcons.info,
      this.sizeIcon = 28,
      this.indicatorColor = Colors.white,
      this.gradient =
          const LinearGradient(colors: [Colors.green, Colors.greenAccent]),
      this.backgroundColor = Colors.green,
      this.colorShadow = const Color.fromARGB(255, 46, 125, 50)});

  bar() {
    return Flushbar(
      flushbarPosition: flushbarPosition,
      reverseAnimationCurve: Curves.decelerate,
      leftBarIndicatorColor: indicatorColor,
      title: title,
      message: message,
      icon: Icon(
        icon,
        size: sizeIcon,
        color: Colors.white,
      ),
      duration: duration,
      backgroundGradient: gradient,
      backgroundColor: backgroundColor,
      boxShadows: [
        BoxShadow(
          color: colorShadow,
          offset: const Offset(0.0, 2.0),
          blurRadius: 3.0,
        )
      ],
    )..show(context);
  }
}
