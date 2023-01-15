import 'package:flutter/material.dart';
import 'package:smc/src/streams/setting_bloc.dart';

import '../../library/bloc_pattern/bloc_pattern.dart';
import '../pages.dart';

class ConfigurationsModule extends ModuleWidget {
  //

  // ignore: use_key_in_widget_constructors
  const ConfigurationsModule();

  @override
  List<Bloc> get blocs => [
        Bloc(
          (i) => SettingBloc(),
        ),
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => const ConfigurationsPage();
  static Inject get to => Inject<ConfigurationsModule>.of();
}
