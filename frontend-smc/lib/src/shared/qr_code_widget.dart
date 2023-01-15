// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:smc/src/infra/themes.dart';
import 'package:smc/src/providers/theme_provider.dart';
import 'package:smc/src/utils/image_qr_code_memory.dart';

class QrCodeWidget extends StatelessWidget {
  String qrcode;
  QrCodeWidget({required this.qrcode, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ThemeProvider.instance,
      builder: (context, child) {
        return Container(
          color: ThemeProvider.instance.isDarkTheme ? bgColor : Colors.white,
          height: 400,
          child: Card(
            elevation: 0,
            shadowColor: primaryColor,
            margin: const EdgeInsets.all(20),
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: ThemeProvider.instance.isDarkTheme
                      ? bgColor
                      : Colors.white),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ImageQrCodeMemory(image: qrcode),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
