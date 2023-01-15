import 'package:flutter/material.dart';
import 'package:smc/src/infra/locator.dart';

import '../models/model.dart';
import '../services/service.dart';

class SettingViewModel extends ChangeNotifier {
  final SettingService _settingService = locator<SettingService>();

  SettingViewModel();

  Future<SettingModel?> inserir(SettingModel obj) async {
    var result = await _settingService.inserir(obj);

    notifyListeners();
    return result;
  }

  Future<SettingModel?> alterar(SettingModel obj) async {
    var result = await _settingService.alterar(obj);

    notifyListeners();
    return result;
  }

  Future<bool?> excluir(int id) async {
    var result = await _settingService.excluir(id);
    if (result == false) {
      notifyListeners();
    }
    return result;
  }
}
