import 'package:smc/src/infra/biblioteca.dart';
import 'package:smc/src/utils/view_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

// ignore: non_constant_identifier_names
BootstrapCol TextFormFieldIdBootstrap({
  required BuildContext context,
  required String sizes,
  required String initialValue,
}) {
  return BootstrapCol(
    sizes: sizes,
    child: Padding(
      padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
      child: TextFormField(
        maxLength: 14,
        maxLines: 1,
        readOnly: true,
        enabled: false,
        textAlign: TextAlign.end,
        initialValue: initialValue,
        decoration: ViewUtil.getInputDecorationPersistePage(
            'Informe o id', 'ID:', false),
        onSaved: (value) {},
        onChanged: (text) {},
      ),
    ),
  );
}
