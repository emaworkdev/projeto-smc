import 'package:smc/src/infra/locator.dart';
import 'package:flutter/material.dart';
import 'package:smc/src/services/api/login_service.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginService _loginService = locator<LoginService>();

  Future<dynamic> autenticar(String login, String senha) async {
    var result = await _loginService.autenticar(login, senha);

    notifyListeners();
    return result;
  }

  Future<bool> updatePassword(String email, String codigo) async {
    bool ret = false;
    var result = await _loginService.updatePassword(email, codigo);

    if (result == "true") {
      ret = true;
    }

    notifyListeners();
    return ret;
  }

  Future<void> urlHost() async {
    await _loginService.urlHost();

    notifyListeners();
  }
}
