import 'package:flutter/material.dart';

import '../../library/bloc_pattern/bloc_pattern.dart';
import '../../streams/stream.dart';
import '../pages.dart';

class ShotsModule extends ModuleWidget {
  //

  // ignore: use_key_in_widget_constructors
  const ShotsModule();

  @override
  List<Bloc> get blocs => [
        Bloc(
          (i) => ShotsBloc(),
        ),
        Bloc(
          (i) => WhatsappBloc(),
        ),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => const ShotsPage();
  static Inject get to => Inject<ShotsModule>.of();
}
