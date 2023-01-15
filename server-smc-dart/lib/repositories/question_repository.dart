import 'package:server_smc/models/question_model.dart';
import 'package:server_smc/services/question_hasura_service.dart';

class QuestionRepository {
  var hasuraUser = QuestionHasuraService();

  Future<String> save(QuestionModel obj) async {
    var ret = '0';
    try {
      if (obj.id != 0) {
        ret = await hasuraUser.update(obj);
      } else {
        ret = await hasuraUser.create(obj);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
    return ret;
  }

  delete(int id) async {
    try {
      await hasuraUser.delete(id);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }
}
