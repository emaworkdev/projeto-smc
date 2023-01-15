// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ProviderPageController extends InheritedWidget {

  final PageController controller;
  // ignore: annotate_overrides, overridden_fields
  final Widget child;

  // ignore: use_key_in_widget_constructors
  const ProviderPageController({required this.controller, required this.child}):super(child: child);

  static ProviderPageController? of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<ProviderPageController>();
  }


  void toPage(int page){
    controller.animateToPage(page,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
  }


  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return oldWidget != this;
  }
  
}