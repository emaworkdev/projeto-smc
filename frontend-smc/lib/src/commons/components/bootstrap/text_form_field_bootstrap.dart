import 'package:smc/src/infra/biblioteca.dart';
import 'package:smc/src/utils/view_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import '../../commons.dart';

// ignore: non_constant_identifier_names
BootstrapCol TextFormFieldBootstrap({
  required BuildContext context,
  required String sizes,
  required int maxLength,
  required String initialValue,
  required String decorationTitle,
  required String decorationHint,
  bool decorationPadding = false,
  bool caseUpperLower = false,
  required bool upperCase,
  FormFieldValidator<String>? validator,
  required bool enabled,
  required Function onSaved,
  required Function onChanged,
  bool autofocus = true,
  int maxLines = 1,
  bool readOnly = false,
  IconData? icon,
  TextInputType? keyboardType,
  TextAlign textAlign = TextAlign.start,
}) {
  return BootstrapCol(
    sizes: sizes,
    child: Padding(
      padding: Biblioteca.distanciaEntreColunasQuebraLinha(context),
      child: TextFormField(
        readOnly: readOnly,
        autofocus: autofocus,
        maxLength: maxLength,
        maxLines: maxLines,
        enabled: enabled,
        textAlign: textAlign,
        // ignore: unnecessary_null_comparison
        keyboardType: (keyboardType != null) ? keyboardType : null,
        initialValue: initialValue,
        inputFormatters: caseUpperLower
            ? [
                upperCase ? UpperCaseTextFormatter() : LowerCaseTextFormatter(),
              ]
            : [],
        decoration: (icon != null)
            ? ViewUtil.getInputDecorationIconPersistePage(
                decorationHint,
                // ignore: unnecessary_null_comparison
                decorationTitle + (validator != null ? ' *' : ''),
                decorationPadding,
                icon)
            : ViewUtil.getInputDecorationPersistePage(
                decorationHint,
                // ignore: unnecessary_null_comparison
                decorationTitle + (validator != null ? ' *' : ''),
                decorationPadding),
        validator: validator,
        onSaved: (value) {
          onSaved(value);
        },
        onChanged: (text) {
          onChanged(text);
        },
      ),
    ),
  );
}
