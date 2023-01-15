import 'package:smc/src/infra/themes.dart';
import 'package:flutter/material.dart';

Widget getSwitch(
    {required String texto,
    String tooltip = '',
    bool isSwitched = false,
    required Function(bool) onPressed,
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
        /*decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: textBorder),
          borderRadius: BorderRadius.all(
              Radius.circular(8.0)  
              ),
        ),*/
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

Widget getSwitchBox(
    {required String texto,
    required bool isSwitched,
    required Function(bool) onPressed,
    Color activeTrackColor = Colors.lightGreenAccent,
    Color activeColor = Colors.green,
    Color textColor = Colors.black}) {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.black12,
            border:
                Border.all(color: Colors.black, width: 2.0), // Set border width
            borderRadius: const BorderRadius.all(
                Radius.circular(5.0)), // Set rounded corner radius
            boxShadow: const [
              BoxShadow(
                  blurRadius: 5, color: Colors.black, offset: Offset(1, 2))
            ] // Make rounded corner of border
            ),
        child: Text(
          texto,
          style: const TextStyle(color: Colors.white),
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
