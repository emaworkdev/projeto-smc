import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

// ignore: must_be_immutable
class SocialPage extends StatefulWidget {
  bool isActive;
  String image;
  String url;

  SocialPage(
      {this.isActive = false,
      required this.image,
      required this.url,
      super.key});

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: (size.height > 900 ? 90 : 70),
      height: (size.height > 900 ? 70 : 50),
      decoration: widget.isActive
          ? BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300]!,
                  spreadRadius: 10,
                  blurRadius: 30,
                )
              ],
              borderRadius: BorderRadius.circular(15),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey[400]!),
            ),
      child: Center(
        child: GestureDetector(
          onTap: () {
            if (widget.url.isNotEmpty) {
              _link(widget.url);
            }
          },
          child: Container(
            decoration: widget.isActive
                ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[400]!,
                        spreadRadius: 2,
                        blurRadius: 15,
                      )
                    ],
                  )
                : const BoxDecoration(),
            child: Image.asset(
              widget.image,
              width: 35,
            ),
          ),
        ),
      ),
    );
  }

  _link(String link) async {
    await launcher.launchUrl(Uri.parse(link));
  }
}
