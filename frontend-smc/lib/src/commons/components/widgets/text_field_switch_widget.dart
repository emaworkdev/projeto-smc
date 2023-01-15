import 'package:smc/src/infra/themes.dart';
import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget TextFieldSwitchWidget(
    {required String texto,
    String tooltip = '',
    bool isSwitched = false,
    bool decoration = false,
    required Function(bool)? onPressed,
    Color activeTrackColor = Colors.lightGreenAccent,
    Color activeColor = Colors.green,
    Color textColor = Colors.black,
    Color textBorder = colorAppBar}) {
  return Row(
    children: [
      Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(2),
        alignment: Alignment.center,
        decoration: decoration
            ? BoxDecoration(
                border: Border.all(width: 1.0, color: textBorder),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              )
            : null,
        child: Tooltip(
          message: tooltip,
          child: Text(
            texto,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      Center(
        child: Switch(
          value: isSwitched,
          onChanged: onPressed,
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.green,
        ),
      ),
    ],
  );
}
