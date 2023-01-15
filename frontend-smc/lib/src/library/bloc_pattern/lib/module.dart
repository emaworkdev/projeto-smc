import 'package:flutter/material.dart';

import '../bloc_pattern.dart';

abstract class ModuleWidget extends StatelessWidget {
  const ModuleWidget({Key? key}) : super(key: key);

  List<Bloc> get blocs;
  List<Dependency> get dependencies;
  Widget get view;

  Inject get inject => BlocProvider.tag(runtimeType.toString());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      tagText: runtimeType.toString(),
      blocs: blocs,
      dependencies: dependencies,
      child: view,
    );
  }
}
