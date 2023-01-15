import 'package:flutter/material.dart';
import 'package:smc/src/infra/locator.dart';

import '../models/model.dart';
import '../services/service.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _userService = locator<UserService>();

  UserViewModel();

  Future<UserModel?> inserir(UserModel obj) async {
    var result = await _userService.inserir(obj);

    notifyListeners();
    return result;
  }

  Future<UserModel?> alterar(UserModel obj) async {
    var result = await _userService.alterar(obj);

    notifyListeners();
    return result;
  }

  Future<bool?> excluir(int id) async {
    var result = await _userService.excluir(id);
    if (result == false) {
      notifyListeners();
    }
    return result;
  }

  Future<bool> updatePassword(String email, String codigo) async {
    bool ret = false;
    var result = await _userService.updatePassword(email, codigo);

    if (result == "true") {
      ret = true;
    }

    notifyListeners();
    return ret;
  }
}
