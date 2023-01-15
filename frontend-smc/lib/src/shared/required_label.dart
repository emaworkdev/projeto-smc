import 'package:flutter/material.dart';
import 'package:smc/src/shared/app_text.dart';

// ignore: must_be_immutable
class RequiredLabel extends StatelessWidget {
  final String label;
  final bool required;
  Color color;

  // ignore: use_key_in_widget_constructors
  RequiredLabel(this.label, this.required, this.color);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        AppText(
          label,
          bold: true,
          color: color,
        ),
        required
            ? Row(
                children: const <Widget>[
                  SizedBox(width: 6),
                  AppText("*", color: Colors.red),
                ],
              )
            : Container(),
      ],
    );
  }
}
