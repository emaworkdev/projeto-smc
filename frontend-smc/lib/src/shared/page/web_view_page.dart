import 'package:flutter/material.dart';
//ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui' as ui;

class WebViewPage extends StatelessWidget {
  final String url;
  const WebViewPage({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        'hello-world-html',
        (int viewId) => IFrameElement()
          ..width = '640'
          ..height = '360'
          ..src = url
          ..style.border = 'none');
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        width: 640,
        height: height,
        child: const HtmlElementView(viewType: 'hello-world-html'),
      ),
    );
  }
}
