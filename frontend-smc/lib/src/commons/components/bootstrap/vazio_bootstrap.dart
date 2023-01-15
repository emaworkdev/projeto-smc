import 'package:smc/src/infra/biblioteca.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

// ignore: non_constant_identifier_names
BootstrapCol VazioBootstrap({
  required BuildContext context,
  String sizes = 'col-1 col-sm-1 col-md-1',
}) {
  return BootstrapCol(
    sizes: sizes,
    child: Padding(
      padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
      child: Container(),
    ),
  );
}
