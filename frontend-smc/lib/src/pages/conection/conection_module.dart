import 'package:flutter/material.dart';

import '../../library/bloc_pattern/bloc_pattern.dart';
import '../../streams/stream.dart';
import '../pages.dart';

class ConectionModule extends ModuleWidget {
  //

  // ignore: use_key_in_widget_constructors
  const ConectionModule();

  @override
  List<Bloc> get blocs => [
        Bloc(
          (i) => WhatsappBloc(),
        ),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => const ConectionPage();
  static Inject get to => Inject<ConectionModule>.of();
}
