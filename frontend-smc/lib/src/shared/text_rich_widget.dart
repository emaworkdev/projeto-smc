import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextRichWidget extends StatelessWidget {
  final String title1;
  final String title2;
  final Color colorTitle1;
  final Color colorTitle2;
  final double fontsizeTitle;

  const TextRichWidget(
      {Key? key,
      required this.title1,
      required this.title2,
      this.colorTitle1 = Colors.white,
      this.colorTitle2 = Colors.white30,
      this.fontsizeTitle = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: fontsizeTitle,
        ),
        children: [
          TextSpan(
            text: title1,
            style: TextStyle(
              color: colorTitle1,
            ),
          ),
          TextSpan(
            text: title2,
            style: TextStyle(
              color: colorTitle2,
            ),
          ),
        ],
      ),
    );
  }
}
