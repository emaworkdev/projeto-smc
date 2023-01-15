import 'package:flutter/material.dart';

import '../../library/bloc_pattern/bloc_pattern.dart';
import '../../streams/stream.dart';
import '../pages.dart';

class QuestionsModule extends ModuleWidget {
  //

  // ignore: use_key_in_widget_constructors
  const QuestionsModule();

  @override
  List<Bloc> get blocs => [
        Bloc(
          (i) => QuestionBloc(),
        ),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => const QuestionsPage();
  static Inject get to => Inject<QuestionsModule>.of();
}
