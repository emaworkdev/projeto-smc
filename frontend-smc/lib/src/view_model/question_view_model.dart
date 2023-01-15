import 'package:flutter/material.dart';
import 'package:smc/src/infra/locator.dart';

import '../models/model.dart';
import '../services/service.dart';

class QuestionViewModel extends ChangeNotifier {
  final QuestionService _questionService = locator<QuestionService>();

  QuestionViewModel();

  Future<QuestionModel?> inserir(QuestionModel obj) async {
    var result = await _questionService.inserir(obj);

    notifyListeners();
    return result;
  }

  Future<QuestionModel?> alterar(QuestionModel obj) async {
    var result = await _questionService.alterar(obj);

    notifyListeners();
    return result;
  }

  Future<bool?> excluir(int id) async {
    var result = await _questionService.excluir(id);
    if (result == false) {
      notifyListeners();
    }
    return result;
  }
}
