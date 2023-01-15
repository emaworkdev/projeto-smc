import 'package:flutter/material.dart';
import 'package:smc/src/pages/login/login_page_left_side.dart';
import 'package:smc/src/pages/login/login_page_right_side.dart';
import 'package:smc/src/providers/theme_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: ThemeProvider.instance,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 0),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.blue, Colors.blue[800]!]),
                ),
                child: Row(
                  children: [
                    if (MediaQuery.of(context).size.width > 900)
                      const LoginPageRightSide(),
                    const LoginPageLeftSide(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
