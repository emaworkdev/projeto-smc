import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smc/src/shared/social_page.dart';

class LoginPageRightSide extends StatelessWidget {
  const LoginPageRightSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: Colors.white,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
        ),
        child: Center(
          child: SizedBox(
            height: 400,
            child: Stack(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 12, sigmaX: 12),
                      child: Container(
                        alignment: Alignment.topLeft,
                        color: Colors.white.withOpacity(.3),
                        padding: const EdgeInsets.all(42),
                        child: const Text(
                          "SMC \n - Maturação de chips",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 28.00,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 80,
                    width: 80,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 30, top: 0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: Image.asset(
                      'assets/images/emawork.png',
                      width: 140,
                      height: 140,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 60,
                    width: 60,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 130, bottom: 20),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: SocialPage(
                        image: 'assets/images/google.png',
                        isActive: true,
                        url: "https://emawork.dev"),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 60,
                    width: 60,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: SocialPage(
                        image: 'assets/images/github.png',
                        isActive: true,
                        url: "https://github.com/emaworkdev?tab=repositories"),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 60,
                    width: 60,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 130, bottom: 20),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: SocialPage(
                        image: 'assets/images/youtube.png',
                        isActive: true,
                        url:
                            "https://www.youtube.com/channel/UCAVCsbCls0tUHNOil7If75g"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
