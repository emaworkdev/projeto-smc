import 'package:flutter/material.dart';
import 'package:smc/src/infra/themes.dart';
import 'package:smc/src/providers/theme_provider.dart';

class DropDownWidget {
  /// singleton
  factory DropDownWidget() {
    _this ??= DropDownWidget._();
    return _this!;
  }

  static DropDownWidget? _this;

  DropDownWidget._() : super();

  /// Retorna um DropdownButton
  static AnimatedBuilder getDropDownButton(
      String value, Function(String?) onChanged, List<String> items) {
    return AnimatedBuilder(
      animation: ThemeProvider.instance,
      builder: (context, child) {
        return DropdownButton<String>(
          focusColor:
              ThemeProvider.instance.isDarkTheme ? Colors.white : Colors.black,
          dropdownColor:
              ThemeProvider.instance.isDarkTheme ? bgColor : primaryColor,
          isExpanded: true,
          value: value,
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        );
      },
    );
  }
}
