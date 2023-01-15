import 'package:smc/src/infra/biblioteca.dart';
import 'package:smc/src/infra/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import '../../commons.dart';

// ignore: non_constant_identifier_names
BootstrapCol TextFormFieldSwitchBootstrap({
  required BuildContext context,
  required String sizes,
  required String texto,
  String tooltip = '',
  bool isSwitched = false,
  required Function(bool) onPressed,
  Color activeTrackColor = Colors.lightGreenAccent,
  Color activeColor = Colors.green,
  Color textColor = Colors.black,
  Color textBorder = colorAppBar,
}) {
  return BootstrapCol(
    sizes: sizes,
    child: Padding(
      padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
      child: TextFieldSwitchWidget(
        texto: texto,
        tooltip: tooltip,
        isSwitched: isSwitched,
        onPressed: onPressed,
        activeTrackColor: activeTrackColor,
        activeColor: activeColor,
        textColor: textColor,
        textBorder: textBorder,
      ),
    ),
  );
}
