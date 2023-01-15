import 'package:server_smc/models/shots_model.dart';
import 'package:server_smc/services/shots_hasura_service.dart';

class ShotsRepository {
  var hasura = ShotsHasuraService();

  Future<String> save(ShotsModel obj) async {
    var ret = '0';
    try {
      if (obj.id != 0) {
        ret = await hasura.update(obj);
      } else {
        ret = await hasura.create(obj);
      }
    } catch (e, s) {
      print(e);
      print(s);
    }
    return ret;
  }

  start(int id) async {
    try {
      await hasura.start(id);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  pause(int id) async {
    try {
      await hasura.pause(id);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  delete(int id) async {
    try {
      await hasura.delete(id);
    } catch (e, s) {
      print(e);
      print(s);
    }
  }
}
