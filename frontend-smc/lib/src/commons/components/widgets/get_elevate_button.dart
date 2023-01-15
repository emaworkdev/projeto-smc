import 'package:smc/src/infra/themes.dart';
import 'package:flutter/material.dart';

Widget getElevationButtom({
  required String texto,
  double xelevation = 20,
  Color textColor = Colors.white,
  Color buttonColor = Colors.blue,
  Color shadow = colorAppBar,
  required Function() onPressed,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: buttonColor,
      disabledForegroundColor: Colors.green.withOpacity(0.38),
      disabledBackgroundColor: Colors.green.withOpacity(0.12),
      elevation: xelevation,
      shadowColor: colorAppBar,
    ),
    onPressed: onPressed,
    child: Text(
      texto,
      style: TextStyle(
        color: textColor,
      ),
    ),
  );
}
