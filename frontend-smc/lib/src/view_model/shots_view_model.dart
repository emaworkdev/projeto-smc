import 'package:flutter/material.dart';
import 'package:smc/src/infra/locator.dart';

import '../models/model.dart';
import '../services/service.dart';

class ShotsViewModel extends ChangeNotifier {
  final ShotsService _userService = locator<ShotsService>();

  ShotsViewModel();

  Future<ShotsModel?> inserir(ShotsModel obj) async {
    var result = await _userService.inserir(obj);

    notifyListeners();
    return result;
  }

  Future<ShotsModel?> alterar(ShotsModel obj) async {
    var result = await _userService.alterar(obj);

    notifyListeners();
    return result;
  }

  Future<bool?> start(int id) async {
    var result = await _userService.start(id);
    if (result == false) {
      notifyListeners();
    }
    return result;
  }

  Future<bool?> pause(int id) async {
    var result = await _userService.pause(id);
    if (result == false) {
      notifyListeners();
    }
    return result;
  }

  Future<bool?> excluir(int id) async {
    var result = await _userService.excluir(id);
    if (result == false) {
      notifyListeners();
    }
    return result;
  }
}
