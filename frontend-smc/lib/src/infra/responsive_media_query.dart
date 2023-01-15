import 'package:flutter/material.dart';

class ResponsiveMediaQuery extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;
  final Widget? smallMobile;

  const ResponsiveMediaQuery(
      {Key? key,
      required this.mobile,
      this.tablet,
      required this.desktop,
      this.smallMobile})
      : super(key: key);

// This size work fine on my design, maybe you need some customization depends on your design

  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1200 &&
      MediaQuery.of(context).size.width >= 768;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // If our width is more than 1200 then we consider it a desktop
    if (size.width >= 1200) {
      return desktop;
    }
    // If width it less then 1200 and more then 768 we consider it as tablet
    else if (size.width >= 768 && tablet != null) {
      return tablet!;
    }
    // Or less then that we called it mobile
    // ignore: unnecessary_null_comparison
    else if (size.width >= 376 && size.width <= 768 && mobile != null) {
      return mobile;
    } else {
      return smallMobile!;
    }
  }
}
