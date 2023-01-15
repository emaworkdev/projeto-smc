import 'package:flutter/material.dart';
import 'package:smc/src/infra/locator.dart';

import '../models/model.dart';
import '../services/service.dart';

class ConectionViewModel extends ChangeNotifier {
  final ConectionService _conectionService = locator<ConectionService>();

  ConectionViewModel();

  Future<WhatsappModel?> inserir(WhatsappModel obj) async {
    var result = await _conectionService.inserir(obj);

    notifyListeners();
    return result;
  }

  Future<WhatsappModel?> alterar(WhatsappModel obj) async {
    var result = await _conectionService.alterar(obj);

    notifyListeners();
    return result;
  }

  Future<bool?> excluir(int id) async {
    var result = await _conectionService.excluir(id);
    if (result == false) {
      notifyListeners();
    }
    return result;
  }

  start(String session, bool padrao) async {
    await _conectionService.start(session, padrao);
  }

  close(String session, bool padrao) async {
    await _conectionService.close(session, padrao);
  }

  logout(String session, bool padrao) async {
    await _conectionService.logout(session, padrao);
  }
}
